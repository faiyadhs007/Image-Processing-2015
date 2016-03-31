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
BW = extension(BW,3);
C = double(BW);

%% Applying Sobel edge mask
for  r= 1:size(BW,1)-2
    for c = 1:size(BW,2)-2
        Gx(r,c)=.25*((2*C(r+2,c+1)+C(r+2,c)+C(r+2,c+2))-(2*C(r,c+1)+C(r,c)+C(r,c+2)));
        Gy(r,c)=.25*((2*C(r+1,c+2)+C(r,c+2)+C(r+2,c+2))-(2*C(r+1,c)+C(r,c)+C(r+2,c)));
    end
end
Gx_img = uint8(255-Gx);Gy_img = uint8(255-Gy);
B=uint8((sqrt(Gx.^2+Gy.^2))/sqrt(2)); B_img =255-B;
imshow(Gx_img);title('Sobel Mask on Horizontal');figure
imshow(Gy_img);title('Sobel Mask on Vertical');figure
imshow(B_img);title('Sobel Mask on Final Image'); figure

%% Choosing thresholds
% Finding thresholds using cumulative histogram
B_hist = myHist(row,col,B); stem(1:256,B_hist); 
xlabel('Intensity values'); ylabel('Number of pixels');
title(' Histogram for Cougar.raw');
figure
B_cumu = cumuHist(B_hist,row,col); stem(1:256, B_cumu);
xlabel('Intensity values'); ylabel('Number of pixels');
title('Cumulative histogram for Cougar.raw')
figure

% for 10% the value is 30 
Thresh10= 30;B_thresh10 = B;
for r =1:row
    for c = 1:col
        if B(r,c) > Thresh10
            B_thresh10(r,c) = B(r,c);
        else B_thresh10(r,c) = 0;
        end
    end
end
B1=uint8(255-B_thresh10);imshow(B1);title('Edge detected Image for 10%');
figure

% for 15% the value is 25
Thresh15= 25;B_thresh15 = B;
for r =1:row
    for c = 1:col
        if B(r,c) > Thresh15
            B_thresh15(r,c) = B(r,c);
        else B_thresh15(r,c) = 0;
        end
    end
end
B2=uint8(255-B_thresh15);imshow(B2);title('Edge detected Image for 15%');
figure
theta = atan(Gy./Gx);

%% Non-Maximum Suppression
B3 = nonmaxsupp(double(B_thresh10),theta); B3_img = uint8(255-B3);
imshow(B3_img); title('Non-Maximum Suppression for Thresh10');
figure
B4 = nonmaxsupp(double(B_thresh15),theta); B4_img = uint8(255-B4);
imshow(B4_img);title('Non-Maximum Suppression for Thresh15');

%% Writing the raw image
new_row = size(B2,1);new_col = size(B2,2);

for r = 1:new_row
    for c = 1:new_col
        Cougar_Gx(c,r)=Gx_img(r,c);
        Cougar_Gy(c,r)=Gy_img(r,c);
        Cougar_Gradient(c,r)=B_img(r,c);
        Cougar_thresh10(c,r)=B1(r,c);
        Cougar_thresh15(c,r)=B2(r,c);
        Cougar_nms_10(c,r)=B3_img(r,c);
        Cougar_nms_15(c,r)=B4_img(r,c);
    end
end
fid1 = fopen('Cougar_Gx.raw','w+'); 
fid2 = fopen('Cougar_Gy.raw','w+');
fid3 = fopen('Cougar_Gradient.raw','w+');
fid4 = fopen('Cougar_thresh10.raw','w+');
fid5 = fopen('Cougar_thresh15.raw','w+');
fid6 = fopen('Cougar_nms_10.raw','w+');
fid7 = fopen('Cougar_nms_15.raw','w+');
finalImage1 = fwrite(fid1,Cougar_Gx,'uint8');
finalImage2 = fwrite(fid2,Cougar_Gy,'uint8');
finalImage3 = fwrite(fid3,Cougar_Gradient,'uint8');
finalImage4 = fwrite(fid4,Cougar_thresh10,'uint8');
finalImage5 = fwrite(fid5,Cougar_thresh15,'uint8');
finalImage6 = fwrite(fid6,Cougar_nms_10,'uint8');
finalImage7 = fwrite(fid7,Cougar_nms_15,'uint8');