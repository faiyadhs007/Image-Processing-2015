%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc;
row= 512; col = 512;BytesPerPixel = 3;

%% Reading Red,Green,Blue Channels
fileID = fopen('peppers.raw');
out = readImage(fileID, row,col, BytesPerPixel);
fileID1 = fopen('peppers_noisy.raw');
[out1,Red2,Green2,Blue2] = readImage(fileID1, row,col, BytesPerPixel);
imshow(out1);figure

%% Remove the % to plot the histogram
h_r = myHist(row,col,Red2);  %plot(1:256,h_r); title('Histogram of red channel');figure
h_g = myHist(row,col,Green2); %plot(1:256,h_g); title('Histogram of green channel');figure
h_b = myHist(row,col,Blue2); %plot(1:256,h_b); title('Histogram of blue channel');figure

%% Median Filter on all three channels (3x3 window-default)
% Change the window by changing the number in function name 
% to the number you want 
Red_median = medianFilter3(Red2);
Green_median =medianFilter3(Green2);
Blue_median =medianFilter3(Blue2);

%% Averaging Filter on all three channels (3x3 window-default) 
% Change the window by changing the number in function name 
% to the number you want 
Red_Gaussian = gaussianFilter3( Red2);
Green_Gaussian =gaussianFilter3(Green2);
Blue_Gaussian =gaussianFilter3(Blue2);

%% Applying Median Filter first, then Gaussian Filter (3x3-default)
% Change the window by changing the number in function name 
% to the number you want
Red_median_first = medianFilter3(Red2);
Green_median_first =medianFilter3(Green2);
Blue_median_first =medianFilter3(Blue2);

Red_Gaussian_second = gaussianFilter3( Red_median_first);
Green_Gaussian_second =gaussianFilter3(Green_median_first);
Blue_Gaussian_second =gaussianFilter3(Blue_median_first);

Median_Gaussian = combineRGB(3, Red_Gaussian_second,Green_Gaussian_second,Blue_Gaussian_second);
imshow(Median_Gaussian)

%% Applying Averaging Filter first, then Median Filter
% %Change the window by changing the number in function name 
% %to the number you want
% Red_Gaussian_first = gaussianFilter3( Red_Gaussian);
% Green_Gaussian_first =gaussianFilter3(Green_Gaussian);
% Blue_Gaussian_first =gaussianFilter3(Blue_Gaussian);
% 
% Red_median_second = medianFilter3(Red_Gaussian_first);
% Green_median_second =medianFilter3(Green_Gaussian_first);
% Blue_median_second =medianFilter3(Blue_Gaussian_first);
% 
% Gaussian_Median = combineRGB(3,Red_median_second,Green_median_second,Blue_median_second);
% imshow(Gaussian_Median)

%% Writing Raw Image
out  = Median_Gaussian;
new_row = size(out,1);new_col = size(out,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            final(r,c,k)=out(c,r,k);
        end
    end
end
fid = fopen('Problem3a.raw','w+');
finalImage = fwrite(fid,final,'uint8');