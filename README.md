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

To install Robustar, first please [intall Docker](https://docs.docker.com/engine/install/) locally. 

Then, one can start the robustar with [robustar.sh](https://github.com/HaohanWang/Robustar/blob/main/robustar.sh) included in this repository.  
