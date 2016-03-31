%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #3
% Date: Nov. 1, 2015
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
% 5) Some places in code are comments because they were tried for
% answering some part of the questions.
%%
% Problem 1-a:      Swirl effect 
% M-file name:      Problem1a_final.m
% Usage:            Swirling effect on an image
% Output Result:    kate_swirled.raw
% Parameters:       It will ask for swirling factor. 
%                   Suggested swirling factor: 400,450,500 
%------------------------------------------------------------------------%
% Function required: imagerotate.m
% imagerotate.m is a self-written function for rotational transformation
%------------------------------------------------------------------------%
disp('Running Code');
Problem1a_final
disp(' Output is done! Check for kate_swirled.raw ');
%----------------------------------------------------------%

%%
% Problem 1-b:      Perspective Transformation and Imaging Geometry
% M-file name:      Problem1b_final.m
% Usage:            Swirling effect on an image
% Output Result:    kate_swirled.raw
% Parameters:       Read the note. 
%------------------------------------------------------------------------%
% Note: 1) For Problem1b_pre_processing.m will ask for x,y,z value in the
%       3-D imaging coordinates and size of the Image (in our case it is 200). It
%       will give us R,G,B values of the image we ask for. The values of x,y,z
%       are always between -1 & +1. Following are the faces of the cube on which
%       the images are placed. Based on the geometry of 3-D world coordinates,
%       you will get the values of the image. Following is the reference for
%       image placement:
                        %   /---------------------\
                        %   |Top  - baby.raw      |
                        %   |Front- baby_cat.raw  |
                        %   |Right- baby_dog.raw  |
                        %   |Rear - baby_panda.raw|
                        %   |Left - baby_bear.raw |
                        %   \---------------------/
%       2) For Problem1b_final.m, we will need to input pixel density and
%       size of the capture image. Pixel density can not exceed size of the
%       captured image. If size of the capture image is 200, pixel density
%       can be any number between 0 and 200. 
%       3) Functions required: getPosOfCapture.m, getRGBfromlocation.m 
%------------------------------------------------------------------------%
disp('Running Code');
disp(' Output is done! View in the command window');
Problem1b_pre_processing

Problem1b_final
disp(' Output is done! Check for capture.raw ');
%------------------------------------------------------------------------%

%%
% Problem 2-a:      Dithering
% M-file name:      Problem2a_final.m
% Usage:            Digital Halftoning on a monochrome image
% Output Result:    Mandrill_I8.raw,Mandrill_I2.raw,Mandrill_four.raw
% Parameters:       No parameter needed
%------------------------------------------------------------------------%
% Please see the image in 8-bit display 
%------------------------------------------------------------------------%
disp('Running Code');
Problem2a_final
disp(' Output is done! Check for Mandrill_I8.raw,Mandrill_I2.raw,Mandrill_four.raw ');
%----------------------------------------------------------%

%%
% Problem 2-b:      Eror Diffusion
% M-file name:      Problem2b_FSED.m,Problem2b_JJN,Problem2b_SED
% Usage:            Digital Halftoning on a monochrome image with error
%                   diffusion using Floyd-Steinberg's error difussion,
%                   Jarvis,Judice, Ninke (JJN) error diffusion, Stucki
%                   error diffusion
% Output Result:    Mandrill_FSED.raw; Mandrill_JJN.raw; Mandrill_SED.raw
% Parameters:       No parameter needed
%------------------------------------------------------------------------%
% Please see the image in 8-bit display 
%------------------------------------------------------------------------%
disp('Running Code');
Problem2b_FSED
disp(' Output is done! Check for Mandrill_FSED.raw');

disp('Running Code');
Problem2b_JJN
disp(' Output is done! Check for Mandrill_JJN.raw');

disp('Running Code');
Problem2b_SED
disp(' Output is done! Check for Mandrill_SED.raw');
%----------------------------------------------------------%

%%
% Problem 2-c:      Scalar Color Halftoning
% M-file name:      Problem2c_final.m
% Usage:            Digital Halftoning on a color image
% Output Result:    sailboat_scalar.raw
% Parameters:       No parameter needed
%------------------------------------------------------------------------%
% Please see the RGB image in 24-bit RGB planar while using ImageJ
% Functions required: fsed.m 
%------------------------------------------------------------------------%
disp('Running Code');
Problem2c_final
disp(' Output is done! Check for sailboat_scalar.raw');
%----------------------------------------------------------%

%%
% Problem 2-d:      Vector Color Halftoning
% M-file name:      Problem2d_final.m
% Usage:            Digital Halftoning on a color image
% Output Result:    sailboat_vector_no_quantization.raw, sailboat_vector_with_quantization.raw
% Parameters:       No parameter needed
%------------------------------------------------------------------------%
% Please see the RGB image in 24-bit RGB planar while using ImageJ
% Functions required: RGBtoCMYK.m,CMYKtoRGB,m, mvbq.m,
% nearest_vertex.m,extension.m, extension1.m
%------------------------------------------------------------------------%
disp('Running Code');
Problem2d_final
disp(' Output is done! Check for sailboat_vector_no_quantization.raw, sailboat_vector_with_quantization.raw');
%----------------------------------------------------------%

%%
% Problem 3-a:      Shrinking
% M-file name:      Problem3a_final.m
% Usage:            Counting number of nails,holes, white segments
% Output Result:    See the output in command window  
% Parameters:       No parameter needed
%------------------------------------------------------------------------%
% Please see the RGB image in 24-bit RGB planar while using ImageJ
% Functions required: erosion.m, shrinking.m, dilation.m, extension.m, extension1.m
% Note: A color-labeled image is created to verify the connected labeling.
% Output file is named as horseshoe_labeled.raw
%------------------------------------------------------------------------%
disp('Running Code');
Problem3a_final
disp(' Output is done! Check for output in command window');

%%
% Problem 3-b:      Thinning and Skeletonizing 
% M-file name:      Problem3b_skeletonizing.m,Problem3b_thinning.m
% Usage:            Counting number of nails,holes, white segments
% Output Result:    horseshoe_skeletonized_with_preprocesisng.raw,
%                   horseshoe_skeletonized_without_preprocesisng.raw
%                   horseshoe_thinned_with_preprocesisng.raw
%                   horseshoe_thinned_without_preprocesisng.raw
% Parameters:       No parameter needed
%------------------------------------------------------------------------%
% Please see the RGB image in 24-bit RGB planar while using ImageJ
% **** Final_Unconditional_Mask_ST.mat is required for the file to run****
% Functions required: binarycompare.m, createPattern.m,
% dilation.m,erosion.m,extension.m, gaussianFilter3.m, getcondvects.m,
% maskcomapre.m, shrinking.m, skeletonizing.m,skeletonizing_pre_processing.m,
% thinning2.m,thinning_pre_processing.m
% getcondvects.m is used to create different combinations from pattern
% tables
%------------------------------------------------------------------------%
disp('Running Code');
Problem3b_skeletonizing
disp(' Output is done! Check for horseshoe_skeletonized_with_preprocesisng.raw,horseshoe_skeletonized_without_preprocesisng.raw ');

disp('Running Code');
Problem3b_thinning
disp(' Output is done! Check for horseshoe_thinned_with_preprocesisng.raw,horseshoe_thinned_without_preprocesisng.raw ');