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
close all; clear all; clc;
run('vlfeat-0.9.20/toolbox/vl_setup')

%% Reading the image and placing necessary parameters
close all; clear all; clc;
rowa = 300; cola =400; BytesPerPixel = 3;
fileID = fopen('Bus.raw');
[Ia,Reda,Greena,Bluea] = readImage(fileID, rowa,cola, BytesPerPixel);

rowb = 233; colb =400; BytesPerPixel = 3;
fileID = fopen('Sedan.raw');
[Ib,Redb,Greenb,Blueb] = readImage(fileID, rowb,colb, BytesPerPixel);

rowc = 200; colc =374; BytesPerPixel = 3;
fileID = fopen('School_bus1.raw');
[Ic,Reda,Greena,Bluea] = readImage(fileID, rowc,colc, BytesPerPixel);

rowd = 200; cold =356; BytesPerPixel = 3;
fileID = fopen('School_bus2.raw');
[Id,Redb,Greenb,Blueb] = readImage(fileID, rowd,cold, BytesPerPixel);

%% SIFT description
Ia = single(rgb2gray(Ia)); Ib = single(rgb2gray(Ib)); 
Ic = single(rgb2gray(Ic)); Id = single(rgb2gray(Id));

[f1,d1] = vl_sift(Ia); [f2,d2] = vl_sift(Ib); 
[f3,d3] = vl_sift(Ic); [f4,d4] = vl_sift(Id);

%% Creating codebook
d = [d1 d2 d3 d4];
K = 8 ;
[C,A] = vl_ikmeans(d,K);

%% Histogram plot 
[idx1,~]=yael_nn(single(C),single(d1),1,2);
A1 = hist( double(idx1), 1:size(C,2) ); %title('BoW for Bus')
hist( double(idx1), 1:size(C,2) );title('BoW for Bus');

[idx2,~]=yael_nn(single(C),single(d2),1,2);
B1 = hist( double(idx2), 1:size(C,2) ); %title('BoW for Sedan')
figure; hist( double(idx2), 1:size(C,2) );title('BoW for Sedan');

[idx3,~]=yael_nn(single(C),single(d3),1,2);
C1 = hist( double(idx3), 1:size(C,2) ); %title('BoW for SchoolBus1')
figure; hist( double(idx3), 1:size(C,2) );title('BoW for SchoolBus1');

[idx4,~]=yael_nn(single(C),single(d4),1,2);
D1 = hist( double(idx4), 1:size(C,2) ); %title('BoW for SchoolBus2')
figure; hist( double(idx4), 1:size(C,2) );title('BoW for SchoolBus2');

feature_train   = [A1; B1; C1];
feature_test    =  D1;
[IDx,D2] = knnsearch(feature_train,feature_test);

if IDx == 1
    fprintf('School_Bus2.raw has more resemblance to Bus.raw\n');
elseif IDx == 2
    disp('School_Bus2.raw has more resemblance to Sedan.raw');
elseif IDx == 3
    disp('School_Bus2.raw image has more resemblance to School_Bus1.raw');
end