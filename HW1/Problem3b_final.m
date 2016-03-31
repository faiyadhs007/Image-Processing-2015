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
eps1 = 0.1^2; eps2 =0.2^2; eps3 = 0.8^2; % epsilon for guided image filtering

%% Reading Red,Green,Blue Channels
fileID = fopen('peppers.raw');
[out,Red1,Green1,Blue1] = readImage(fileID, row,col, BytesPerPixel);
fileID1 = fopen('peppers_noisy.raw');
[guide,Red2,Green2,Blue2] = readImage(fileID1, row,col, BytesPerPixel);
% imshow(guide);figure

%% Guided Image Filtering (3x3-default)
% Change the window by changing the number in function name 
% to the number you want
Ir_f1 = guidedChannel3(Red2,eps3);
Ig_f1 = guidedChannel3(Green2,eps3);
Ib_f1 = guidedChannel3(Blue2,eps3);
I_f1 = cat(3,Ir_f1,Ig_f1,Ib_f1);
imshow(uint8(guide)); title('Guided Image');figure; imshow(uint8(I_f1)); title('Filtered image');figure

%% Cartoon Matting Effect (Part c)
CR1 = guidedChannel5(Red1,eps1);
CG1 = guidedChannel5(Green1,eps1);
CB1 = guidedChannel5(Blue1,eps1);
CF1 = cat(3,uint8(CR1),uint8(CG1),uint8(CB1));
imshow(uint8(CF1)); figure

CR2 = guidedChannel5(CR1,eps1);
CG2 = guidedChannel5(CG1,eps1);
CB2 = guidedChannel5(CB1,eps1);
CF2 = cat(3,uint8(CR2),uint8(CG2),uint8(CB2));
imshow(uint8(CF2)); figure

CR3 = guidedChannel5(CR2,eps1);
CG3 = guidedChannel5(CG2,eps1);
CB3 = guidedChannel5(CB2,eps1);
CF3 = cat(3,uint8(CR3),uint8(CG3),uint8(CB3));
imshow(uint8(CF3)); figure

CR4 = guidedChannel5(CR3,eps1);
CG4 = guidedChannel5(CG3,eps1);
CB4 = guidedChannel5(CB3,eps1);
CF4 = cat(3,uint8(CR4),uint8(CG4),uint8(CB4));
imshow(uint8(CF4)); figure

CR5 = guidedChannel5(CR4,eps1);
CG5 = guidedChannel5(CG4,eps1);
CB5 = guidedChannel5(CB4,eps1);
CF5 = cat(3,uint8(CR5),uint8(CG5),uint8(CB5));
imshow(uint8(CF5)); figure

CR6 = guidedChannel5(CR5,eps1);
CG6 = guidedChannel5(CG5,eps1);
CB6 = guidedChannel5(CB5,eps1);
CF6 = cat(3,uint8(CR6),uint8(CG6),uint8(CB6));
imshow(uint8(CF6)); title('Cartoon Image');
A = PSNR(Red1,CR6,row,col);

%% Writing to raw file
out = I_f1;
new_row = size(out,1);new_col = size(out,2);
final = uint8(zeros(new_col,new_row,3));
for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            final(r,c,k)=out(c,r,k);
        end
    end
end
fid = fopen('Problem3b.raw','w+');
finalImage = fwrite(fid,final,'uint8');

%% Raw image for cartoon mate

out_2 = CF6;
new_row = size(out_2,1);new_col = size(out_2,2);
final = uint8(zeros(new_col,new_row,3));
for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            final(r,c,k)=out_2(c,r,k);
        end
    end
end
fid1 = fopen('Problem3b_cartoon.raw','w+');
finalImage = fwrite(fid1,final,'uint8');