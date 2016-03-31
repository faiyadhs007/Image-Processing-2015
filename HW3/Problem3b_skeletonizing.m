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

%% Masks 
%% Hole-filling 
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

%% Boundary Smoothing
% filled_image = dilation(I2,3);
% filled_image = dilation(filled_image,3);
% 
% smoothened_image = gaussianFilter3(filled_image);
% % for r=1:row
% %     for c=1:col
% % if smoothened_image(r,c) >=128
% %     smoothened_image =1;
% % else smoothened_image=0;
% % end
% %     end
% % end
% smoothened_image = gaussianFilter3(smoothened_image);
% % smoothened_image = gaussianFilter3(smoothened_image);
% 
% figure; imshow(logical(smoothened_image));title('Smoothened image 01');
% 
% Dilated_image = erosion(smoothened_image,3);
% 
% smoothed_image = imfill(Dilated_image);

preprocessed_image = skeletonizing_pre_processing(I2);

%% Skeletonizing with function (without pre-processing)
Subtractive_image1 = skeletonizing(I2,row,col);
figure;imshow(Subtractive_image1); title('One-pass skeletonizing');

for i=1:70
    Subtractive_image1 = thinning2(Subtractive_image1,row,col);
    imshow(Subtractive_image1); title('Skeleteonized image')
end
figure; imshow(Subtractive_image1); title('Skeleteonized image without pre-processing')
%% Skeletonizing with function (with pre-processing)

Subtractive_image = skeletonizing(preprocessed_image,row,col);
figure;imshow(Subtractive_image); title('One-pass skeletonizing');

for i=1:70
    Subtractive_image = thinning2(Subtractive_image,row,col);
    imshow(Subtractive_image); title('Skeleteonized image')
end
figure; imshow(Subtractive_image); title('Skeleteonized image with pre-processing');

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
fid1 = fopen('horseshoe_skeletonized_with_preprocesisng.raw','w+');
finalImage = fwrite(fid1,horseshoe_thinned1,'uint8');
fid2 = fopen('horseshoe_skeletonized_without_preprocesisng.raw','w+');
finalImage = fwrite(fid2,horseshoe_thinned2,'uint8');