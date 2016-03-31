%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%----------------------------------------------------------%
%%
% Problem 1a:       Image Manipulation and Interpolation
% Implementation 1: Image Resizing via Bilinear Interpolation
% M-file name:      Prob1a_final.m
% Usage:            Image Resizing
% Output Image:     solution1a.raw
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
Prob1a_final
disp(' Output is done! Check the raw file solution1a.raw');
%----------------------------------------------------------%
%%
% Problem 1b:       Bilinear Demosaicing
% M-file name:      Prob1b_final.m
% Usage:            Converting a grayscale image into color image
% Output Image:     solution1b.raw
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
Prob1b_final
disp(' Output is done! Check the raw file solution1b.raw');
%----------------------------------------------------------%
%%
% Problem 1c:       Malvar-He-Cutler (MHC) Linear Image Demosaicing
% M-file name:      Prob1c_final.m
% Usage:            Converting a grayscale image into color image
%                   using a further improved algorithm 
% Output Image:     solution1c.raw
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
Prob1c_final
disp(' Output is done! Check the raw file solution1c.raw');
%----------------------------------------------------------%
%%
% Problem 2a:       Histogram Equalization
% Method used:      Using Transfer function based method
% M-file name:      Problem2a_Final_MethodA.m
% Usage:            Equalizing histogram to get an improved image
% Output Image:     solution2a_methodA.raw
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
Problem2a_Final_MethodA
disp(' Output is done! Check the raw file solution2a_methodA.raw');
%----------------------------------------------------------%
%%
% Problem 2a:       Histogram Equalization
% Method used:      Using Cumulative Probability-based method
% M-file name:      Problem2a_Final_MethodA.m
% Usage:            Equalizing histogram to get an improved image 
% Output Image:     solution2a_methodB.raw
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
Problem2a_Final_MethodB
disp(' Output is done! Check the raw file solution2a_methodB.raw');
%----------------------------------------------------------%
%%
% Problem 2b:       Image filtering
% Method used:      Creating Oil painting effect
% Procedure of execution: File naming convetion

%       a) _img: There are two images called 'barn.raw'& 
%'coliseum.raw' on which we need to apply the oil painting 
%effect. The last portion of the -m file indicates the image 
% on which the operation is taking place. (..._Barn.m,.Col.m)

%       b) _filterSize:There are different filter sizes applied: 
% 3x3,5x5,7x7, 9x9, 11x11. The name of the file includes the filter 
% size.

%       c) q: There are two ways by which the files are quantized.
% One is for 64 color for which -m files are named as 2b_1 and 
% the other is for 512 color for which -m files are named as 2b_3

% M-file name:      Problem2b_q_filterSize_img.m 
% Usage:            Applying oil painting filter to images
% Output Image:     various (read the file naming convetion)
%                   or else refer to the main -m file. 
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
% 64 color quantized image
Problem2b_1_3x3_Barn % Output is: Problem2b_barn3.raw
Problem2b_1_3x3_Col % Output is:  Problem2b_col3.raw
Problem2b_1_5x5_Barn % Output is: Problem2b_barn5.raw
Problem2b_1_5x5_Col % Output is:  Problem2b_col3.raw
Problem2b_1_7x7_Barn % Output is: Problem2b_barn7.raw
Problem2b_1_7x7_Col % Output is:  Problem2b_col7.raw
Problem2b_1_11x11_Barn % Output is:Problem2b_barn11.raw 
Problem2b_1_11x11_Col % Output is:Problem2b_col11.raw
% 512 color quantized image
Problem2b_3_3x3_Barn % Output is: Problem2b_barn3_512.raw
Problem2b_3_3x3_Col % Output is:  Problem2b_col3_512.raw
Problem2b_3_5x5_Barn % Output is: Problem2b_barn5_512.raw
Problem2b_3_5x5_Col % Output is:  Problem2b_col5_512.raw
Problem2b_3_7x7_Barn % Output is: Problem2b_barn7_512.raw
Problem2b_3_7x7_Col % Output is:  Problem2b_col7_512.raw
Problem2b_3_11x11_Barn % Output is:Problem2b_barn11_512.raw
Problem2b_3_11x11_Col % Output is: Problem2b_col11_512.raw
disp(' Output is done! Check the raw file .');

%%
% Problem 3a:       Removing mixed noise in color image
% Method used:      Using median and low pass filter
% Procedure of execution: 
        % The default execution is set for 3x3 filter size
        % If you want to check for 5x5,7x7,9x9 and 11x11, the
        % instructions are provided inside the matlab file. Open 
        % the MATLAB file and change the functions as instructed
% M-file name:      Problem3a_Final.m
% Usage:            Remove noise from the image 
% Output Image:     Problem3a.raw
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
Problem3a_Final
disp(' Output is done! Check the raw file Problem3a.raw');

%%
% Problem 3b:       Guided Image Filtering
% In this problem, two methods are implemented in one file:
% 1) Applying Guidede Image Filtering to a noisy image (3x3-default)
% 2) Applying Guided Filtering to one image mutiple times
% M-file name:      Problem3b_final.m
% Usage:            Remove noise from the image 
% Output Image:     Problem3b.raw & Problem3b_cartoon.raw
% Parameters:       No parameters needed
% Note:             While cheking the output with a image 
% processing software, use RGB Planar as output format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running Code');
Problem3b_final
disp(' Output is done! Check the raw file Problem3b.raw');
disp(' Output is done! Check the raw file Problem3b_cartoon.raw');

