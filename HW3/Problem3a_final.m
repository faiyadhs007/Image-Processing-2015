%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
close all; clear all; clc;
%% Reading the file
row= 108; col = 91;BytesPerPixel = 1;
fileID = fopen('Horseshoe.raw');
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
imshow(I2); title('Original Image');

%% Applying erosion
I2_eroded = erosion(I2,3);
figure; imshow(I2_eroded);title('Eroded image');

%% Applying shrinking operation -1
I2_shrunk = shrinking(I2_eroded,row,col);
figure; imshow(I2_shrunk);title('Shrunk image-01');

for i=1:20
    I2_shrunk = shrinking(I2_shrunk,row,col);
    imshow(I2_shrunk);
end
figure;imshow(I2_shrunk);title('Final Shrunk Image-01');

%% Applying dilation
I2_dilated = logical(dilation(I2_shrunk,5));
figure; imshow(I2_dilated);title('Dilated image');

%% Applying shrinking operation -2
I2_shrunk2 = shrinking(I2_dilated,row,col);
figure; imshow(I2_shrunk2);title('Shrunk image-02');

for i=1:20
    I2_shrunk2 = shrinking(I2_shrunk2,row,col);
    imshow(I2_shrunk2);
end
figure;imshow(I2_shrunk2);title('Final Shrunk Image-02');

%% Part-3.a.1 : Finding the number of nails(white circle) and holes (black dots)
% Number of nails
NailNum = 0; checker = logical(zeros(1,9));

for r =2:row-1
    for c =2:col-1
        if I2_shrunk2(r,c) == 1
            count(r,c) =1;
            for i =1:size(checker,2)/3
                for j =1:size(checker,2)/3
                    checker(1,count(r,c)) = I2_shrunk2(r+i-2,c+j-2);
                    count(r,c) = count(r,c) +1;
                end
            end
            checker(1,((size(checker)-1)/2)+1) = 0;
            mark =binarycompare( checker,[0 0 0 0 0 0 0 0 0]);
            mark_sum = sum(mark);
            if (mark_sum == 0)
            NailNum = NailNum + 1;
          end
        end
    end
end
formatSpec = 'Number of nails:%4i \n';
fprintf(formatSpec, NailNum);

% Number of holes
% In this case, we can use the original image with inversion & use the same logic as above
% to count the number of holes
Hole_image = logical(255 - I2);
HoleNum = 0; checker2 = logical(zeros(1,9));

for r =2:row-1
    for c =2:col-1
        if Hole_image(r,c) == 1
            count2(r,c) =1;
            for i =1:size(checker2,2)/3
                for j =1:size(checker2,2)/3
                    checker2(1,count2(r,c)) = Hole_image(r+i-2,c+j-2);
                    count2(r,c) = count2(r,c) +1;
                end
            end
            checker2(1,((size(checker2)-1)/2)+1) = 0;
            mark2 =binarycompare(checker2,[0 0 0 0 0 0 0 0 0]);
            mark2_sum = sum(mark2);
            if (mark2_sum == 0)
            HoleNum = HoleNum + 1;
          end
        end
    end
end
formatSpec = 'Number of holes:%4i \n';
fprintf(formatSpec, HoleNum);

%% Part-3.a.2 : Finding the white objects using connected component labeling 
I2_labeled  = logical(I2);

% Using Connected Component Labeling (Self-written)
detect=I2_labeled;
h=zeros(size(detect));
count=1;

for r=2:size(detect,1)-1
    for c=2:size(detect,2)-1
        h2= h(r-1,c);
        h4= h(r,c-1);
        h5= h(r,c+1);
        h7= h(r+1,c);
        hn=[h2  h4 h5  h7];
        if detect(r,c)==1
            if hn==0
                h(r,c)=count;
                count=count+1;
            else
                h(r,c)= max(hn);
            end
        end
    end
end

