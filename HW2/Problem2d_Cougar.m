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