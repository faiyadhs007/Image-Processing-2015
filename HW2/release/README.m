%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Oct. 11, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
%%
% Problem 1-a:      Texture Analysis and Classification
% M-file name:      Problem_1a.m
% Usage:            Texture Classification for two classes
% Output Result:    final_result_1a.mat
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Note:             1) Load the grass_vector.mat, straw_vector.mat, 
% unknown_vector.mat, unknown_file_names.mat in the same folder
%                   2) If you want to build the above mentioned mat
% files, run build_1a.m. The file may take more than 5 minutes to run. All 
% the images provided for part a should be included in the same folder.
%------------------------------------------------------------------------%
disp('Running Code');
Problem_1a
disp(' Output is done! Check for final_result_1a.mat ');
%----------------------------------------------------------%

%%
% Problem 1-b:      Texture Analysis and Classification
% M-file name:      Problem_1b.m
% Usage:            Binary Classification for multiple classes
% Output Result:    final_result_1b.mat
% Parameters:       User input required. The input has to be any one of the
% classifier for which user want to evaluate [Grass,Leather,Sand,Straw]

%------------------------------------------------------------------------%
% Disclaimer: Before we move onto Problem 1-b, it should be mentioned that 
% both Problem 1-a and Problem 1-b should be executed separately
% since there are file names in 1-a which matches with 1-b; but they both 
% have different properties. Along with that, for running 1-b, the
% textures provided for the particular problem should be used with a same 
% number of files (48 for each texture)
%------------------------------------------------------------------------%
% Note:             1) Load the grass_vector_1b.mat, leather_vector_1b.mat, 
% sand_vector_1b.mat, straw_vector_1b.mat in the same folder
%                   2) If you want to build the above mentioned mat
% files, run build_1b.m. The file may take more than 5 minutes to run. All 
% the images provided for part b should be included in the same folder.
% The files used in Problem 1-a should be deleted so that there is no
% conflict in datasets.
%                   3) The libsvm-3.20 library should be added to the
% folder in which the code is executed. The library can be downloaded from
% the provided link: https://www.csie.ntu.edu.tw/~cjlin/libsvm/#download
% This code guarantees for the performance of 3.20 version. Other versions
% were not tried. 
%                   4) Running the code will ask for a user_input. If the
% user choose a particular classifier, the first twelve files in the final
% result are from that class and the rest are from non-classes. 
%------------------------------------------------------------------------%
disp('Running Code');
Problem_1b
disp(' Output is done! Check for final_result_1b.mat ');

%%
% Problem 2-a:      Sobel Edge Detection
% M-file name:      Problem_2a_Farm.m , Problem_2a_Cougar.m
% Usage:            Used to detect edges using Sobel operator, thresholds
% Output Image:     Farm_Gx.raw,Farm_Gy.raw,Farm_Gradient.raw,
% Farm_thresh10.raw, Farm_thresh15.raw,Farm_nms_10.raw,Farm_nms_15.raw;
% Cougar_Gx.raw, Cougar_Gy.raw, Cougar_Gradient.raw, Cougar_thresh10.raw,
% Cougar_thresh15.raw, Cougar_nms_10.raw, Cougar_nms_15.raw. (14 outputs)
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Note:             1) Load Farm.raw and Cougar.raw in the same directory.
%                   2) Three functions should be included for the code to
%execute: myHist, cumuHist, nonmaxsupp. 
%------------------------------------------------------------------------%
disp('Running Code');
Problem2a_Farm
Problem2a_Cougar
disp('Output is done! Check for 14 output raw images');
disp('Edges are in black and background is white');

% Naming convention:
% _Gx:          image for Horizontal Gradient
% _Gy:          image for Vertical Gradient
% _Gradient:    image for Gradient Magnitude
% _thresh10:    image for 10% threshold on _Gradient
% _thresh15:    image for 15% threshold on _Gradient
%_nms_10:       image for Non-Maximal Suppresion on _thresh10
%_nms_15:       image for Non-Maximal Suppresion on _thresh15
%----------------------------------------------------------%

