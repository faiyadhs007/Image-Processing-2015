%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #4
% Date: Nov. 29, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
% Notes: 
% 1) All the images for this problems should be placed in the same directory.
% 2) Please see the RGB image in 24-bit RGB planar while using ImageJ.
% 3) Please make sure all the functions as asked are placed in the same
% directory and used rightly. 
% 4) Functions required to read the raw files: readImage.m (*** Compulsory***)
% 5) Some lines in the code are commented because they were tried for
% answering some part of the questions.
%% Reading the image and placing necessary parameters
close all; clc; clear all;
row = 256; col =512; BytesPerPixel = 3;
fileID = fopen('Training.raw');
[Original_img,Red2,Green2,Blue2] = readImage(fileID, row,col, BytesPerPixel);

%% Segmenting the image
% Converting to black and white (grayscale)
bw_image = rgb2gray(Original_img);
bw_image = ~logical(bw_image);
bw_image = double(bw_image);

% Cropping the image
L = bwlabel(bw_image,4);
rightBound =zeros(1,max(max(L)));
leftBound  =col* ones(1,max(max(L)));
topBound   =row* ones(1,max(max(L)));
bottomBound=zeros(1,max(max(L)));

for i=1:max(max(L))
    for r=1:row
        for c=1:col
            if L(r,c) == i
                 rightBound(1,i)=max(rightBound(1,i),c);
                 leftBound(1,i)=min(leftBound(1,i),c);
                 topBound(1,i)=min(topBound(1,i),r);
                 bottomBound(1,i)=max(bottomBound(1,i),r);
            end
        end
    end
    crop{i}=L(topBound(1,i):bottomBound(1,i),leftBound(1,i):rightBound(1,i));
    % subplot(1,18,i);
    % figure(i);
    % imshow(crop{i})
end

%% Calculating for quads
for i=1:max(max(L))
crop_1 = logical(crop{i});

nq0 = 0;nq1 = 0;nq2 = 0;nq3 = 0;nq4 = 0;nqd = 0;
for r=1:size(crop_1,1)-1
    for c=1:size(crop_1,2)-1
        if crop_1(r,c)+crop_1(r+1,c)+crop_1(r,c+1)+crop_1(r+1,c+1) == 0
            nq0 = nq0 +1; 
        elseif crop_1(r,c)+crop_1(r+1,c)+crop_1(r,c+1)+crop_1(r+1,c+1) == 1
            nq1 = nq1 +1; 
        elseif crop_1(r,c)+crop_1(r+1,c)+crop_1(r,c+1)+crop_1(r+1,c+1) == 3
            nq3 = nq3 +1; 
        elseif crop_1(r,c)+crop_1(r+1,c)+crop_1(r,c+1)+crop_1(r+1,c+1) == 4
            nq4 = nq4 +1;
        elseif crop_1(r,c)+crop_1(r+1,c)+crop_1(r,c+1)+crop_1(r+1,c+1) == 2
            if crop_1(r,c)+crop_1(r+1,c+1) == 2 ||  crop_1(r+1,c)+crop_1(r,c+1) == 2
                nqd = nqd+1;
            else nq2 = nq2+1;
            end
        end
    end
end

nq = nq0+nq1+nq2+nq3+nq4+nqd;

area(i,1) = 1/4*(nq1+ (2*nq2) + (3*nq3) + (4*nq4) + (2*nqd));
perimeter(i,1) = nq1 + nq2 + nq3 + (2*nqd);
euler4(i,1) = 1/4*(nq1- nq3 + (2*nqd));
euler8(i,1) = 1/4*(nq1- nq3 - (2*nqd));
euler_matlab1(i,1) = bweuler(crop_1,4); 
euler_matlab2(i,1) = bweuler(crop_1,8);
circularity(i,1) = (4*pi*area(i,1)) / (perimeter(i,1))^2;
aspect_ratio(i,1) = size(crop_1,2)/size(crop_1,1);

%% Calculating Moments
K = size(crop_1,1); J = size(crop_1,2);

M00(i,1) = sum(sum(crop_1));

M10(i,1) = 0; M01(i,1) =0;
for k =1: K 
    for j = 1: J
        xk = k - .5;
        yj = J + .5 - j;
        M10(i,1) = (1/K)* (xk* crop_1(k,j)) + M10(i,1);
        M01(i,1) = (1/J)* (yj* crop_1(k,j)) + M01(i,1);
    end
end

xk_centroid(i,1) = M10(i,1)/M00(i,1);
yk_centroid(i,1) = M01(i,1)/M00(i,1);

% Hu's moment 
M_hu(:,i) = hu_moment(crop_1);
M_hu_sum(i,1) = sum(M_hu(:,i));

%% Stroke cuts
crop_thin = bwmorph(crop_1,'thin',Inf);
sc_vertical(i,1) = size(find(crop_thin(ceil(size(crop_thin,1)/2),:) == 1),2);
sc_horizontal(i,1) =   size(find(crop_thin(ceil(size(crop_thin,2)/2),:) == 1),2);
sc(i,1) = sc_horizontal(i,1)+ sc_vertical(i,1);
end

%% Feature vectors collection

content_training = [0; 10; 1; 11; 2; 12; 3; 13; 4; 5;...
    14;6; 15; 16;7; 8; 17; 9];
feature_vector_training = [content_training,area,perimeter,euler4,euler8,euler_matlab1,euler_matlab2,...
    circularity,aspect_ratio,M00,M10,M01,M_hu_sum,xk_centroid,yk_centroid,sc_vertical,sc_horizontal,...
    sc];
T_training = array2table(feature_vector_training, ...
    'VariableNames', {'Content' 'Area' 'Perimeter' 'Euler4' 'Euler8' ...
    'Euler_MAT4' 'Euler_MAT8' 'Circularity' 'Aspect_Ratio' 'M00'...
    'M10' 'M01' 'Hu_moment_sum' 'X_Centroid' 'Y_Centroid' 'Vertical_Stroke' 'Horizontal_Stroke'...
    'Stroke_Cuts'});
disp('Training is completed.');