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

%% SIFT features
[fa,da] = vl_sift(single(rgb2gray(Ia))) ;
[fb,db] = vl_sift(single(rgb2gray(Ib))) ;
[fc,dc] = vl_sift(single(rgb2gray(Ic))) ;
[fd,dd] = vl_sift(single(rgb2gray(Id))) ;

%% Plotting the SIFT

%% For Image-01 Bus.raw
figure(1) ; clf ;
imagesc(Ia) ;
axis image off ;
vl_demo_print('sift_match_1', 1) ;
hold on;

perm = randperm(size(fa,2)) ;
sel = perm(1:100) ;
h1 = vl_plotframe(fa(:,sel)) ;
h2 = vl_plotframe(fa(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
hold off; 

figure(2) ; clf ;
imagesc(Ia) ;
axis image off ;
vl_demo_print('sift_match_1', 1) ;
hold on;

perm = randperm(size(fa,2)) ;
sel = perm(1:100) ;
h3 = vl_plotframe(fa(:,sel)) ;
h4 = vl_plotframe(fa(:,sel)) ;
set(h3,'color','k','linewidth',3) ;
set(h4,'color','y','linewidth',2) ;

h5 = vl_plotsiftdescriptor(da(:,sel),fa(:,sel)) ;
set(h5,'color','g') ;
hold off; 

%% For Image-2 Sedan.raw
figure(3) ; clf ;
imagesc(Ib) ;
axis image off ;
vl_demo_print('sift_match_2', 1) ;
hold on;

perm = randperm(size(fb,2)) ;
sel = perm(1:100) ;
h6 = vl_plotframe(fb(:,sel)) ;
h7 = vl_plotframe(fb(:,sel)) ;
set(h6,'color','k','linewidth',3) ;
set(h7,'color','y','linewidth',2) ;
hold off; 

figure(4) ; clf ;
imagesc(Ib) ;
axis image off ;
vl_demo_print('sift_match_2', 1) ;
hold on;

perm = randperm(size(fb,2)) ;
sel2 = perm(1:50) ;
h8 = vl_plotframe(fb(:,sel2)) ;
h9 = vl_plotframe(fb(:,sel2)) ;
set(h8,'color','k','linewidth',3) ;
set(h9,'color','y','linewidth',2) ;

h10 = vl_plotsiftdescriptor(db(:,sel2),fb(:,sel2)) ;
set(h10,'color','g') ;
hold off; 

toc 
%% K-means
% words= [fa fb fc fd];
% C=learnCodebook(words,8);
% sift = {fa,fb,fc,fd}';
% BoW = computeBoV(C,words,2);
%BoW=DescriptorSoftCode(sift,C);