%%
% Problem 2-b:      Canny Edge Detection
% M-file name:      Problem2b_Farm.m , Problem2b_Cougar.m
% Usage:            Used to detect edges using Canny edge detector
% Output Image:     Canny_Farm1.raw,Canny_Farm2.raw,Canny_Farm3.raw,
% Canny_Farm4.raw,Canny_Farm5.raw,Canny_Farm6.raw;Canny_Cougar1.raw,
% Canny_Cougar2.raw,Canny_Cougar3.raw, Canny_Cougar4.raw,Canny_Cougar5.raw,
% Canny_Cougar6.raw (12 outputs)
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Note:             1) Load Farm.raw and Cougar.raw in the same directory.
%                   2) No function is required
%------------------------------------------------------------------------%
disp('Running Code');
Problem2b_Farm
Problem2b_Cougar
disp('Output is done! Check for 12 output raw images');
disp('Edges are in black and background is white');

% Naming convention:
%  Img: Farm/Canny
% _Img1:    Canny Edge for [.3 .6]
% _Img2:    Canny Edge for [.2 .7]
% _Img3:    Canny Edge for [.2 .5]
% _Img4:    Canny Edge for [.4 .7]
% _Img5:    Canny Edge for [.4 .5]
% _Img6:    MATLAB default thresholds  
%----------------------------------------------------------%

%%
% Problem 2-c:      Structured Edge Detection
% M-file name:      Problem2c_Farm.m , Problem2c_Cougar.m
% Usage:            Used to detect edges using SE detection based on
% Random Forests classifier
% Output Image:     SE_Farm_pe.raw, SE_Farm_be.raw; SE_Cougar_pe.raw,
% SE_Cougar_be.raw
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Note:             1) Load Farm.raw and Cougar.raw in the same directory.
%                   2) Download Piotr's implementation of SE Edge Detector
% on https://github.com/pdollar/edges. Follow the instructions
% from readme.txt provided inside the file (3,4,5) 
%                   3) MATLAB Image Processing Toolbox is required for this
%                   4) Download Piotr's Toolbox which is available at: 
% http://vision.ucsd.edu/~pdollar/toolbox/doc/index.html
%                   5) Next, please compile mex code from within Matlab 
% (note: win64/linux64 binaries included):
%   mex private/edgesDetectMex.cpp -outdir private [OMPPARAMS]
%   mex private/edgesNmsMex.cpp    -outdir private [OMPPARAMS]
%   mex private/spDetectMex.cpp    -outdir private [OMPPARAMS]
%   mex private/edgeBoxesMex.cpp   -outdir private
% Here [OMPPARAMS] are parameters for OpenMP and are OS and compiler dependent.
% Windows:  [OMPPARAMS] = '-DUSEOMP' 'OPTIMFLAGS="$OPTIMFLAGS' '/openmp"'
% Linux V1: [OMPPARAMS] = '-DUSEOMP' CFLAGS="\$CFLAGS -fopenmp" LDFLAGS="\$LDFLAGS -fopenmp"
% Linux V2: [OMPPARAMS] = '-DUSEOMP' CXXFLAGS="\$CXXFLAGS -fopenmp" LDFLAGS="\$LDFLAGS -fopenmp"
% To compile without OpenMP simply omit [OMPPARAMS]; note that code will be single threaded in this case.
% MacOS:    make sure your mex setup is compatible with version of X-code
% and run the mex files without [OMPPARAMS]
% If possible, downgrade the X-code version 5.1. This code was tested with this version 
% and mex was made compatible accordingly.
%                   6) Place release folder (from step-2) inside running 
% directory and toolbox (Step-4) should be placed inside the release
% folder.
%                   7) While running the code, add the path of release
% folder to the testing folder or in the same folder of README.m 
%                   8) The raw images will be saved inside the SE edge
%                   detection folder. 

