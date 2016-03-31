function output_image = Problem2b_FSED()
%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
%% Reading the file
row= 512; col = 512;BytesPerPixel = 1;
fileID = fopen('mandrill.raw');
I = fread(fileID, row*col*BytesPerPixel,'uint8'); 

%% Reading the image
I1 = zeros(row,col);
i =1;
for r=1:row
    for c=1:col
        I1(r,c)=I(i,1);
        i=i+1;
    end 
end
I2 = uint8(I1);
%% Extension
FSED_extended = extension(I2,3);
JJNED_extended = extension(I2,5);
SED_extended = extension(I2,5);
error =0;
%% Floyd-Steinberg's error diffusion
for r=1:row
    for c =1:col
       Id = FSED_extended(r+1,c+1);
      if Id >= 128
        FSED_extended(r+1,c+1) = 255; 
        error = Id -255;
        FSED_extended(r+1,c+2) = FSED_extended(r+1,c+2) + ((7/16)*error);
        FSED_extended(r+2,c+0) = FSED_extended(r+2,c) + ((3/16)*error);
        FSED_extended(r+2,c+1) = FSED_extended(r+2,c+1) + ((5/16)*error);
        FSED_extended(r+2,c+2) = FSED_extended(r+2,c+2) + ((1/16)*error);
        continue;
      elseif Id < 128
        FSED_extended(r+1,c+1) = 0; 
        error = Id -0;
        FSED_extended(r+1,c+2) = FSED_extended(r+1,c+2) + ((7/16)*error);
        FSED_extended(r+2,c+0) = FSED_extended(r+2,c) + ((3/16)*error);
        FSED_extended(r+2,c+1) = FSED_extended(r+2,c+1) + ((5/16)*error);
        FSED_extended(r+2,c+2) = FSED_extended(r+2,c+2) + ((1/16)*error);

      end
    end
end
imshow(uint8(FSED_extended(2:513,2:513,:))); 
title('Floyd-Steinbergs error diffusion');

Final_image = uint8(FSED_extended(2:513,2:513,:)); 

%% Writing to raw image
new_row = 512;new_col = 512;
Mandrill_FSED= (zeros(new_col,new_row));

for r = 1:new_row
    for c = 1:new_col
        Mandrill_FSED(c,r)=Final_image(r,c);
    end
end

fid1 = fopen('Mandrill_FSED.raw','w+'); 
finalImage1 = fwrite(fid1,Mandrill_FSED,'uint8');
end
