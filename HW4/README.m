%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #4
% Date: Nov. 29, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
% Notes: 
% 1) All the images for this problems should be placed in the same directory.
% 2) Please see the RGB image in 24-bit RGB planar while using ImageJ.
% 3) Please make sure all the functions as asked are placed in the same
% directory and used rightly. 
% 4) Functions required to read the raw files: readImage.m (*** Compulsory***)
% 5) Some lines in the code are commented because they were tried for
% answering some part of the questions.
%%
% Problem 1-a:       
% M-file name:      Problem1a_final.m
% Usage:            Creating decision tree from the Training.raw
% Input Image:      Training.raw
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Function required: cent_moment.m, dilation.m, hu_moment.m
%------------------------------------------------------------------------%
disp('Running Code');
Problem1a_final
disp(' Output is done! Check for T_training variable in the workspace ');
%----------------------------------------------------------%

%%
% Problem 1-b:       
% M-file name:      Problem1b_ideal1.m, Problem1b_ideal2.m
% Usage:            OCR testing on Test_ideal1.raw & Test_ideal2.raw
% Input Image:      Test_ideal1.raw, Test_ideal2.raw
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Function required: cent_moment.m, dilation.m, hu_moment.m
%------------------------------------------------------------------------%
disp('Running Code');
Problem1b_ideal1
Problem1b_ideal2
disp(' Output is done! Check in the Command Window for output ');
%----------------------------------------------------------%

%%
% Problem 1-c:       
% M-file name:      Problem1c_night.m,Problem1c_shade.m
% Usage:            OCR testing on Test_night.raw & Test_shade.raw
% Input Image:      Test_night.raw, Test_shade.raw
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Function required: cent_moment.m, dilation.m, hu_moment.m
%------------------------------------------------------------------------%
disp('Running Code');
Problem1c_night
Problem1c_shade
disp(' Output is done! Check in the Command Window for output ');
%----------------------------------------------------------%

%%
% Problem 2a:       Snake Algorithm Implementation
% M-file name:      Problem1c_night.m,Problem1c_shade.m
% Usage:            Implementation of Snake Algorithm on four images
% Input Image:      brian.jpg, coronary,jpg, blood_cells.jpg, spine.jpg
% Parameters:       Specified in the report
%------------------------------------------------------------------------%
% MATLAB Library required: Image Processing Toolbox

% Steps to be followed: 
% 1) Download the following from the link provided and locate snk.m. 
% Link: http://www.mathworks.com/matlabcentral/fileexchange/28109-snakes--active-contour-models
% 2) Convert the raw images provided into jpg format
% 3) Place the jpg images inside the downloaded folder
% 4) Run snk.m file and load the jpg images using the following steps.

% Running snk.m
%   1. Type guide on the matlab prompt.
%   2. Click on "Go to Existing GUI"
%   3. Select the snk.fig file in the same directory as this file
%   4. Click the green arrow at the top to launch the GUI
%
%   Once the GUI has been launched, you can use snakes by
%   1. Click on "New Image" and load an input image. Samples image are
%   provided.
%   2. Set the smoothing parameter "sigma" or leave it at its default value
%   and click "Filter". This will smooth the image.
%   3. As soon as you click "Filter", cross hairs would appear and using
%   them and left click of you mouse you can pick initial contour location
%   on the image. A red circle would appead everywhere you click and in
%   most cases you should click all the way around the object you want to
%   segement. The last point must be picked using a right-click in order to
%   stop matlab for asking for more points.
%   4. Set the various snake parameters (relative weights of energy terms
%   in the snake objective function) and click "Iterate" button. The snake would appear and move as it
%   converges to its low energy state.

% The results obtained from the images depend on the initial contour
% chosen. If the intial contour is chosen closer to the region of interest
% and parameters are followed from the Homework Report-2, the code will
% provide result closer to the ones in the reports. 
%------------------------------------------------------------------------%
%----------------------------------------------------------%

%%
% Problem 2b:       Level-set algorithm
% M-file name:      
% Usage:            Implementation of level-set algorithm on four images
% Input Image:      brian.bmp, coronary.jpg, blood_cells.bmp, spine.bmp
% Parameters:       Not required. They can be changed by going inside the
%                   folder.
%------------------------------------------------------------------------%
% Function required: drlse_edge.m
%------------------------------------------------------------------------%
% Steps to be followed:
% 1) Download the folder from the following link and place all the .m files
% in the same directory or add the folder with their sub folders to the 
% README file's directory.
% Link: http://www.mathworks.com/matlabcentral/fileexchange/12711-level-set-for-image-segmentation
% 2) Convert the raw images into bmp images to run the code. 
% 3) Run Problem2a_Level, Problem2b_Level, Problem2c_Level,Problem2d_Level.

