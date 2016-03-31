%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%

close all; clear all; clc;
row = 200; col =200; BytesPerPixel = 3;

fileID1 = fopen('baby.raw');
[img1,Red1,Green1,Blue1] = readImage(fileID1, row,col, BytesPerPixel);

fileID2 = fopen('baby_cat.raw');
[img2,Red2,Green2,Blue2] = readImage(fileID2, row,col, BytesPerPixel);

fileID3 = fopen('baby_dog.raw');
[img3,Red3,Green3,Blue3] = readImage(fileID3, row,col, BytesPerPixel);
img3 = imrotate(img3,90);

fileID4 = fopen('baby_panda.raw');
[img4,Red4,Green4,Blue4] = readImage(fileID4, row,col, BytesPerPixel);

fileID5 = fopen('baby_bear.raw');
[img5,Red5,Green5,Blue5] = readImage(fileID5, row,col, BytesPerPixel);

%% Get RGB values for world coordinates
x = input(' x value: ');
y = input(' y value: ');
z = input(' z value: ');
Size = input(' Image Size: ');

if z==1 && -1<=x<=1 && -1<=y<=1
        src = img1;
        %disp('Image-01');
        X = floor((x+1)/2*(Size-1))+1;
        Y = floor((y+1)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if x==1 && -1<=z<=1&& -1<=y<=1
        src = img2;
        %disp('Image-02');
        X = floor((1-z)/2*(Size-1))+1;
        Y = floor((y+1)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if y==1 && -1<=x<=1 && -1<=z<=1
        src = img3;
        %disp('Image-03');
        X = floor((1-x)/2*(Size-1))+1;
        Y = floor((1-z)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if x==-1 && -1<=z<=1 && -1<=y<=1
        src = img4;
        %disp('Image-04');
        X = floor((1-z)/2*(Size-1))+1;
        Y = floor((1-y)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if y==-1 && -1<=x<=1 && -1<=z<=1
        src = img5;
        %disp('Image-05');
        X = floor((1-z)/2*(Size-1))+1;
        Y = floor((x+1)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
disp('%-----------------%');
disp('%--Pre-processing--%');
fprintf (' x(in) Value: %4.1i \n',x);
fprintf (' y(in) Value: %4.1i \n',y);
fprintf (' z(in) Value: %4.1i \n',z);
fprintf (' Red   Value: %4.2i \n',R);
fprintf (' Green Value: %4.2i \n',G);
fprintf (' Blue  Value: %4.2i \n',B);
disp('%-----------------%');