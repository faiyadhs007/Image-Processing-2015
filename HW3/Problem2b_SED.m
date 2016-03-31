function output_image = Problem2b_SED()
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
%FSED_extended = extension(I2,3);
%JJNED_extended = extension(I2,5);
SED_extended = extension(I2,5);
error =0;

%% JJN Error Diffusion
for r=1:row
    for c =1:col
       Id = SED_extended(r+2,c+2);
      if Id >= 128
        SED_extended(r+2,c+2) = 255; 
        error = Id -255;
        SED_extended(r+2,c+3) = SED_extended(r+2,c+3) + ((8/42)*error);
        SED_extended(r+2,c+4) = SED_extended(r+2,c+4) + ((4/42)*error);
        SED_extended(r+3,c+0) = SED_extended(r+3,c+0) + ((2/42)*error);
        SED_extended(r+3,c+1) = SED_extended(r+3,c+1) + ((4/42)*error);
        SED_extended(r+3,c+2) = SED_extended(r+3,c+2) + ((8/42)*error);
        SED_extended(r+3,c+3) = SED_extended(r+3,c+3) + ((4/42)*error);
        SED_extended(r+3,c+4) = SED_extended(r+3,c+4) + ((2/42)*error);
        SED_extended(r+4,c+0) = SED_extended(r+4,c+0) + ((1/42)*error);
        SED_extended(r+4,c+1) = SED_extended(r+4,c+1) + ((2/42)*error);
        SED_extended(r+4,c+2) = SED_extended(r+4,c+2) + ((4/42)*error);
        SED_extended(r+4,c+3) = SED_extended(r+4,c+3) + ((2/42)*error);
        SED_extended(r+4,c+4) = SED_extended(r+4,c+4) + ((1/42)*error);
      elseif Id < 128
        SED_extended(r+2,c+2) = 0; 
        error = Id -0;
        SED_extended(r+2,c+3) = SED_extended(r+2,c+3) + ((8/42)*error);
        SED_extended(r+2,c+4) = SED_extended(r+2,c+4) + ((4/42)*error);
        SED_extended(r+3,c+0) = SED_extended(r+3,c+0) + ((2/42)*error);
        SED_extended(r+3,c+1) = SED_extended(r+3,c+1) + ((4/42)*error);
        SED_extended(r+3,c+2) = SED_extended(r+3,c+2) + ((8/42)*error);
        SED_extended(r+3,c+3) = SED_extended(r+3,c+3) + ((4/42)*error);
        SED_extended(r+3,c+4) = SED_extended(r+3,c+4) + ((2/42)*error);
        SED_extended(r+4,c+0) = SED_extended(r+4,c+0) + ((1/42)*error);
        SED_extended(r+4,c+1) = SED_extended(r+4,c+1) + ((2/42)*error);
        SED_extended(r+4,c+2) = SED_extended(r+4,c+2) + ((4/42)*error);
        SED_extended(r+4,c+3) = SED_extended(r+4,c+3) + ((2/42)*error);
        SED_extended(r+4,c+4) = SED_extended(r+4,c+4) + ((1/42)*error);
      end
    end
end
imshow(uint8(SED_extended(3:514,3:514,:))); title('Stucki error diffusion');

Final_image = uint8(SED_extended(3:514,3:514,:)); 

%% Writing to raw image
new_row = 512;new_col = 512;

Mandrill_SED = (zeros(new_col,new_row));

for r = 1:new_row
    for c = 1:new_col
        Mandrill_SED(c,r)=Final_image(r,c);
    end
end

fid1 = fopen('Mandrill_SED.raw','w+'); 
finalImage1 = fwrite(fid1,Mandrill_SED,'uint8');
end