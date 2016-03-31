%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
% Oil Painting 
row= 275; col = 380;BytesPerPixel = 3;
fileID1 = fopen('barn.raw');
[out,Red2,Green2,Blue2] = readImage(fileID1, row,col, BytesPerPixel);
imshow(out)
figure

%Histogram of Channels
red_hist= myHist(row, col, Red2); 
cumu_r= cumuHist(red_hist,row,col);

green_hist= myHist(row, col, Green2); 
cumu_g= cumuHist(red_hist,row,col);

blue_hist= myHist(row, col, Blue2); 
cumu_b= cumuHist(blue_hist,row,col);

totalN = row*col;
a= floor(totalN/8)+1;

xR = myBins8(cumu_r,a);
xG = myBins8(cumu_g,a);
xB = myBins8(cumu_b,a);

avg_xR_1=(xR(1)+0)/2;
avg_xR_2=(xR(1)+xR(2))/2;
avg_xR_3=(xR(2)+xR(3))/2;
avg_xR_4=(xR(3)+xR(4))/2;
avg_xR_5=(xR(4)+xR(5))/2;
avg_xR_6=(xR(5)+xR(6))/2;
avg_xR_7=(xR(6)+xR(7))/2;
avg_xR_8=(xR(7)+xR(8))/2;


avg_xG_1=(xR(1)+0)/2;
avg_xG_2=(xR(1)+xR(2))/2;
avg_xG_3=(xR(2)+xR(3))/2;
avg_xG_4=(xR(3)+xR(4))/2;
avg_xG_5=(xR(4)+xR(5))/2;
avg_xG_6=(xR(5)+xR(6))/2;
avg_xG_7=(xR(6)+xR(7))/2;
avg_xG_8=(xR(7)+xR(8))/2;
% 
avg_xB_1=(xR(1)+0)/2;
avg_xB_2=(xR(1)+xR(2))/2;
avg_xB_3=(xR(2)+xR(3))/2;
avg_xB_4=(xR(3)+xR(4))/2;
avg_xB_5=(xR(4)+xR(5))/2;
avg_xB_6=(xR(5)+xR(6))/2;
avg_xB_7=(xR(6)+xR(7))/2;
avg_xB_8=(xR(7)+xR(8))/2;
% 
qRed = quantizedChannel8(Red2,xR,avg_xR_1,avg_xR_2,avg_xR_3,avg_xR_4,avg_xR_5,avg_xR_6,avg_xR_7,avg_xR_8);
qGreen = quantizedChannel8(Green2,xG,avg_xG_1,avg_xG_2,avg_xG_3,avg_xG_4,avg_xG_5,avg_xG_6,avg_xG_7,avg_xG_8);
qBlue = quantizedChannel8(Blue2,xB,avg_xB_1,avg_xB_2,avg_xB_3,avg_xB_4,avg_xB_5,avg_xB_6,avg_xB_7,avg_xB_8);

I1 = cat(3, uint8(qRed), uint8(qGreen), uint8(qBlue));
imshow(I1)
figure


I1_big=uint8(zeros(row+2,col+2,3));

for k=1:3
    for r=1:row
        for c=1:col
            I1_big(r+1,c+1,k)=I1(r,c,k);
        end
    end
end

for k=1:3
    for r=1:row
        I1_big(r+1,1,k)=I1(r,1,k);
        I1_big(r+1,382,k)=I1(r,380,k);
    end
end

for k=1:3
    for c=1:col
        I1_big(1,c+1,k)=I1(1,c,k);
        I1_big(row+2,c+1,k)=I1(row,c,k);
    end
end
for k=1:3
    I1_big(1,1,k)=I1_big(1,2,k);
    I1_big(row+2,1,k)=I1_big(row+2,2,k);
    I1_big(1,col+2,k)=I1_big(2,col+2,k);
    I1_big(row+2,col+2,k)=I1_big(row+1,col+1,k);
end

for k=1:3
    for r= 1:row
        for c=1:col
            window=zeros(1,9,k); 
            count=1;
            for i=1:3
                for j=1:3
                    window(1,count,k)=I1_big(r+i-1,c+j-1,k);
                    count=count+1;
                end
            end
          v1=maxNeighbor(window(:,:,k));
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
fid = fopen('Problem2b_barn3_512.raw','w+');
finalImage = fwrite(fid,final,'uint8');