%                   9) Put readImage.m, Cougar.raw, Farm.raw
% function inside the SE edge detection library
%                   10) If it takes to the Edge Detection library, come back 
% to the original directory of README to execute. It is recommended to run this code inside the SE
% detection library.
%------------------------------------------------------------------------%
disp('Running Code');
Problem2c_Farm
Problem2c_Cougar
disp('Output is done! Check for 12 output raw images');
disp('Edges are in black and background is white');
% Naming convention:
%  Img: Farm/Canny
% _pe:    Probability edge map
% _be:    Binary edge map 

% We can change the parameter inside the files for NMS which produce better
% results. For this change model.opts.nms to 1. The default is zero(0). 
%----------------------------------------------------------%
%%
% Problem 2-d:      Performance Evaluation
% M-file name:      Problem2d_Farm.m , Problem2d_Cougar.m
% Usage:            Used to find F-measure for edge detection performance
% Output Image:     No output image
% Parameters:       No parameters required
%------------------------------------------------------------------------%
% Note:             1) Follow the same procedure for getting mex files
% supported like Problem 2-c. It is recommended to run the code after executing
% Problem 3-c properly.
%                   2) Load G_Farm.mat and G_Cougar.mat. These are the ground
% truth images provided as a reference. These are already provided in the 
% folder. In case needed, the required ground truth can be achieved using
% build_Farm.m and build_Cougar.m
%                   3) For getting F-measure values for each edge
% detection, run Problem2a_Farm, Problem2b_Farm, Problem2c_Farm;
% Problem2a_Cougar, Problem2b_Cougar, Problem2c_Cougar individually so
% that their edge image matrix are loaded in the workspace. 
%                   4) Then, run the corresponding F-measure file for Farm
% or Cougar. It will ask for user input. To get F-measure for certain edge
% map, follow the input and threshold tables below. 
%                   5) After the input are provided, a mean precision and
% recall, F-measure value with an error map will be shown. 
%                   6) You will need to add correspondPixels mex files from the SE
% detection library. It is recommended to run this code inside the SE
% detection library.
%------------------------------------------------------------------------%
disp('Running Code');
Problem2d_Farm
Problem2d_Cougar
disp('Output is done! Check for F-measure value in command window');

% Input for images and threshold values:
%  Img: Farm/Canny
%  Gradient Magnitude: Input: B; Threshold:1
%  Threshold 10%     : Input: B_thresh10; Threshold:1
%  Threshold 15%     : Input: B_thresh15; Threshold:1
%  NMS 10%           : Input: B3; Threshold:1
%  NMS 15%           : Input: B4; Threshold:1 
%  Canny Edge [.3 .6]: Input: Canny_Img_1; Threshold:1
%  Canny Edge [.2 .7]: Input: Canny_Img_2; Threshold:1
%  Canny Edge [.2 .5]: Input: Canny_Img_3; Threshold:1
%  Canny Edge [.4 .7]: Input: Canny_Img_4; Threshold:1
%  Canny Edge [.4 .5]: Input: Canny_Img_5; Threshold:1
%  Structured Edge   : Input: B; Threshold:99/1

% For the code of SE detection, I would like to cite:
% @inproceedings{DollarICCV13edges,
%   author    = {Piotr Doll\'ar and C. Lawrence Zitnick},
%   title     = {Structured Forests for Fast Edge Detection},
%   booktitle = {ICCV},
%   year      = {2013},
% }
% 
% @article{DollarARXIV14edges,
%   author    = {Piotr Doll\'ar and C. Lawrence Zitnick},
%   title     = {Fast Edge Detection Using Structured Forests},
%   journal   = {ArXiv},
%   year      = {2014},
% }
% 
% @inproceedings{ZitnickECCV14edgeBoxes,
%   author    = {C. Lawrence Zitnick and Piotr Doll\'ar},
%   title     = {Edge Boxes: Locating Object Proposals from Edges},
%   booktitle = {ECCV},
%   year      = {2014},
% }