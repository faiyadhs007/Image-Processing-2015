function [ imgf,Red2,Green2,Blue2 ] = readImage(fileID,row,col,BytesPerPixel)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
img = fread(fileID, row*col*BytesPerPixel,'uint8');

Red1 = zeros(row,col);
i =1;
for r=1:row
    for c=1:col
        Red1(r,c)=img(i,1);
        i=i+3;
    end 
end
Red2 = uint8(Red1);

Green1 = zeros(row,col);
i =2;
for r=1:row
    for c=1:col
        Green1(r,c)=img(i,1);
        i=i+3;
    end 
end
Green2 = uint8(Green1); 

Blue1 = zeros(row,col);
i =3;
for r=1:row
    for c=1:col
        Blue1(r,c)=img(i,1);
        i=i+3;
    end 
end
Blue2 = uint8(Blue1); 

% imgf = cat(3,Red2,Green2,Blue2);
imgf=zeros(row,col,BytesPerPixel);
imgf=uint8(imgf);
for j=1:3
    if j==1
        imgf(:,:,1)=Red2(:,:);
    end
    if j==2
        imgf(:,:,2)=Green2(:,:);
    end
    if j==3
        imgf(:,:,3)=Blue2(:,:);
    end
end
end

