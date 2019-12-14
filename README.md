# MDSForensicsChallenge - Forgery Locatization 

The code provided by this repository combines the algorithms proposed in the articles:

> -- <cite>T. Bianchi, A. De Rosa and A. Piva, "Improved DCT coefficient analysis for forgery localization in JPEG images," 2011 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP), Prague, 2011, pp. 2444-2447.doi: 10.1109/ICASSP.2011.5946978 keywords: {discrete cosine transforms;image coding;statistical analysis;JPEG images;forgery localization;DCT coefficient analysis improvement;probability models;singly compressed regions;doubly compressed regions;primary quantization factor;statistical test;Discrete cosine transforms;Transform coding;Image coding;Forgery;Histograms;Quantization;Forensics;multimedia forensics;JPEG artifacts;Bayesian inference;forgery localization}/cite>

and

> -- <cite>Li, Weihai & Yuan, Yuan & Yu, Nenghai. (2009). Passive detection of doctored JPEG image via block artifact grid extraction. Signal Processing. 89. 1821-1829. 10.1016/j.sigpro.2009.03.025.,URL: </cite>

The code was developed for academic purposes. 

GOAL: Find a good solution for the problem of Localizing Forged areas of images. We investigated the leterature and the available implementations and later we decided to use the cited ones. Moreover our work is an extension of the algorithms ADQ2 and BLK provided by [MKLab-ITI/image-forensics](https://github.com/MKLab-ITI/image-forensics). Basically we tune the algorithms and then combine their outputs maps by appling logical OR operation between the two matrices. This choices were taken based on many experiments and in function of our dataset.

## Requirements
- [Matlab R2019b](https://it.mathworks.com/downloads/)
- [Phil Sallee's JPEG toolbox for MATLAB](http://dde.binghamton.edu/download/jpeg_toolbox.zip) 

The repository contains of the following :
- **get_map**: function/script that takes as input an​ image file path and creates the corresponding tampering map image ​with the same name as the input one​ into the folder DEMO-RESULTS;
- **get_maps**: script that takes as input a folder path and runs get_map.* on all the image files in that folder;
- **DEMO-RESULTS**: subfolder containing tampering maps estimated 
- **SUPPORT (optional)**: subfolder containing supporting libraries and functions functions. 

## How to run
* Clone the project. From terminal exec: 
```
$ git clone git@github.com:zeeros/MDSForensicsChallenge.git
```
* Add cloned folder and its subfloders to MATLAB path. From MATLAB Console:
```
addpath(genpath('MDSForensicsChallenge'));
```
NB: Remember to add also the folders where you will store the Testing Datasets to MATLAB path.


* Then, in order to exec the algorithm you have two options:
1) Use `get_map()` function:
```
image_path = 'path/to/image.jpg';
get_map(image_path)
```
2) Modify `get_maps.m` by setting `PATH_TO_FORGED_IMAGES=/path/to/directory/of/forged/images/` and run the script. 