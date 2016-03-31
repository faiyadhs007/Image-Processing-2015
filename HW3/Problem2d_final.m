%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
close all; clc;
row = 512; col =512; BytesPerPixel = 3;
fileID = fopen('Sailboat.raw');
[I,R,G,B] = readImage(fileID, row,col, BytesPerPixel);
imshow(I); title('Sailboat.raw (Original)');

%% Coverting to CMYK from RGB
CMYK_image = zeros(row,col,3);

CMYK_image = RGBtoCMYK(I);

figure;imshow(CMYK_image);title('CMYK Image');

%% Converting to CMYK from RGB Version 02
CMYK_image02 = zeros(row,col);
K_factor = zeros(row,col);
I1 = double(I);

for r = 1:row
    for c = 1:col

        Red = double(I1(r,c,1)/255);
        Green = double(I1(r,c,2)/255);
        Blue = double(I1(r,c,3)/255);
% Calculating K factor
        max_values = [Red,Green,Blue];
        K_value = 1-max(max_values);
        K_factor(r,c) = K_value + (1/10000);
% Calculating CMY       
        CMYK_image02(r,c,1) = double((1-Red-K_value)/(1-K_value));
        CMYK_image02(r,c,2) = double((1-Green-K_value)/(1-K_value));
        CMYK_image02(r,c,3) = double((1-Blue-K_value)/(1-K_value));
    end
end
figure;imshow(CMYK_image02);title('CMYK Image- version 02');

%% Extending CMYK image- Version 01
window_size=3; mid = (window_size-1)/2;
CMYK_extended = extension1(CMYK_image, window_size);

%% Extending CMYK image- Version 02
window_size=3; mid = (window_size-1)/2;
CMYK_extended02 = extension1(CMYK_image02, window_size);

%% Applying MBVQ without color error diffusion - Version 01

CMYK_final1 = double(zeros(row,col,3));
error1 = zeros(1,1,3); type1 = ''; 

for r = 1:row
    for c = 1:col
        
        % Find MVBQ type (Pseudo code from the paper)
        type2 = mvbq(CMYK_extended(r+mid,c+mid,:));
        
        % Find the nearest vertex 
        [CMYK_final1(r,c,:),error2] = nearest_vertex(CMYK_extended(r+mid,c+mid,:),type2);
        
    end
end

%% Converting to RGB - Version 01 (without error diffusion)
RGB_final1 = double(zeros(row,col,3));

RGB_final1 = CMYKtoRGB(CMYK_final1);

figure; imshow(uint8(RGB_final1)); title('Results of Vector Color Halftoning without color error diffusion');

%% Applying MBVQ with color error diffusion - Version 01

CMYK_final2 = double(zeros(row,col,3));
error2 = zeros(1,1,3); type2 = ''; 

for r = 1:row
    for c = 1:col
        
        % Find MVBQ type (Pseudo code from the paper)
        type2 = mvbq(CMYK_extended(r+mid,c+mid,:));
        
        % Find the nearest vertex 
        [CMYK_final2(r,c,:),error2] = nearest_vertex(CMYK_extended(r+mid,c+mid,:),type2);
        
        % Diffuse the error to future pixels
        CMYK_extended(r+mid,(c+1)+mid,:) = CMYK_extended(r+mid,(c+1)+mid,:) + (7/16).*error2(1,1,:);
        CMYK_extended((r+1)+mid,(c+1)+mid,:) = CMYK_extended((r+1)+mid,(c+1)+mid,:) + (1/16).*error2(1,1,:);
        CMYK_extended((r+1)+mid,c+mid,:) = CMYK_extended((r+1)+mid,c+mid,:) + (5/16).*error2(1,1,:);
        CMYK_extended((r+1)+mid,(c-1)+mid,:) = CMYK_extended((r+1)+mid,(c-1)+mid,:) + (3/16).*error2(1,1,:);      
    end
end

%% Converting to RGB - Version 01 (with error diffusion)

RGB_final2 = double(zeros(row,col,3));

RGB_final2 = CMYKtoRGB(CMYK_final2);

figure; imshow(uint8(RGB_final2)); title('Results of Vector Color Halftoning with color error diffusion');
 close all; 
%% Applying MBVQ without color error diffusion - Version 02

CMYK_final3 = double(zeros(row,col,3));
error1 = zeros(1,1,3); type1 = ''; 

for r = 1:row
    for c = 1:col
        
        % Find MVBQ type (Pseudo code from the paper)
        type2 = mvbq(CMYK_extended02(r+mid,c+mid,:));
        
        % Find the nearest vertex 
        [CMYK_final3(r,c,:),error2] = nearest_vertex(CMYK_extended02(r+mid,c+mid,:),type2);
        
    end
end

RGB_final3 = double(zeros(row,col,3));

