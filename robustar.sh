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

TRAIN_FOLDER='./'
TEST_FOLDER='./'
INFLU_FOLDER='./'
CHECK_FOLDER='./'
CONFIG_FILE='config.txt'

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
  'echo "Running on unrecognized platform" '
fi

#Set fonts for Help.
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

#Help function
function HELP {
  echo -e \\n"Help documentation for ${BOLD}${SCRIPT}.${NORM}"\\n
  echo -e "${REV}Basic usage:${NORM} ${BOLD}${SCRIPT} [command]${NORM}"\\n
  echo -e "[command] can be one of the following: setup, run."\\n
  echo -e "${BOLD}setup${NORM} will prepare and pulling the docker image."\\n
  echo -e "${BOLD}run${NORM} will start to run the system."\\n
  # echo -e "${BOLD}gulp${NORM} will start gulp (which should not be expected to return). ${BOLD}gulp${NORM} can only be run if a container is already running (most likely from running robustar run)."\\n
  echo "Command line switches are optional. The following switches are recognized."
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
    docker pull cdonglin/robustar:$OPT_IMAGE_TAG
}

function RUN {
  docker run --name ${OPT_NAME} \
      -ti \ 
      -p 127.0.0.1:${OPT_PORT}:8000 \
      cdonglin/robustar:${OPT_IMAGE_TAG} \
      --mount type=bind,source=${TRAIN_FOLDER},target=/Robustar2/datset/train \
      --mount type=bind,source=${TEST_FOLDER},target=/Robustar2/dataset/test \
      --mount type=bind,source=${INFLU_FOLDER},target=/Robustar2/influence_images \
      --mount type=bind,source=${CHECK_FOLDER},target=/Robustar2/checkpoint_images \
      -v ${CONFIG_FILE}:/config.txt \
      /bin/bash /run.sh && xdg-open "http://${IP}:${OPT_PORT}"
}


### Start getopts code ###

#Parse command line flags
#If an option should be followed by an argument, it should be followed by a ":".
#Notice there is no ":" after "h". The leading ":" suppresses error messages from
#getopts. This is required to get my unrecognized option code to work.

while getopts :p:a:n:h FLAG; do
  case $FLAG in
    p)  #set option "a"
      OPT_PORT=$OPTARG
      ;;
    a)  #set option "b"
      OPT_IMAGE_TAG=$OPTARG
      ;;
    n)  #set option "c"
      OPT_NAME=$OPTARG
      ;;
    t)  #set option "d"
      TRAIN_FOLDER=$OPTARG
      ;;
    e)  #set option "e"
      TEST_FOLDER=$OPTARG
      ;;
    i)  #set option "f"
      INFLU_FOLDER=$OPTARG
      ;;
    c)  #set option "g"
      CHECK_FOLDER=$OPTARG
      ;;
    o)  #set option "h"
      CONFIG_FILE=$OPTARG
      ;;
    h)  #show help
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

shift $((OPTIND-1))  #This tells getopts to move on to the next argument.
### End getopts code ###

#Check the number of arguments. If none are passed, print help and exit.
NUMARGS=$#
if [ $NUMARGS -eq 0 ]; then
  HELP
fi

### Main loop to process command ###
while [ $# -ne 0 ]; do
  COMMAND=$1
  if [ "$COMMAND" == "setup" ]; then
    SETUP
    exit 1
  elif [ "$COMMAND" == "run" ]; then
    RUN
    exit 1
  else
    HELP
    exit 1
  fi
  shift  #Move on to next command
done


### End main loop ###
exit 0
