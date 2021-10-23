![Logo](readme_support/logo_long.png "logo")

# Robustar
Interactive Toolbox for Robust Vision Classification

### Main Use Case (Workflow): 

![workflow](readme_support/RobustarFunction.png "workflow")

1.	the model can be trained elsewhere and then fed into the software; 
2.	With new test samples, the model can help identify the samples that are responsible for the prediction through influence function; 
3.	the software offers saliency map to help the user know which part of the features the model are paying necessary attention; 
4.	the users can use the drawing tools to brush out the superficial pixels; 
5.	new annotation of these images will serve as the role as augmented images for continued training.

### Video Demo

![Quick Demo](readme_support/simpleDemo.gif "demo")

### Installation 

- To install Robustar, please first [intall Docker](https://docs.docker.com/engine/install/) locally. 
- Then, one can start the robustar with [robustar.sh](https://github.com/HaohanWang/Robustar/blob/main/robustar.sh) included in this repository.  

  - First time users please run `./robustar.sh setup` to pull docker image. 
  - One can run `./robustar.sh run -t $TRAINING_IMAGES_FOLDER -e $TESTING_IMAGES_FOLDER -c $MODEL_CHECKPOINTS_FOLDER` to start current robustar

- Directly run `./robustar.sh` will display the help message. 

<details>
  <summary><b>Click to Expand Built-in Help Message</b></summary>

  > Help documentation for robustar.
> 
> Basic usage: robustar [command]
> 
> [command] can be one of the following: setup, run.
> 
> setup will prepare and pulling the docker image.
> 
> run will start to run the system.
> 
> Command line switches are optional. The following switches are recognized.
> 
> -p  --Sets the value for the port docker forwards to. Default is 8000.
> 
> -a  --Sets the value for the tag of the image. Default is latest.
> 
> -n  --Sets the value for the name of the docker container. Default is robustar.
> 
> -t  --Sets the path of training images folder. Currently only supports the PyTorch DataLoader folder structure
> 
> -e  --Sets the path of testing images folder. Currently only supports the PyTorch DataLoader folder structure
> 
> -i  --Sets the path of the calculation result of the influence function.
> 
> -c  --Sets the path of model check points folder.
> 
> -o  --Sets the path of configuration file. Default is config.txt.
> 
> -h  --Displays this help message. No further functions are performed.
  
</details>

### Disclaimer

Robustar is still in its development phase.
While we are grateful that the community is interested in using our system, please bear with us that some functions are still in inchoate forms. 

We are welcoming feedbacks of all kinds! 

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgithub.com%2FHaohanWang%2FRobustar)

### Contact

[Chonghan Chen](https://github.com/PaulCCCCCCH)
&middot; 
[Donglin Chen](https://github.com/don-lin) 
&middot;
[Haohan Wang](http://www.cs.cmu.edu/~haohanw/) 


