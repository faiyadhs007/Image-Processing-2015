%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Oct. 11, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
clear all; clc;
row = 321; col =481; BytesPerPixel = 3;
fileID = fopen('Farm.raw');
[out,Red2,Green2,Blue2] = readImage(fileID, row,col, BytesPerPixel);
%% Converting image to grayscale & Extension
BW =(.21*Red2 + .72*Green2 + .07*Blue2);
imshow(BW);figure
%% Applying Canny Edge Detector using various thresholds 
Canny_Farm_1 = edge(BW,'canny',[.3 .6]); imshow(~Canny_Farm_1);figure
Canny_Farm_2 = edge(BW,'canny',[.2 .7]); imshow(~Canny_Farm_2);figure
Canny_Farm_3 = edge(BW,'canny',[.2 .5]); imshow(~Canny_Farm_3);figure
Canny_Farm_4 = edge(BW,'canny',[.4 .7]); imshow(~Canny_Farm_4);figure
Canny_Farm_5 = edge(BW,'canny',[.4 .5]); imshow(~Canny_Farm_5);figure
[Canny_Farm_6,thresh] = edge(BW,'canny'); imshow(~Canny_Farm_6);


%% Writing the image to raw format
new_row = size(BW,1);new_col = size(BW,2);

for r = 1:new_row
    for c = 1:new_col
        Canny_Farm1(c,r)=Canny_Farm_1(r,c);
        Canny_Farm2(c,r)=Canny_Farm_2(r,c);
        Canny_Farm3(c,r)=Canny_Farm_3(r,c);
        Canny_Farm4(c,r)=Canny_Farm_4(r,c);
        Canny_Farm5(c,r)=Canny_Farm_5(r,c);
        Canny_Farm6(c,r)=Canny_Farm_6(r,c);
    end
end
fid1 = fopen('Canny_Farm1.raw','w+'); fid2 = fopen('Canny_Farm2.raw','w+');
fid3 = fopen('Canny_Farm3.raw','w+');fid4 = fopen('Canny_Farm4.raw','w+');
fid5 = fopen('Canny_Farm5.raw','w+');fid6 = fopen('Canny_Farm6.raw','w+');
finalImage1 = fwrite(fid1,im2uint8(1-Canny_Farm1));
finalImage2 = fwrite(fid2,im2uint8(1-Canny_Farm2));
finalImage3 = fwrite(fid3,im2uint8(1-Canny_Farm3));
finalImage4 = fwrite(fid4,im2uint8(1-Canny_Farm4));
finalImage5 = fwrite(fid5,im2uint8(1-Canny_Farm5));
finalImage6 = fwrite(fid6,im2uint8(1-Canny_Farm6));