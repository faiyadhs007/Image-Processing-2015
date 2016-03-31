%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
%% Oil Painting 
row= 247; col = 580;BytesPerPixel = 3;
fileID1 = fopen('coliseum.raw');
[out,Red2,Green2,Blue2] = readImage(fileID1, row,col, BytesPerPixel);
imshow(out)
figure

%% Histogram of Channels
red_hist= myHist(row, col, Red2); 
cumu_r= cumuHist(red_hist,row,col);

green_hist= myHist(row, col, Green2); 
cumu_g= cumuHist(red_hist,row,col);

blue_hist= myHist(row, col, Blue2); 
cumu_b= cumuHist(blue_hist,row,col);

totalN = row*col;
a= totalN/4;

xR = myBins(cumu_r,a);
xG = myBins(cumu_g,a);
xB = myBins(cumu_b,a);

avg_xR_1=(xR(1)+0)/2;
avg_xR_2=(xR(1)+xR(2))/2;
avg_xR_3=(xR(2)+xR(3))/2;
avg_xR_4=(xR(3)+xR(4))/2;

avg_xG_1=(xG(1)+0)/2;
avg_xG_2=(xG(1)+xG(2))/2;
avg_xG_3=(xG(2)+xG(3))/2;
avg_xG_4=(xG(3)+xG(4))/2;

avg_xB_1=(xB(1)+0)/2;
avg_xB_2=(xB(1)+xB(2))/2;
avg_xB_3=(xB(2)+xB(3))/2;
avg_xB_4=(xB(3)+xB(4))/2;

qRed = quantizedChannel(Red2,xR,avg_xR_1,avg_xR_2,avg_xR_3,avg_xR_4);
qGreen = quantizedChannel(Green2,xG,avg_xG_1,avg_xG_2,avg_xG_3,avg_xG_4);
qBlue = quantizedChannel(Blue2,xB,avg_xB_1,avg_xB_2,avg_xB_3,avg_xB_4);

I1 = cat(3, uint8(qRed), uint8(qGreen), uint8(qBlue));
imshow(I1)
figure

I1_big=uint8(zeros(row+4,col+4,3));

for k=1:3
    for r=1:row
        for c=1:col
            I1_big(r+2,c+2,k)=I1(r,c,k);
        end
    end
end

for i=1:size(I1)
     I1_big(1:2,i) = I1_big(3,i);
 end
 
 for i=1:size(I1)
     I1_big(row+1:row+2,i) = I1_big(row,i);
 end 

 for i=1:size(I1)
     I1_big(i,1:2) = I1_big(i,3);
 end
 
 for i=1:size(I1)
     I1_big(i,col+1:col+2) = I1_big(i,col);
 end

 %% Filter
for k=1:3
    for r= 1:size(I1_big,1)-4
        for c=1:size(I1_big,2)-4
            window=zeros(1,25,k); 
            count=1;
            for i=1:5
                for j=1:5
                    window(1,count,k)=I1_big(r+i-1,c+j-1,k);
                    count=count+1;
                end
            end
          v1=maxNeighbor5(window(:,:,k));
          I1_big(r,c,k)=v1;
    end
    end
end
I2 = I1_big(1:row,1:col,1:3);
imshow(I2);

%% Writing raw image
new_row = size(I2,1);new_col = size(I2,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            final(r,c,k)=I2(c,r,k);
        end
    end
end
fid = fopen('Problem2b_col5.raw','w+');
finalImage = fwrite(fid,final,'uint8');

%% Writing raw file
new_row = size(I2,1);new_col = size(I2,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            final(r,c,k)=I2(c,r,k);
        end
    end
end
fid = fopen('Problem2b_col3.raw','w+');
finalImage = fwrite(fid,final,'uint8');