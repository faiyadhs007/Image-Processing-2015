%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc;

%% Reading Red,Green,Blue Channels
row = 512, col =512; BytesPerPixel = 3;
fileID = fopen('the_starry_night.raw');
[out,Red2,Green2,Blue2] = readImage(fileID, row,col, BytesPerPixel);

%% Creating a new image
imgd3=zeros(512,512,3);
im=uint8(imgd3);
for j=1:3
    if j==1
        im(:,:,1)=Red2(:,:);
    end
    if j==2
        im(:,:,2)=Green2(:,:);
    end
    if j==3
        im(:,:,3)=Blue2(:,:);
    end
end

%% Necessary varibales
input_rows = size(im,1);input_cols = size(im,2);
output_rows = 650;output_cols = 650;
S_R = input_rows / output_rows; S_C = input_cols / output_cols; % Scaling factor

%% Create grids for new image
cf1 = 1:650; cf = zeros(650,650);
for i = 1:650
        cf(i,:)=cf1(1,:);
end
rf1 = 1:650; rf = zeros(650,650);
for m = 1:650
        rf(:,m)=rf1(1,:);
end
rf = rf * S_R;cf = cf * S_C;r = floor(rf);c = floor(cf);
diff_r = rf - r; diff_c = cf - c;
    
% Taking care of out of range values
r(r < 1) = 1;
c(c < 1) = 1;
r(r > input_rows - 1) = input_rows - 1;
c(c > input_cols - 1) = input_cols - 1;

%% Indices inside the interpolation formula
x1 = (r +(c-1)*size(im,1)); 
x2 = (r+1)+(c-1).*size(im,1);
x3 = r+(c+1-1).*size(im,1);
x4 = (r+1)+(c+1-1).*size(im,1);

%% The final interpolation step
out = zeros(output_rows, output_cols, size(im, 3));
out = uint8(out);
for k = 1 : 3
temp = double(im(:,:,k)); 
% The final formula of interpolation
final = temp(x1).*(1 - diff_r).*(1 - diff_c) + temp(x2).*(diff_r).*(1 - diff_c)...
+ temp(x3).*(1 - diff_r).*(diff_c) + temp(x4).*(diff_r).*(diff_c);
out(:,:,k) = cast(final, class(im));
end

figure(1); imshow(im); title('Original Image');
figure(2); imshow(out); title('Resized Image');

% finalfile = fopen('the_starry_night_2.raw','w+');
%final = writeImage(finalfile,out,row,col);
%% Writing the raw image
new_row = size(out,1);new_col = size(out,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_row
        for c = 1:new_col
            final(r,c,k)=out(c,r,k);
        end
    end
end
fid = fopen('solution1a.raw','w+');
finalImage = fwrite(fid,final,'uint8');