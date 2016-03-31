%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function [R,G,B]= getRGBfromlocation(img1,img2,img3,img4,img5, Size, x,y,z)
% This function when called gives the value of R,G,B which will be mapped
% to the final 3D cube.
row = 200; col =200; BytesPerPixel = 3;

%% Get RGB values for world coordinates
% x = input('your x value: ');
% y = input('your y value: ');
% z = input('your z value: ');
% Size = input('your image size: ');

if z==1 && -1<=x<=1 && -1<=y<=1
        src = img1;
        X = floor((x+1)/2*(Size-1))+1;
        Y = floor((y+1)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if x==1 && -1<=z<=1&& -1<=y<=1
        src = img2;
        X = floor((1-z)/2*(Size-1))+1;
        Y = floor((y+1)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if y==1 && -1<=x<=1 && -1<=z<=1
        src = img3;
        X = floor((1-x)/2*(Size-1))+1;
        Y = floor((1-z)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if x==-1 && -1<=z<=1 && -1<=y<=1
        src = img4;
        X = floor((1-z)/2*(Size-1))+1;
        Y = floor((1-y)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
if y==-1 && -1<=x<=1 && -1<=z<=1
        src = img5;
        X = floor((1-z)/2*(Size-1))+1;
        Y = floor((x+1)/2*(Size-1))+1;
        R = src(X,Y,1);
        G = src(X,Y,2);
        B = src(X,Y,3);
end
end