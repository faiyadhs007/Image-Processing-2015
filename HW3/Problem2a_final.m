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

%% Part a: Dithering matrix 
%% Applying I8 to the image
I_dithered = I1;
I2 = [1  2; 3 0];
I4 = [(4.*I2)+1, (4.*I2)+2;(4.*I2)+3,(4.*I2)+0];
I8 = [(4.*I4)+1, (4.*I4)+2;(4.*I4)+3,(4.*I4)+0];
I16 = [(4.*I8)+1, (4.*I8)+2;(4.*I8)+3,(4.*I8)+0];
I32 = [(4.*I16)+1, (4.*I16)+2;(4.*I16)+3,(4.*I16)+0];

x=255;

N = 8;
T = (I8 + .5)* 255 / (N^2);

for r = 0:row-1
    for c=0:col-1
        if I_dithered(r+1,c+1) > T(mod(r,N)+1,mod(c,N)+1)
            I_dithered(r+1,c+1) = x;
        else I_dithered(r+1,c+1) = 0;
        end
    end
end

imshow(uint8(I1));% title('Original image');
figure;imshow(I_dithered);% The final dithered image 
title('I8 applied on Mandrill.raw');
% I2= uint8(I1);

%% Applying I2 to the image
I_dithered2 = I1;
N2 = 2;
T2 = (I2 + .5)* 255 / (N2^2);

for r = 0:row-1
    for c=0:col-1
        if I_dithered2(r+1,c+1) > T2(mod(r,N2)+1,mod(c,N2)+1)
            I_dithered2(r+1,c+1) = x;
        else I_dithered2(r+1,c+1) = 0;
        end
    end
end

figure;imshow(I_dithered2);% The final dithered image 
title('I2 applied on Mandrill.raw');

%% Applying I4 to the image
I_dithered3 = I1;
N3 = 4;
T3 = (I4 + .5)* 255 / (N3^2);

for r = 0:row-1
    for c=0:col-1
        if I_dithered3(r+1,c+1) > T3(mod(r,N3)+1,mod(c,N3)+1)
            I_dithered3(r+1,c+1) = x;
        else I_dithered3(r+1,c+1) = 0;
        end
    end
end

figure;imshow(I_dithered3);% The final dithered image 
title('I4 applied on Mandrill.raw');

%% Applying I16 to the image
I_dithered4 = I1;
N4 = 16;
T4 = (I16 + .5)* 255 / (N4^2);

for r = 0:row-1
    for c=0:col-1
        if I_dithered4(r+1,c+1) > T4(mod(r,N4)+1,mod(c,N4)+1)
            I_dithered4(r+1,c+1) = x;
        else I_dithered4(r+1,c+1) = 0;
        end
    end
end

figure;imshow(I_dithered4);% The final dithered image 
title('I16 applied on Mandrill.raw');

%% Part b: Four intensity value screen display
I_dithered5 = uint8(I1);
error =0; 
threshold_1 =0;threshold_2 =85;
threshold_3 =170;threshold_4 =255;

thresh_avg1 = (threshold_1+threshold_2)/2;
thresh_avg2 = (threshold_2+threshold_3)/2;
thresh_avg3 = (threshold_3+threshold_4)/2;

% 3 cases to be implemented 
for r=1:row
    for c =1:col
       Id = I_dithered5(r,c)+error;
       % First case
      if ((Id > threshold_1) && (Id < threshold_2))
        if Id < thresh_avg1
            error =Id - threshold_1;
            I_dithered5(r,c) = threshold_1;
        elseif Id > thresh_avg1
                error = Id - threshold_2;
                I_dithered5(r,c) = threshold_2; 
        end
      
      % Second case
      elseif ((Id > threshold_2) && (Id < threshold_3))
        if Id < thresh_avg2
            error = Id - threshold_2;
            I_dithered5(r,c) = threshold_2;
        elseif Id > thresh_avg2
                error = Id - threshold_3;
                I_dithered5(r,c) = threshold_3;
        end
      
      % Third case
      elseif ((Id > threshold_3) && (Id < threshold_4))
        if Id < thresh_avg3
            error = Id - threshold_3;
            I_dithered5(r,c) = threshold_3;
        elseif Id > thresh_avg3
                error = Id - threshold_4;
                I_dithered5(r,c) = threshold_4;
               
        end
      end
    end
end     
figure;imshow(I_dithered5);title('Dithering with four intensity values');


%% Writing to raw image
new_row = 512;new_col = 512;
Mandrill_I8= (zeros(new_col,new_row));

for r = 1:new_row
    for c = 1:new_col
        Mandrill_I8(c,r)=I_dithered(r,c);
        Mandrill_I2(c,r)=I_dithered2(r,c);
        Mandrill_four(c,r)= I_dithered5(r,c);
    end
end

fid1 = fopen('Mandrill_I8.raw','w+'); 
fid2 = fopen('Mandrill_I2.raw','w+'); 
fid3 = fopen('Mandrill_four.raw','w+'); 
finalImage1 = fwrite(fid1,Mandrill_I8,'uint8');
finalImage2 = fwrite(fid2,Mandrill_I2,'uint8');
finalImage3 = fwrite(fid3,Mandrill_four,'uint8');

%% Applying I32 to the image

T32 = (I16 + .5)* 255 / (N^2);
I_dithered32 = I1;

for r = 0:row-1
    for c=0:col-1
        if I_dithered32(r+1,c+1) > T32(mod(r,N)+1,mod(c,N)+1)
            I_dithered32(r+1,c+1) = x;
        else I_dithered32(r+1,c+1) = 0;
        end
    end
end

figure;imshow(I_dithered32);% The final dithered image 
title('I32 applied on Mandrill.raw');