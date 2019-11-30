# MDSForensicsChallenge
The submitted material must consist of a folder containing:
- **get_map.***: function/script that takes as input an​image file path and creates the corresponding tampering map image ​with the same name as the input one​ into the folder DEMO-RESULTS;
- **README**: textfile containing instructions on how to use getmap.* and information on the environment used and requirements for running the code. Please, remember that getmap.* should be as self-contained as possible;
- **DEMO-RESULTS**: subfolder containing tampering maps estimated by your algorithm on the 5 images contained in ​demo_images;
- **SUPPORT (optional)**: subfolder containing any data invoked by getmap.* (like pre-trained models, auxiliary functions, etc).
- **get_maps.***: script that takes as input a folder path and runs get_map.* on all the image files in that folder;

**Important!** The code must not open pop-up windows, print on screen or require user input. It also needs to run in less than 2 minutes (i.e. the maximum execution time of get_map.* is of 2 minutes).