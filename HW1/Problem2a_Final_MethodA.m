%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;

%% Reading the file
row= 512; col = 512;BytesPerPixel = 3;
fileID1 = fopen('jet.raw');
[out,Red2,Green2,Blue2] = readImage(fileID1, row,col, BytesPerPixel);
imshow(out); figure

%% Equalization for Red channel
r_eqt = uint8(zeros(512,512)); % eq stands for equalized with transfer function
r_hist = myHist(row,col,Red2); % stem(1:256,r_hist); 
r_cumu = cumuHist(r_hist,row,col); %stem(1:256,r_cumu);figure
r_cdf = cdfHist(r_cumu,row,col); %stem(1:256,r_cdf); figure

max_intensity = 255; out_r = zeros(256,1);
for i=1:256
    out_r(i) = double(r_cdf(i)*max_intensity);
end

for r=1:row
    for c=1:512
        r_eqt(r,c)= out_r(Red2(r,c)-1);
    end
end
r_eqt = uint8(r_eqt); 
rh=myHist(row,col,r_eqt);% stem(1:256,rh); title('Histogram of red channel (transfer)'); xlabel('Intensity');ylabel('Number of pixels');figure
rh_cumu = cumuHist(rh,row,col); %plot(1:256,rh_cumu); figure
rh_cdf = cdfHist(rh_cumu,row,col); plot(1:256,rh_cdf); title('Transfer Function of red channel');figure

%% Equalization for Green channel
g_eqt = uint8(zeros(512,512)); % eq stands for equalized with transfer function
g_hist = myHist(row,col,Green2); %stem(1:256,g_hist); figure
g_cumu = cumuHist(g_hist,row,col); % stem(1:256,g_cumu);figure
g_cdf = cdfHist(g_cumu,row,col); %stem(1:256,g_cdf); figure

out_g = zeros(256,1);
for i=1:256
    out_g(i) = double(g_cdf(i)*max_intensity);
end

for r=1:row
    for c=1:512
        g_eqt(r,c)= out_g(Green2(r,c)+1);
    end
end
g_eqt = uint8(g_eqt);
gh=myHist(row,col,g_eqt); %stem(1:256,gh); title('Histogram of green channel(transfer)'); xlabel('Intensity');ylabel('Number of pixels');figure
gh_cumu = cumuHist(gh,row,col); %plot(1:256,rh_cumu); figure
gh_cdf = cdfHist(gh_cumu,row,col);plot(1:256,gh_cdf); title('Transfer Function of green channel');figure

%% Equalization for Blue channel
b_eqt = uint8(zeros(512,512)); % eq stands for equalized with transfer function
b_hist = myHist(row,col,Blue2); % stem(1:256,b_hist); 
b_cumu = cumuHist(b_hist,row,col); %stem(1:256,b_cumu);figure
b_cdf = cdfHist(b_cumu,row,col); %stem(1:256,b_cdf); figure

out_b = zeros(256,1);
for i=1:256
    out_b(i) = double(b_cdf(i)*max_intensity);
end

for r=1:row
    for c=1:512
        b_eqt(r,c)= out_b(Blue2(r,c)+1);
    end
end
b_eqt = uint8(b_eqt);
bh=myHist(row,col,b_eqt); % stem(1:256,bh); title('Histogram of blue channel(transfer)'); xlabel('Intensity');ylabel('Number of pixels');figure
bh_cumu = cumuHist(bh,row,col); %plot(1:256,rh_cumu); figure
bh_cdf = cdfHist(bh_cumu,row,col); plot(1:256,bh_cdf); title('Transfer Function of blue channel');figure

%% Final Output
I_eq = cat(3,r_eqt,g_eqt,b_eqt);
imshow(I_eq); 

%% Writing to raw output
new_row = size(I_eq,1);new_col = size(I_eq,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_row
        for c = 1:new_col
            final(r,c,k)=I_eq(c,r,k);
        end
    end
end
fid = fopen('solution2a_methodA.raw','w+');
finalImage = fwrite(fid,final,'uint8');