% It should be taken care that drlse_edge.m is included and images are
% converted into bmp images
%------------------------------------------------------------------------%
disp('Running Code');
Problem2a_Level
Problem2b_Level
Problem2c_Level
Problem2d_Level
disp(' Output is done!');
%----------------------------------------------------------%

%%
% Problem 3a:       SIFT and SURF Feature Extraction
% M-file name:      Problem3_a_SIFT.m, Problem_3a_SURF.m 
% Usage:            Implementation of level-set algorithm on four images
% Input Image:      Bus.raw, Sedan.raw, School_bus1.raw, School_bus2.raw
% Parameters:       Not required
%------------------------------------------------------------------------%
% Libraries Required: 

% 1) Download "VLFeat 0.9.20 source code only" from the
% link, unzip it and add it to the path: http://www.vlfeat.org/download.html

% 2) Download Machine Learning Toolbox (MATLAB), Full version Image processing
% Toolbox (MATLAB), Computer Vision System Toolbox (MATLAB),Image Category
% Classification and Image Retrieval (MATLAB),Object Detection and
% Recognition (MATLAB)

% 3) Download the zip file from the following link; unzip it and add it to the path:
% http://www.mathworks.com/matlabcentral/fileexchange/43631-compute-bag-of-visual-word-representation-for-an-image

% 4) Download the following library from the link below and add it to the
% path: https://gforge.inria.fr/frs/?group_id=2151&release_id=8879#library-yael-v438-title-content
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
disp('Running Code');
Problem3a_SIFT
Problem3a_SURF
disp(' Output is done!');
%----------------------------------------------------------%

%%
% Problem 3b:       Image matching
% M-file name:      Problem3b_SIFT_Matching.m
% Usage:            Image matching for two images using SIFT descriptors
% Input Image:      Bus.raw, Sedan.raw, School_bus1.raw, School_bus2.raw
% Parameters:       Not required
%------------------------------------------------------------------------%
% Libraries Required: 

% 1) Download "VLFeat 0.9.20 source code only" from the
% link, unzip it and add it to the path: http://www.vlfeat.org/download.html

% 2) Download Machine Learning Toolbox (MATLAB), Full version Image processing
% Toolbox (MATLAB), Computer Vision System Toolbox (MATLAB),Image Category
% Classification and Image Retrieval (MATLAB),Object Detection and
% Recognition (MATLAB)

% 3) Download the zip file from the following link; unzip it and add it to the path:
% http://www.mathworks.com/matlabcentral/fileexchange/43631-compute-bag-of-visual-word-representation-for-an-image

% 4) Download the following library from the link below and add it to the
% path: https://gforge.inria.fr/frs/?group_id=2151&release_id=8879#library-yael-v438-title-content
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
disp('Running Code');
Problem3b_SIFT_Matching
disp(' Output is done!');
%----------------------------------------------------------%

%%
% Problem 3b:       Bag of Words
% M-file name:      Problem3c_K_means_SIFT.m
% Usage:            Finding closer match to an image using K-means
%                   clustering
% Input Image:      Bus.raw, Sedan.raw, School_bus1.raw, School_bus2.raw
% Parameters:       Not required
%------------------------------------------------------------------------%
% Libraries Required: 

% 1) Download "VLFeat 0.9.20 source code only" from the
% link, unzip it and add it to the path: http://www.vlfeat.org/download.html

% 2) Download Machine Learning Toolbox (MATLAB), Full version Image processing
% Toolbox (MATLAB), Computer Vision System Toolbox (MATLAB),Image Category
% Classification and Image Retrieval (MATLAB),Object Detection and
% Recognition (MATLAB)

% 3) Download the zip file from the following link; unzip it and add it to the path:
% http://www.mathworks.com/matlabcentral/fileexchange/43631-compute-bag-of-visual-word-representation-for-an-image

% 4) Download the following library from the link below and add it to the
% path: https://gforge.inria.fr/frs/?group_id=2151&release_id=8879#library-yael-v438-title-content
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
disp('Running Code');
Problem3c_K_means_SIFT
disp(' Output is done! Check the command window');
%----------------------------------------------------------%
% End of the semester. 