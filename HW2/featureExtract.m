function  Img_energy = featureExtract(a)
% This function extracts the feature from a given image using Law's filters
%% Load the images
row = 128; col = 128;BytesPerPixel =1; 
fileID = fopen(a);
I = fread(fileID, row*col*BytesPerPixel,'uint8'); 
% Converting the image into rows and columns
I1 = zeros(row,col);
i =1;
for r=1:row
    for c=1:col
        I1(r,c)=I(i,1);
        i=i+1;
    end 
end
%% Creating Filter banks
L = [1 4 6 4 1]; E= [-1 -2 0 2 1]; S = [-1 0 2 0 -1];
W = [-1 2 0 -2 1]; R = [1 -4 6 -4 1];
filterbank=[L;E;S;W;R];

count=0;
for i=1:5
    for j=1:5
count=count+1;
filtercomb(count*5-4:count*5,1:5)=transpose(filterbank(j,1:5))*filterbank(i,1:5);
    end
end

%% Creating zero-mean image

I2= zeromean(I1,5);

%% Creating 25 Law's filters
for i=1:25
    Img_lawfilter(1:row,1:col,i) = lawfilter(I2,5,filtercomb(i*5-4:i*5,1:5));
end

%% Calculating the pixel energy content
for i=1:25
    Img_energy(1,i) = energy(Img_lawfilter(1:row,1:col,i));
end
end

