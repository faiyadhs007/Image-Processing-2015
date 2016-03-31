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
tic
close all; clear all; clc;
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

%% Plotting Image 01- Bus.raw
Ia_bw = rgb2gray(Ia);
points_a = detectSURFFeatures(Ia_bw);
imshow(Ia); hold on;
plot(points_a.selectStrongest(100));
hold off;

%% Plotting Image 02- Sedan.raw
figure(2)
Ib_bw = rgb2gray(Ib);
points_b = detectSURFFeatures(Ib_bw);
imshow(Ib); hold on;
plot(points_b.selectStrongest(100));
hold off;

toc