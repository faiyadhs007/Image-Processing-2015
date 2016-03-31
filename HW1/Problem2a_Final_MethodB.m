%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
 
row= 512; col = 512;BytesPerPixel = 3;
fileID1 = fopen('jet.raw');
[out,Red2,Green2,Blue2] = readImage(fileID1, row,col, BytesPerPixel);
imshow(out); figure

N = (row*col)/256;
%% Red Channel
r_eqb = double(Red2); % eqb stands for equalized with bucket-filling
r_hist = myHist(row,col,Red2); %stem(1:256,r_hist); title('Histogram for Red Channel');figure
r_cumu = cumuHist(r_hist,row,col); %stem(1:256,r_cumu);figure
r_eqb = eqHist(r_eqb,r_cumu, row,col);
rh=myHist(row,col,r_eqb); stem(1:256,rh); title('Histogram for Red Channel(Method B)');figure
cumu_rh = cumuHist(rh,row,col); %stem(1:256,cumu_rh); title('Cumulative distribution for Red Channel');figure 

%% Green Channel
g_eqb = double(Green2); % eq stands for equalized with transfer function
g_hist = myHist(row,col,Green2); %stem(1:256,g_hist); title('Histogram for Green Channel');figure
g_cumu = cumuHist(g_hist,row,col); %stem(1:256,r_cumu);figure
g_eqb = eqHist(g_eqb,g_cumu, row,col);
gh=myHist(row,col,g_eqb); stem(1:256,gh); title('Histogram for Green Channel');figure
cumu_gh = cumuHist(gh,row,col); %stem(1:256,cumu_gh); title('Cumulative distribution for Green Channel');figure

%% Blue Channel
b_eqb = double(Blue2); % eq stands for equalized with transfer function
b_hist = myHist(row,col,Blue2); %stem(1:256,r_cumu);title('Histogram for Blue Channel');figure
b_cumu = cumuHist(b_hist,row,col); %stem(1:256,r_cumu);figure
b_eqb = eqHist(b_eqb,b_cumu, row,col);
bh=myHist(row,col,b_eqb); stem(1:256,bh); title('Histogram for Blue Channel(Method B)');figure
cumu_bh = cumuHist(bh,row,col); %stem(1:256,cumu_bh); title('Cumulative distribution for Blue Channel'); 
I_eqb = cat(3,uint8(r_eqb),uint8(g_eqb),uint8(b_eqb));
imshow(I_eqb)

%% Writing to raw file
new_row = size(I_eqb,1);new_col = size(I_eqb,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_row
        for c = 1:new_col
            final(r,c,k)=I_eqb(c,r,k);
        end
    end
end
fid = fopen('solution2a_methodB.raw','w+');
finalImage = fwrite(fid,final,'uint8');