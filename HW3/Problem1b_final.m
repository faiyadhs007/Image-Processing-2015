%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
%% Read all the images
row = 200; col =200; BytesPerPixel = 3;
fileID1 = fopen('baby.raw');
[img1,Red1,Green1,Blue1] = readImage(fileID1, row,col, BytesPerPixel);

fileID2 = fopen('baby_cat.raw');
[img2,Red2,Green2,Blue2] = readImage(fileID2, row,col, BytesPerPixel);

fileID3 = fopen('baby_dog.raw');
[img3,Red3,Green3,Blue3] = readImage(fileID3, row,col, BytesPerPixel);
img3 = imrotate(img3,90);

fileID4 = fopen('baby_panda.raw');
[img4,Red4,Green4,Blue4] = readImage(fileID4, row,col, BytesPerPixel);

fileID5 = fopen('baby_bear.raw');
[img5,Red5,Green5,Blue5] = readImage(fileID5, row,col, BytesPerPixel);


%% Necessary variables
Size = 200; cameraLoc= [5 5 5];
pixelDensity = input('Enter the pixel density [100,200,400]: '); 
sizeCapture= input('Enter your output image size[200,400]: ');

%% Getting all necessary calculations
% Extrinsic Matrix - R
Xc = [-1/sqrt(2); 1/sqrt(2); 0];            % camera direction for x 
Yc = [1/sqrt(6); 1/sqrt(6); -2/sqrt(6)];    % camera direction for y
Zc = [-1/sqrt(3); -1/sqrt(3); -1/sqrt(3)];  % camera direction for z
Rt = [Xc', -cameraLoc*Xc; Yc', -cameraLoc*Yc; Zc', -cameraLoc*Zc]; 

% Intrinsic Matrix- K
f = sqrt(3); cx = 0; cy = 0;
K= [f 0 cx; 0  f cy; 0 0 1];

% Transformation Matrix- T
T = K * Rt;

% Rotation Matrix - rM
angle = 0;
rM = [cos(angle),-sin(angle),0,0; ...
    sin(angle), cos(angle), 0, 0;...
    0, 0, 1, 0;...
    0, 0, 0, 1]; 

%% Capturing 3D scene (Forward Mapping)
final = zeros(sizeCapture,sizeCapture,3);
temp = zeros(sizeCapture,sizeCapture);
depth = zeros(sizeCapture,sizeCapture);

for i=1: sizeCapture
    for j=1:sizeCapture
    depth(i,j) = -1;
    end
end

% First image
z =1; 
for r = 1:200
    for c = 1:200
       x = 2*r/Size-1;
       y = 2*c/Size-1;
       inPos_temp = [x;y;z;1];
       inputPosition = rM * inPos_temp;
       [outPosition, out] = getPosOfCapture(pixelDensity, sizeCapture, T, inputPosition);
       zc = out(3);
           m = outPosition(1); n = outPosition(2);
           collect(r,c,1) = [m];
           collect(r,c,2) = [n];
       if outPosition(1) >= 0 && outPosition(1) <= sizeCapture && outPosition(2) >= 0 && outPosition(2) <= sizeCapture
           if temp(outPosition(1)+1,outPosition(2)+1) == 0
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               temp(outPosition(1)+1,outPosition(2)+1) = 1;
               
           else if zc < depth(outPosition(1)+1,outPosition(2)+1)
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               end
            end
           end
       end
end

% Second image
x =1; 
for r = 1:200
    for c = 1:200
       y = 2*r/Size-1;
       z = 1-2*c/Size;
       inPos_temp = [x;y;z;1];
       inputPosition = rM * inPos_temp;
       [outPosition, out] = getPosOfCapture(pixelDensity, sizeCapture, T, inputPosition);
       zc = out(3);
       
       if outPosition(1) >= 0 && outPosition(1) <= sizeCapture && outPosition(2) >= 0 && outPosition(2) <= sizeCapture
           if temp(outPosition(1)+1,outPosition(2)+1) == 0
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               temp(outPosition(1)+1,outPosition(2)+1) = 1;
           else if zc < depth(outPosition(1)+1,outPosition(2)+1)
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               end
           end
           end
       end
end

% Third Image
y =1; 
for r = 1:200
    for c = 1:200
       x = 1-2*r/Size;
       z = 1-2*c/Size;
       inPos_temp = [x;y;z;1];
       inputPosition = rM * inPos_temp;
       [outPosition, out] = getPosOfCapture(pixelDensity, sizeCapture, T, inputPosition);
       zc = out(3);
       
       if outPosition(1) >= 0 && outPosition(1) <= sizeCapture && outPosition(2) >= 0 && outPosition(2) <= sizeCapture
           if temp(outPosition(1)+1,outPosition(2)+1) == 0
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               temp(outPosition(1)+1,outPosition(2)+1) = 1;
           else if zc < depth(outPosition(1)+1,outPosition(2)+1)
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               end
           end
               
           end
       end
end

% Fourth Image
x =-1; 
for r = 1:200
    for c = 1:200
       y = 1- 2*r/Size;
       z = 1-2*c/Size;
       inPos_temp = [x;y;z;1];
       inputPosition = rM * inPos_temp;
       [outPosition, out] = getPosOfCapture(pixelDensity, sizeCapture, T, inputPosition);
       zc = out(3);
       
       if outPosition(1) >= 0 && outPosition(1) <= sizeCapture && outPosition(2) >= 0 && outPosition(2) <= sizeCapture
           if temp(outPosition(1)+1,outPosition(2)+1) == 0
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               temp(outPosition(1)+1,outPosition(2)+1) = 1;
           else if zc < depth(outPosition(1)+1,outPosition(2)+1)
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               end
           end
           end
       end
end

% Fifth Image
y =-1; 
for r = 1:200
    for c = 1:200
       z = 1- 2*r/Size;
       x = 2*c/Size-1;
       inPos_temp = [x;y;z;1];
       inputPosition = rM * inPos_temp;
       [outPosition, out] = getPosOfCapture(pixelDensity, sizeCapture, T, inputPosition);
       zc = out(3);
       
       if outPosition(1) >= 0 && outPosition(1) <= sizeCapture && outPosition(2) >= 0 && outPosition(2) <= sizeCapture
           if temp(outPosition(1)+1,outPosition(2)+1) == 0
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               temp(outPosition(1)+1,outPosition(2)+1) = 1;
           else if zc < depth(outPosition(1)+1,outPosition(2)+1)
               [R,G,B] = getRGBfromlocation(img1,img2,img3,img4,img5, 200, x,y,z);
               final(outPosition(1)+1,outPosition(2)+1,1)=R;
               final(outPosition(1)+1,outPosition(2)+1,2)=G;
               final(outPosition(1)+1,outPosition(2)+1,3)=B;
               depth(outPosition(1)+1,outPosition(2)+1) = zc;
               end
           end
           end
       end
end

%% Display the final output for Forward Mapping
imshow(uint8(final));

%% Reverse Mapping
% R_n = [Rt; 0 0 0 1];
% R_inv = inv(R_n);
% while (1)
%     i = input('Enter your i value: ');
%     j = input('Enter your j value: ');
%     offset = sizeCapture/2;
%     x = depth(i+1,j+1);
%     Pos_in = [1*(j-offset)/pixelDensity/f*x; 1*(i-offset)/pixelDensity/f*x; x;1];
%     Pos_out = R_inv * Pos_in;
%     fprintf('(X,Y,Z) : %.1f,%.1f,%.1f\n',Pos_out(1),Pos_out(2),Pos_out(3));
% end

%% Writing to raw file
final = uint8(final);
new_row = size(final,1);new_col = size(final,2);
captured = uint8(zeros(new_col,new_row,3));
for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            captured(r,c,k)=final(c,r,k);
        end
    end
end

fid1 = fopen('capture.raw','w+');
finalImage = fwrite(fid1,captured,'uint8');