for i =1:150 
for r=2:size(detect,1)-1
    for c=2:size(detect,2)-1
        h2= h(r-1,c);
        h4= h(r,c-1);
        h5= h(r,c+1);
        h7= h(r+1,c);
        hn=[h2  h4 h5  h7];
        hmin=min(hn(hn~=0));
        if h(r,c)~=0
            if h(r,c)> hmin
                h(r,c)=hmin;
            else h(r,c)=h(r,c);    
            end
        end
    end
end
end

diff = length(unique(h))-1;
uni=unique(h);
uni=uni(uni~=0);
for i=1:length(uni)
    h(h==uni(i,1))=i;
end

formatSpec = 'Number of white objects:%4i \n';
fprintf(formatSpec, diff);

% Using MATLAB's built-in function (Testing purpose)
% L = bwlabel(I2_labeled,4);
% L_trial = zeros(row,col,3);
% L_trial(:,:,1) = L;L_trial(:,:,2) = L;L_trial(:,:,3) = L;
% 
% for r =1:row
%     for c =1:col
%         if L(r,c) ==1 
%             L_trial(r,c,1) = 255;
%             L_trial(r,c,2:3) =0;
%         elseif L(r,c) == 2 || L(r,c) == 3 || L(r,c) == 4 || L(r,c) == 5 || L(r,c) == 6 ||L(r,c) == 7 ||L(r,c) == 8 ||L(r,c) == 9 
%             L_trial(r,c,1) =0;
%             L_trial(r,c,2) = 255;
%             L_trial(r,c,3) =0;
%         else L_trial(r,c,:) =0;    
%         end
%     end
% end
% figure
% imshow(uint8(L_trial));

%% Color labeling 
h_labeled = zeros(row,col,3);
h_labeled(:,:,1) = h; h_labeled(:,:,2) = h;h_labeled(:,:,3) = h;

for r =1:row
    for c =1:col
        if h(r,c) ==1 
            h_labeled(r,c,1) = 255;
            h_labeled(r,c,2:3) =0;
        elseif h(r,c) == 2 
            h_labeled(r,c,1) =10;
            h_labeled(r,c,2) = 255;
            h_labeled(r,c,3) =10;
        elseif h(r,c) == 3 
            h_labeled(r,c,1) =10;
            h_labeled(r,c,2) = 100;
            h_labeled(r,c,3) =255;
        elseif h(r,c) == 4 
            h_labeled(r,c,1) =100;
            h_labeled(r,c,2) = 0;
            h_labeled(r,c,3) =255;
        elseif h(r,c) == 5 
            h_labeled(r,c,1) =100;
            h_labeled(r,c,2) = 255;
            h_labeled(r,c,3) =255;
        elseif h(r,c) == 6
            h_labeled(r,c,1) =50;
            h_labeled(r,c,2) =150;
            h_labeled(r,c,3) =50;
        elseif h(r,c) == 7
            h_labeled(r,c,1) =255;
            h_labeled(r,c,2) =255;
            h_labeled(r,c,3) =10;
         elseif h(r,c) == 8
            h_labeled(r,c,1) =20;
            h_labeled(r,c,2) =200;
            h_labeled(r,c,3) =100;
        elseif h(r,c) == 9 
            h_labeled(r,c,1) =255;
            h_labeled(r,c,2) =100;
            h_labeled(r,c,3) =15;
        else h_labeled(r,c,:) =0;    
        end
        % imshow(h_labeled);
    end
end

figure; imshow(uint8(h_labeled)); title('Color Component Labeled');

%% Writing raw image
final = uint8(h_labeled);
new_row = size(final,1);new_col = size(final,2);
horseshoe_labeled = uint8(zeros(new_col,new_row,3));
for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            horseshoe_labeled(r,c,k)=final(c,r,k);
        end
    end
end

fid1 = fopen('horseshoe_labeled.raw','w+');
finalImage = fwrite(fid1,horseshoe_labeled,'uint8');