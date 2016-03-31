%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
close all; clear all; clc;
%% Reading the file
row= 275; col = 360;BytesPerPixel = 1;
fileID = fopen('Horse1.raw');
I = fread(fileID, row*col*BytesPerPixel,'uint8'); 

%% Reading the image
I1 = zeros(row,col);
i =1;
for r=1:row
    for c=1:col
        I1(r,c)=I(i,1);
        i=i+1;
    end 
end
I2 = uint8(I1); 
imshow(I2)

%% Thinning Comparisons Mask
     
%% Hole-filling & Boundary Smoothing

% Hole_filled_image =imfill(I2); %I2; %;
% figure; imshow(Hole_filled_image);title('Hole filled image');

%Dilated_image = dilation(I2,3);
%Dilated_image = dilation(Dilated_image,3);
%Dilated_image = dilation(Dilated_image,3);
%Dilated_image = dilation(Dilated_image,3);

% figure
% imshow(Dilated_image);
% title('Dilated image');

% Closed_image = erosion(Dilated_image,3);
% Closed_image = erosion(Closed_image,3);
% Closed_image = erosion(Closed_image,3);
% Hole_filled_image = erosion(Closed_image,3);

% figure
% imshow(Hole_filled_image);
% title('Closed image');

% filled_image = dilation(I2,3);
% filled_image = dilation(filled_image,3);
% 
% smoothened_image = gaussianFilter3(filled_image);
% smoothened_image = gaussianFilter3(smoothened_image);
% % smoothened_image = gaussianFilter3(smoothened_image);
% 
% figure; imshow(logical(smoothened_image));title('Smoothened image 01');
% 
% Dilated_image = erosion(smoothened_image,3);
% 
% smoothed_image = imdilate(Dilated_image,strel('line',11,7));
% figure; imshow(smoothed_image);title('MATLAB dilation image');
preprocessed_image = thinning_pre_processing(I2);

%% Thinning with function 02 (without pre-processing)

Subtractive_image1 = thinning2(I2,row,col);
figure;imshow(Subtractive_image1); title('One-pass thinning');

for i=1:70
    Subtractive_image1 = thinning2(Subtractive_image1,row,col);
    imshow(Subtractive_image1);
end
figure; imshow(logical(Subtractive_image1));title('Thining without pre-processing');
%% Thinning with function 02 (with pre-processing)

Subtractive_image = thinning2(preprocessed_image,row,col);
figure;imshow(Subtractive_image); title('One-pass thinning');

for i=1:70
    Subtractive_image = thinning2(Subtractive_image,row,col);
    imshow(Subtractive_image);
end
figure; imshow(logical(Subtractive_image));title('Thining with pre-processing');

%% Writing raw image
final_1 = (Subtractive_image);
final_2 = (Subtractive_image1);
new_row = size(Subtractive_image,1);new_col = size(Subtractive_image,2);
horseshoe_thinned1 = (zeros(new_col,new_row));
horseshoe_thinned2 = (zeros(new_col,new_row));
for r = 1:new_col 
    for c = 1:new_row
        horseshoe_thinned1(r,c)=255*final_1(c,r);
        horseshoe_thinned2(r,c)=255*final_2(c,r);

    end
    end

fid1 = fopen('horseshoe_thinned_with_preprocesisng.raw','w+');
finalImage = fwrite(fid1,horseshoe_thinned1,'uint8');
fid2 = fopen('horseshoe_thinned_without_preprocesisng.raw','w+');
finalImage = fwrite(fid2,horseshoe_thinned2,'uint8');