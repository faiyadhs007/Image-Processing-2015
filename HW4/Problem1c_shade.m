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
close all; clc;clear all;
row = 361; col =215; BytesPerPixel = 3;
fileID = fopen('Test_shade.raw');
[Original_img,Red2,Green2,Blue2] = readImage(fileID, row,col, BytesPerPixel);

%% Pre-processing steps

bw_image  = rgb2gray(Original_img);
bw_image = double(bw_image);

for r =1:row
    for c=1:col
        if bw_image(r,c) <= 127
            bw_image(r,c) = 1;
        else bw_image(r,c) =0;
        end
    end
end
imshow(bw_image);

L = bwlabel(bw_image,8);

% Cropping
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
    crop{i} = dilation(crop{i},3);
    crop{i} = logical(crop{i});
%     figure(i);
%     imshow(~crop{i})
end

for i = 1: max(size(crop))
    if size(crop{i},1)>5 && size(crop{i},2)>=  4
        crop_new{i} = crop{i};
    else crop_new{i} = [];
    end
end

crop_new2 = crop_new(~cellfun(@isempty,crop_new));

% for i=1:27
%     figure(i);
%     imshow(~crop_new2{i});
% end

%% Calculating for quads
for i=1:size(crop_new2,2)
crop_1 = logical(crop_new2{i});
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

%% Feature vector collection

content_test4 = [77; 77; 10; 10; 2; 18; 14; 11; 11; 15;...
                 19; 16; 77; 12; 12; 20; 5; 12; 15; 12;...
                 17; 21; 77; 13; 13; 77; 77];

feature_vector_test4 = [content_test4,area,perimeter,euler4,euler8,euler_matlab1,euler_matlab2,...
    circularity,aspect_ratio,M00,M10,M01,M_hu_sum,xk_centroid,yk_centroid,sc_vertical,sc_horizontal,...
    sc];

T_test4 = array2table(feature_vector_test4, ...
    'VariableNames', {'Content' 'Area' 'Perimeter' 'Euler4' 'Euler8' ...
    'Euler_MAT4' 'Euler_MAT8' 'Circularity' 'Aspect_Ratio' 'M00'...
    'M10' 'M01' 'Hu_moment_sum' 'X_Centroid' 'Y_Centroid' 'Vertical_Stroke' 'Horizontal_Stroke'...
    'Stroke_Cuts'});

T_test1 = sortrows(T_test4,'Content','ascend');

fprintf(' Note: For this problem: \n segment 1 is 2; segment 2 is 5; segment 9 is S;\n segment 4 is S; segment 5 is P; segment 6 is P; \n segment 7 is E; segment 8 is E; segment 9 is E;\n segment 10 is E; segment 11 is D; segment 12 is D; \n segment 13 is L; segment 14 is I; segment 15 is I;\n segment 16 is M; segment 17 is T; segment 18 is T\n segment 19-27 is others \n Please check from the segmented images\n');
disp('------------------------------------------------------------------');

%% Decision Tree Classifier 
for i=1:size(T_test1,1)
    
    if T_test1.Euler_MAT8(i,1) == -1
        fprintf('The output for segment %d is 8\n',i);
    
    elseif T_test1.Euler_MAT8(i,1) == 0
        if T_test1.Horizontal_Stroke(i,1) <= 1 
            fprintf('The output for segment %d is 6\n',i);
        elseif  T_test1.Horizontal_Stroke(i,1) > 1 
            if T_test1.Circularity(i,1) >= .25 
                if T_test1.X_Centroid(i,1) >.40 
                    fprintf('The output for segment %d is D\n',i);
                else fprintf('The output for segment %d is P\n',i);
                end
            elseif T_test1.Circularity(i,1) < .25 
                if T_test1.Area(i,1) <1000
                    fprintf('The output for segment %d is 4\n',i);
                elseif T_test1.Area(i,1) >1000
                    if T_test1.Vertical_Stroke(i,1) <= 2 
                        fprintf('The output for segment %d is 0\n',i);
                    else fprintf('The output for segment %d is 9\n',i);
                    end
                end
            end
        end
        
    elseif T_test1.Euler_MAT8(i,1) == 1
        if T_test1.Circularity(i,1) == Inf 
            fprintf('The output for segment %d is I\n',i);
        elseif T_test1.Circularity(i,1) ~= Inf
            if T_test1.Aspect_Ratio(i,1) < .50 
                fprintf('The output for segment %d is 1\n',i);
            elseif T_test1.Aspect_Ratio(i,1) >= .50 
                if T_test1.X_Centroid(i,1) > .60 
                    fprintf('The output for segment %d is L\n',i);
                elseif T_test1.X_Centroid(i,1) < .40
                    if T_test1.Y_Centroid(i,1) < .50 
                        fprintf('The output for segment %d is 7\n',i);
                    else fprintf('The output for segment %d is T\n',i);
                    end
                elseif .60<= T_test1.X_Centroid(i,1) <=.40
                    if T_test1.Horizontal_Stroke(i,1) > 1 
                        fprintf('The output for segment %d is M\n',i);
                    elseif T_test1.Horizontal_Stroke(i,1) <= 1
                        if T_test1.X_Centroid(i,1) > .51
                            fprintf('The output for segment %d is 2\n',i);
                        elseif T_test1.X_Centroid(i,1) < .51
                            if T_test1.Y_Centroid(i,1) <= .45 
                                fprintf('The output for segment %d is 3\n',i);
                            elseif T_test1.Y_Centroid(i,1) > .55
                                 fprintf('The output for segment %d is E\n',i);
                            elseif .55<= T_test1.Y_Centroid(i,1) <.45
                                if T_test1.Vertical_Stroke(i,1) > 2 
                                    fprintf('The output for segment %d is S\n',i);
                                else fprintf('The output for segment %d is 5\n',i);
                                end
                            end
                        end
                    end        
                end
            end
        end
    else fprintf('The output for segment %d is others\n',i);
    end
end