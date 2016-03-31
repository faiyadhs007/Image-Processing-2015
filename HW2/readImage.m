function [ imgf,Red2,Green2,Blue2 ] = readImage(fileID,row,col,BytesPerPixel)

%% ------------------------------------------------------------------------%
% Created by Faiyadh Shahid

% [imagf]  = readImage(fileID, row, col, BytesPerPixel) reads the raw image
% format. The input variables required are the fileID of the image which is
% is provided by fopen function; height, width and bytes per pixel in the
% image

% [imgf,Red2,Green2,Blue2 ] returns result of individual color channels:
% Red, Green, Blue, when called. 

%   Copyright 2015 Faiyadh Shahid, USC.
%   Custom function.

%% ------------------------------------------------------------------------%
img = fread(fileID, row*col*BytesPerPixel,'uint8');

%% Extracting red channel
Red1 = zeros(row,col);
i =1;
for r=1:row
    for c=1:col
        Red1(r,c)=img(i,1);
        i=i+3;
    end 
end
Red2 = uint8(Red1);

%% Extracting green channel
Green1 = zeros(row,col);
i =2;
for r=1:row
    for c=1:col
        Green1(r,c)=img(i,1);
        i=i+3;
    end 
end
Green2 = uint8(Green1);

%% Extracting blue channel
Blue1 = zeros(row,col);
i =3;
for r=1:row
    for c=1:col
        Blue1(r,c)=img(i,1);
        i=i+3;
    end 
end
Blue2 = uint8(Blue1); 

%% Bringing them all together
imgf=zeros(row,col,BytesPerPixel);
imgf=uint8(imgf);
for j=1:3
    if j==1
        imgf(:,:,1)=Red2(:,:);
    end
    if j==2
        imgf(:,:,2)=Green2(:,:);
    end
    if j==3
        imgf(:,:,3)=Blue2(:,:);
    end
end
end

