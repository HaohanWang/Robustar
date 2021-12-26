#!/bin/bash

######################################################################
# CLI for running Robustar docker image
######################################################################

#Set Script Name variable
SCRIPT=robustar

#Initialize variables to default values.
OPT_PORT=8000
OPT_IMAGE_TAG=latest
OPT_NAME=robustar

RUN_MODE='HELP'
TRAIN_FOLDER='./'
TEST_FOLDER='./'
INFLU_FOLDER='./'
CHECK_FOLDER='./'
CONFIG_FILE='configs.json'
CUDA_VERSION=''

# Discover platform and set default IP depending on it.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  IP=localhost
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  IP=`docker-machine ip default`  # for Mac  
elif [[ "$OSTYPE" == "cygwin" ]]; then
  # POSIX compatibility layer and Linux environment emulation for Windows
  IP="" # Docker IP for Windows
else
  echo "Running on unrecognized platform"
fi

#Set fonts for Help.
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

#Help function
function HELP {
  echo -e \\n"Help documentation for ${BOLD}${SCRIPT}.${NORM}"\\n
  echo -e "${REV}Basic usage:${NORM} ${BOLD}${SCRIPT} -m [command]${NORM} [options]"\\n
  echo -e "[command] can be one of the following: setup, run."\\n
  echo -e "${BOLD}setup${NORM} will prepare and pull the docker image, and create a new container for it."\\n
  echo -e "${BOLD}run${NORM} will start to run the system."\\n
  # echo -e "${BOLD}gulp${NORM} will start gulp (which should not be expected to return). ${BOLD}gulp${NORM} can only be run if a container is already running (most likely from running robustar run)."\\n
  echo "Command line switches [options] are optional. The following switches are recognized."
  echo "${REV}-p${NORM}  --Sets the value for the ${BOLD}port docker forwards to${NORM}. Default is ${BOLD}${OPT_PORT}${NORM}."
  echo "${REV}-a${NORM}  --Sets the value for the ${BOLD}tag of the image${NORM}. Default is ${BOLD}${OPT_IMAGE_TAG}${NORM}."
  echo "${REV}-n${NORM}  --Sets the value for the ${BOLD}name of the docker container${NORM}. Default is ${BOLD}${OPT_NAME}${NORM}."
  echo "${REV}-t${NORM}  --Sets the path of ${BOLD}training images folder${NORM}. Currently only supports the PyTorch DataLoader folder structure as following"
  echo $'\t\t images/\n \t\t\t dogs/\n \t\t\t\t 1.png\n \t\t\t\t 2.png\n \t\t\t cats/\n \t\t\t\t adc.png\n \t\t\t\t eqx.png'
  echo "${REV}-e${NORM}  --Sets the path of ${BOLD}testing images folder${NORM}. Currently only supports the PyTorch DataLoader folder structure"
  echo "${REV}-i${NORM}  --Sets the path of ${BOLD}the calculation result of the influence function${NORM}."
  echo "${REV}-c${NORM}  --Sets the path of ${BOLD}model check points folder${NORM}."
  echo "${REV}-o${NORM}  --Sets the path of ${BOLD}configuration file${NORM}. Default is ${BOLD}${CONFIG_FILE}${NORM}."
  echo -e "${REV}-h${NORM}  --Displays this help message. No further functions are performed."\\n
  # echo -e "Example: ${BOLD}$SCRIPT -p 8000 -t tag1 -n foo run${NORM}"\\n
}

function SETUP {
    # bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'
    docker pull $IMAGE_NAME
}

function RUN {
  docker run --name ${OPT_NAME} -it -d \
    -p 127.0.0.1:${OPT_PORT}:80 \
    -p 127.0.0.1:6848:8000 \
    -p 127.0.0.1:6006:6006 \
    --mount type=bind,source=${TRAIN_FOLDER},target=/Robustar2/dataset/train \
    --mount type=bind,source=${TEST_FOLDER},target=/Robustar2/dataset/test \
    --mount type=bind,source=${INFLU_FOLDER},target=/Robustar2/influence_images \
    --mount type=bind,source=${CHECK_FOLDER},target=/Robustar2/checkpoint_images \
    -v $CONFIG_FILE:/Robustar2/configs.json \
    --gpus all \
    $IMAGE_NAME && echo "Robustar is available at http://localhost:$OPT_PORT "
    # /bin/bash /run.sh && xdg-open "http://${IP}:${OPT_PORT}" \
  # docker cp ${CONFIG_FILE} ${OPT_NAME}:/Robustar2/configs.json
}


### Start getopts code ###

#Parse command line flags
#If an option should be followed by an argument, it should be followed by a ":".
#Notice there is no ":" after "h". The leading ":" suppresses error messages from
#getopts. This is required to get my unrecognized option code to work.

while getopts :m:p:a:n:t:e:i:c:o:h FLAG; do
  case $FLAG in
    m) 
      RUN_MODE=$OPTARG
      ;;
    p)
      OPT_PORT=$OPTARG
      ;;
    a)
      OPT_IMAGE_TAG=$OPTARG
      ;;
    n)
      OPT_NAME=$OPTARG
      ;;
    t)
      TRAIN_FOLDER=$OPTARG
      ;;
    e)
      TEST_FOLDER=$OPTARG
      ;;
    i)
      INFLU_FOLDER=$OPTARG
      ;;
    c)
      CHECK_FOLDER=$OPTARG
      ;;
    o)
      CONFIG_FILE=$OPTARG
      ;;
    h)
      HELP
      exit 0
      ;;
    \?) #unrecognized option - show help
      echo -e \\n"Option -${BOLD}$OPTARG${NORM} not allowed."
      # HELP
      #If you just want to display a simple error message instead of the full
      #help, remove the 2 lines above and uncomment the 2 lines below.
      echo -e "Use ${BOLD}$SCRIPT -h${NORM} to see the help documentation."\\n
      exit 2
      ;;
  esac
done
### End getopts code ###

#Check the number of arguments. If none are passed, print help and exit.
NUMARGS=$#
if [ $NUMARGS -eq 0 ]; then
  HELP
  exit 1
fi

### Main loop to process command ###
IMAGE_NAME="paulcccccch/robustar:${OPT_IMAGE_TAG}"

if [ "$RUN_MODE" == "setup" ]; then
  SETUP
  exit 0
elif [ "$RUN_MODE" == "run" ]; then
  RUN
  exit 0
else
  HELP
  exit 1
fi

### End main loop ###
exit 0
