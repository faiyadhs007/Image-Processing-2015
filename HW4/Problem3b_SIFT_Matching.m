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
clear all;close all; clc;
run('vlfeat-0.9.20/toolbox/vl_setup')

%% Reading the image 1
rowa = 300; cola =400; BytesPerPixel = 3;
fileID = fopen('Bus.raw');
[Ia,Reda,Greena,Bluea] = readImage(fileID, rowa,cola, BytesPerPixel);

%% Reading the image 2
rowb = 233; colb =400; BytesPerPixel = 3;
fileID = fopen('Sedan.raw');
[Ib,Redb,Greenb,Blueb] = readImage(fileID, rowb,colb, BytesPerPixel);

%% Reading the image 3
rowc = 200; colc =374; BytesPerPixel = 3;
fileID = fopen('School_bus1.raw');
[Ic,Redc,Greenc,Bluec] = readImage(fileID, rowc,colc, BytesPerPixel);

%% Reading the image 4
rowd = 200; cold =356; BytesPerPixel = 3;
fileID = fopen('School_bus2.raw');
[Id,Redd,Greend,Blued] = readImage(fileID, rowd,cold, BytesPerPixel);

[fa,da] = vl_sift(single(rgb2gray(Ia))) ;
[fb,db] = vl_sift(single(rgb2gray(Ib))) ;
[fc,dc] = vl_sift(single(rgb2gray(Ic))) ;
[fd,dd] = vl_sift(single(rgb2gray(Id))) ;

%% Figure (School Bus1 & School Bus2)

[matches, scores] = vl_ubcmatch(dc,dd,1.25) ;

[drop, perm] = sort(scores, 'descend') ; % perm is the index of sorted matrix
matches = matches(:, perm) ;
scores  = scores(perm) ;

figure(1) ; clf ;
imagesc(cat(2, Ic, Id));
axis image off ;
vl_demo_print('sift_match_1', 1) ;

figure(2) ; clf ;
imagesc(cat(2, Ic, Id)) ;

xa = fc(1,matches(1,:)) ;
xb = fd(1,matches(2,:)) + size(Ic,2) ;
ya = fc(2,matches(1,:)) ;
yb = fd(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fc(:,matches(1,:))) ;
fd(1,:) = fd(1,:) + size(Ic,2) ;
vl_plotframe(fd(:,matches(2,:))) ;
axis image off ;

vl_demo_print('sift_match_2', 1) ;

%% Figure for (School Bus1 & Bus)

I1 = imresize(Ia, [200 400],'bilinear');

[fa,da] = vl_sift(single(rgb2gray(Ia))) ;
[fc,dc] = vl_sift(single(rgb2gray(Ic))) ;

[matches_2, scores_2] = vl_ubcmatch(dc,da,1.25) ;

[drop, perm] = sort(scores_2, 'descend') ; % perm is the index of sorted matrix
matches_2 = matches_2(:, perm) ;
scores_2  = scores_2(perm) ;

figure(3) ; clf ;
% imagesc(cat(2, Ic, I1));
imagesc([padarray(Ic,100,'post') padarray(Ia,0,'post')]) ;
axis image off ;
vl_demo_print('sift_match_2', 1) ;

figure(4) ; clf ;
% imagesc(cat(2, Ic, I1)) ;
imagesc([padarray(Ic,100,'post') padarray(Ia,0,'post')]) ;

xc = fc(1,matches_2(1,:)) ;
xd = fa(1,matches_2(2,:)) + size(Ic,2) ;
yc = fc(2,matches_2(1,:)) ;
yd = fa(2,matches_2(2,:)) ;

hold on ;
h1 = line([xc ; xd], [yc; yd]) ;
set(h1,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fc(:,matches_2(1,:))) ;
fa(1,:) = fa(1,:) + size(Ic,2) ;
vl_plotframe(fa(:,matches_2(2,:))) ;
axis image off ;
vl_demo_print('sift_match_4', 1) ;

%% Figure for (School Bus1 & Sedan)
I2 = imresize(Ib, [200 400],'bilinear');

[fb,db] = vl_sift(single(rgb2gray(Ib))) ;
%[fb,db] = vl_sift(single(rgb2gray(I2))) ;
[fc,dc] = vl_sift(single(rgb2gray(Ic))) ;

[matches_3, scores_3] = vl_ubcmatch(dc,db,1.25) ;

[drop, perm] = sort(scores_3, 'descend') ; % perm is the index of sorted matrix
matches_3 = matches_3(:, perm) ;
scores_3  = scores_3(perm) ;

figure(5) ; clf ;
%imagesc(cat(2, Ic, I2));
imagesc([padarray(Ic,33,'post') padarray(Ib,0,'post')]) ;
axis image off ;
vl_demo_print('sift_match_5', 1) ;

figure(6) ; clf ;
%imagesc(cat(2, Ic, I2)) ;
imagesc([padarray(Ic,33,'post') padarray(Ib,0,'post')]) ;

xe = fc(1,matches_3(1,:)) ;
xf = fb(1,matches_3(2,:)) + size(Ic,2) ;
ye = fc(2,matches_3(1,:)) ;
yf = fb(2,matches_3(2,:)) ;

hold on ;
h2 = line([xe ; xf], [ye; yf]) ;
set(h2,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fc(:,matches_3(1,:))) ;
fb(1,:) = fb(1,:) + size(Ic,2) ;
vl_plotframe(fb(:,matches_3(2,:))) ;
axis image off ;
vl_demo_print('sift_match_6', 1) ;