%% Converting to RGB - Version 02 (without error diffusion)
for r = 1:row
    for c = 1:col
        RGB_final3(r,c,1) = 255*(1-CMYK_final3(r,c,1))*(1-K_factor(r,c));
        RGB_final3(r,c,2) = 255*(1-CMYK_final3(r,c,2))*(1-K_factor(r,c));
        RGB_final3(r,c,3) = 255*(1-CMYK_final3(r,c,3))*(1-K_factor(r,c));
    end
end

figure; imshow(uint8(RGB_final3)); title('Results of Vector Color Halftoning without color error diffusion-Version 02');

%% Applying MBVQ with color error diffusion - Version 02
CMYK_final4 = double(zeros(row,col,3));
error1 = zeros(1,1,3); type1 = ''; 

for r = 1:row
    for c = 1:col
        
        % Find MVBQ type (Pseudo code from the paper)
        type4 = mvbq(CMYK_extended02(r+mid,c+mid,:));
        
        % Find the nearest vertex 
        [CMYK_final4(r,c,:),error2] = nearest_vertex(CMYK_extended02(r+mid,c+mid,:),type4);
        
        % Diffuse the error to future pixels
        CMYK_extended02(r+mid,(c+1)+mid,:) = CMYK_extended02(r+mid,(c+1)+mid,:) + (7/16).*error2(1,1,:);
        CMYK_extended02((r+1)+mid,(c+1)+mid,:) = CMYK_extended02((r+1)+mid,(c+1)+mid,:) + (1/16).*error2(1,1,:);
        CMYK_extended02((r+1)+mid,c+mid,:) = CMYK_extended02((r+1)+mid,c+mid,:) + (5/16).*error2(1,1,:);
        CMYK_extended02((r+1)+mid,(c-1)+mid,:) = CMYK_extended02((r+1)+mid,(c-1)+mid,:) + (3/16).*error2(1,1,:);
        
        % Applying Stucki error diffusion
%         CMYK_extended02(r+2,c+3) = CMYK_extended02(r+2,c+3) + ((8/42)*error);
%         CMYK_extended02(r+2,c+4) = CMYK_extended02(r+2,c+4) + ((4/42)*error);
%         CMYK_extended02(r+3,c+0) = CMYK_extended02(r+3,c+0) + ((2/42)*error);
%         CMYK_extended02(r+3,c+1) = CMYK_extended02(r+3,c+1) + ((4/42)*error);
%         CMYK_extended02(r+3,c+2) = CMYK_extended02(r+3,c+2) + ((8/42)*error);
%         CMYK_extended02(r+3,c+3) = CMYK_extended02(r+3,c+3) + ((4/42)*error);
%         CMYK_extended02(r+3,c+4) = CMYK_extended02(r+3,c+4) + ((2/42)*error);
%         CMYK_extended02(r+4,c+0) = CMYK_extended02(r+4,c+0) + ((1/42)*error);
%         CMYK_extended02(r+4,c+1) = CMYK_extended02(r+4,c+1) + ((2/42)*error);
%         CMYK_extended02(r+4,c+2) = CMYK_extended02(r+4,c+2) + ((4/42)*error);
%         CMYK_extended02(r+4,c+3) = CMYK_extended02(r+4,c+3) + ((2/42)*error);
%         CMYK_extended02(r+4,c+4) = CMYK_extended02(r+4,c+4) + ((1/42)*error);
    end
end

%% Converting to RGB - Version 02 (with error diffusion)
RGB_final4 = double(zeros(row,col,3));


for r = 1:row
    for c = 1:col
        RGB_final4(r,c,1) = 255*(1-CMYK_final4(r,c,1))*(1-K_factor(r,c));
        RGB_final4(r,c,2) = 255*(1-CMYK_final4(r,c,2))*(1-K_factor(r,c));
        RGB_final4(r,c,3) = 255*(1-CMYK_final4(r,c,3))*(1-K_factor(r,c));
    end
end

figure; imshow(uint8(RGB_final4)); title('Results of Vector Color Halftoning with color error diffusion-Version 02');

%% Image quality assessment using SSIM
a = ssim(I, uint8(RGB_final1));
b = ssim(I, uint8(RGB_final2));
c = ssim(I, uint8(RGB_final3));
d = ssim(I, uint8(RGB_final4));
%% Writing raw image
new_row = size(RGB_final4,1);new_col = size(RGB_final4,2);
sailboat_vector_without = uint8(zeros(new_col,new_row,3));
sailboat_vector_with= uint8(zeros(new_col,new_row,3));
for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            sailboat_vector_without(r,c,k)=RGB_final3(c,r,k);
            sailboat_vector_with(r,c,k)=RGB_final4(c,r,k);

        end
    end
end

fid1 = fopen('sailboat_vector_no_quantization.raw','w+');
finalImage = fwrite(fid1,sailboat_vector_without,'uint8');

fid2 = fopen('sailboat_vector_with_quantization.raw','w+');
finalImage = fwrite(fid2,sailboat_vector_with,'uint8');