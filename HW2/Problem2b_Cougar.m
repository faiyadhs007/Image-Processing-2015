%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Oct. 11, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
clear all; clc;
row = 321; col =481; BytesPerPixel = 3;
fileID = fopen('Cougar.raw');
[out,Red2,Green2,Blue2] = readImage(fileID, row,col, BytesPerPixel);
%% Converting image to grayscale & Extension
BW = .21*Red2 + .72*Green2 + .07*Blue2;
imshow(BW);figure
%% Applying Canny Edge Detector using various thresholds 
Canny_Cougar_1 = edge(BW,'canny',[.3 .6]); imshow(1-Canny_Cougar_1);figure
Canny_Cougar_2 = edge(BW,'canny',[.2 .7]); imshow(1-Canny_Cougar_2);figure
Canny_Cougar_3 = edge(BW,'canny',[.2 .5]); imshow(1-Canny_Cougar_3);figure
Canny_Cougar_4 = edge(BW,'canny',[.4 .7]); imshow(1-Canny_Cougar_4);figure
Canny_Cougar_5 = edge(BW,'canny',[.4 .5]); imshow(1-Canny_Cougar_5);figure
[Canny_Cougar_6,thresh] = edge(BW,'canny'); imshow(1-Canny_Cougar_6);
% There is a value for lower threshold which is good enough to find the
% edge marks. & the higher threshold should be having a lesser distance
% between lower and higher threshold.

%% Writing the image to raw format
new_row = 321;new_col = 481;
for r = 1:new_row
    for c = 1:new_col
        Canny_Cougar1(c,r)=Canny_Cougar_1(r,c);
        Canny_Cougar2(c,r)=Canny_Cougar_2(r,c);
        Canny_Cougar3(c,r)=Canny_Cougar_3(r,c);
        Canny_Cougar4(c,r)=Canny_Cougar_4(r,c);
        Canny_Cougar5(c,r)=Canny_Cougar_5(r,c);
        Canny_Cougar6(c,r)=Canny_Cougar_6(r,c);
    end
end
fid1 = fopen('Canny_Cougar1.raw','w+'); fid2 = fopen('Canny_Cougar2.raw','w+');
fid3 = fopen('Canny_Cougar3.raw','w+');fid4 = fopen('Canny_Cougar4.raw','w+');
fid5 = fopen('Canny_Cougar5.raw','w+');fid6 = fopen('Canny_Cougar6.raw','w+');
finalImage1 = fwrite(fid1,im2uint8(1-Canny_Cougar1));
finalImage2 = fwrite(fid2,im2uint8(1-Canny_Cougar2));
finalImage3 = fwrite(fid3,im2uint8(1-Canny_Cougar3));
finalImage4 = fwrite(fid4,im2uint8(1-Canny_Cougar4));
finalImage5 = fwrite(fid5,im2uint8(1-Canny_Cougar5));
finalImage6 = fwrite(fid6,im2uint8(1-Canny_Cougar6));