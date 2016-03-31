%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
%% Reading the image and placing necessary parameters
close all; clc;
row = 512; col =512; BytesPerPixel = 3;
fileID = fopen('kate.raw');
[Original_img,Red2,Green2,Blue2] = readImage(fileID, row,col, BytesPerPixel);
% imshow(Original_img); %title('Original Image')
x0 = .5 * (row-1); y0 = .5 * (col-1); % Center of the image
x = input('swirling factor: '); % 500 for Leena.raw; % 450 for Kate image

%% Applying rotational transformation 
for k=1:3
        for c=1:col
            A(:,c,k) = Original_img(:,col-c+1,k); % Horizontal flip
        end
end        

% A  = imagerotate(A,2*pi);                         % Rotation
    
%% Applying swirling transformation
final_img = zeros(row,col,3);

    for r =1:row
        for c =1:col
            dx = r - x0;
            dy = c - y0;
            radius  = sqrt((dx*dx) + (dy*dy));
            angle = radius * pi/x;
            tx = floor((dx*cos(angle)) + (dy*sin(angle)) + x0);
            ty = floor((dx*sin(angle)) - (dy*cos(angle)) + y0);
            
            if (tx >= 1 &&  tx <= row && ty >= 1 && ty <= col)
                final_img(r,c,1) = A(tx,ty,1);
                final_img(r,c,2) = A(tx,ty,2);
                final_img(r,c,3) = A(tx,ty,3);
            end
        end
    end

 %% Displaying the final image
 figure();
imshow(uint8(final_img)); %title('Swirled Image');
%% Writing to raw file
final = uint8(final_img);
new_row = size(final,1);new_col = size(final,2);
kate_swirled = uint8(zeros(new_col,new_row,3));
for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            kate_swirled(r,c,k)=final(c,r,k);
        end
    end
end

fid1 = fopen('kate_swirled.raw','w+');
finalImage = fwrite(fid1,kate_swirled,'uint8');
