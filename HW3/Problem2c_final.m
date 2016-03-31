%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
clear all; clc;
row = 512; col =512; BytesPerPixel = 3;
fileID = fopen('Sailboat.raw');
[A,R,G,B] = readImage(fileID, row,col, BytesPerPixel);

%% Coverting to CMYK 
% Method-1: Using simple transformation formula
C = 1-(double(R)/255); M =1-(double(G)/255); Y =1-(double(B)/255);
CMYK_img = zeros(row,col,3);
for r =1:row
    for c =1:col
        CMYK_img(r,c,1)= C(r,c);
        CMYK_img(r,c,2)= M(r,c);
        CMYK_img(r,c,3)= Y(r,c);
    end
end
imshow(CMYK_img,[0,1]); title('CMYK image');

%% FS Error Diffusion on the CMY image

FSED_CMYK = zeros(row,col,3);

FSED_CMYK(:,:,1) = fsed(CMYK_img(:,:,1),0,1);
FSED_CMYK(:,:,2) = fsed(CMYK_img(:,:,2),0,1);
FSED_CMYK(:,:,3) = fsed(CMYK_img(:,:,3),0,1);

%% Converting to final image

Final_img = uint8(zeros(row,col,3));

Final_img(:,:,1) = 255*(1-FSED_CMYK(:,:,1));
Final_img(:,:,2) = 255*(1-FSED_CMYK(:,:,2));
Final_img(:,:,3) = 255*(1-FSED_CMYK(:,:,3));

figure;imshow(Final_img); title('Scalar Color Halftoning');

%% Writing raw image
new_row = size(Final_img,1);new_col = size(Final_img,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            final(r,c,k)=Final_img(c,r,k);
        end
    end
end
fid = fopen('sailboat_scalar.raw','w+');
finalImage = fwrite(fid,final,'uint8');