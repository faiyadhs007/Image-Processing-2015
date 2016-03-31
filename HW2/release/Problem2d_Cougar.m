%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Oct. 11, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
%% Measuring F-measure
load G_Cougar.mat;

%% Calling the function
I = input('Enter your image matrix: ');
t = input('Enter your threshold: ');
prms = struct('out',{'evaluate.txt'},'thrs',{t},'maxDist',{.0075},'thin',{1});
[thrs,cntR,sumR,cntP,sumP,V] = edgesEvalImg(I,'G_Cougar.mat',[prms]);

%% Calculating the precision and recall
sumR = mean(sumR); cntP = mean(cntP);
sumP = mean(sumP); cntR = mean(cntR);
precision = cntP./sumP
recall = cntR./sumR
F = (2.*(precision.*recall))./(precision+recall)
if t ==1 figure(1); imshow(V);
end

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