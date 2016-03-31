%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function Subtractive_image = thinning2(Hole_filled_image, row,col)
load('Final_Unconditional_Mask_ST.mat');
%% Masks
mask_Conditional = [[0 1 0 0 1 1 0 0 0];[0 1 0 1 1 0 0 0 0];[0 0 0 1 1 0 0 1 0];[0 0 0 0 1 1 0 1 0];% TK4
                    [0 0 1 0 1 1 0 0 1];[1 1 1 0 1 0 0 0 0];[1 0 0 1 1 0 1 0 0];[0 0 0 0 1 0 1 1 1];% STK4
                    [1 1 0 0 1 1 0 0 0];[0 1 0 0 1 1 0 0 1];[0 1 1 1 1 0 0 0 0];[0 0 1 0 1 1 0 1 0];% ST5
                    [0 1 1 0 1 1 0 0 0];[1 1 0 1 1 0 0 0 0];[0 0 0 1 1 0 1 1 0];[0 0 0 0 1 1 0 1 1];% ST5
                    [1 1 0 0 1 1 0 0 1];[0 1 1 1 1 0 1 0 0];[1 1 1 0 1 1 0 0 0];[0 1 1 0 1 1 0 0 1];% STK6
                    [1 1 1 1 1 0 0 0 0];[0 1 1 1 1 0 1 0 0];[1 0 0 1 1 0 1 1 0];[0 0 0 1 1 0 1 1 1];% STK6
                    [0 0 0 0 1 1 1 1 1];[0 0 1 0 1 1 0 1 1];                                        % STK6
                    [1 1 1 0 1 1 0 0 1];[1 1 1 1 1 0 1 0 0];[1 0 0 1 1 0 1 1 1];[0 0 1 0 1 1 1 1 1];% STK7
                    [0 1 1 0 1 1 0 1 1];[1 1 1 1 1 1 0 0 0];[1 1 0 1 1 0 1 1 0];[0 0 0 1 1 1 1 1 1];% STK8
                    [1 1 1 0 1 1 0 1 1];[0 1 1 0 1 1 1 1 1];[1 1 1 1 1 1 1 0 0];[1 1 1 1 1 1 0 0 1];% STK9
                    [1 1 1 1 1 0 1 1 0];[1 1 0 1 1 0 1 1 1];[1 0 0 1 1 1 1 1 1];[0 0 1 1 1 1 1 1 1];% STK9
                    [1 1 1 0 1 1 1 1 1];[1 1 1 1 1 1 1 0 1];[1 1 1 1 1 0 1 1 1];[1 0 1 1 1 1 1 1 1]];% STK10
     
%% Main Thinning
Initial_image = logical(extension(Hole_filled_image,3)); 
Mask_image=zeros(row+2,col+2);

for r =2:row-1
    for c =2:col-1
        if Initial_image(r,c)~=0
            win=Initial_image(r-1:r+1,c-1:c+1);
            win=[win(1,:) win(2,:) win(3,:)];
            if maskcompare(win,mask_Conditional) ==1
                 Mask_image(r,c)=1;
            end
        %else  Mask_image(r,c)=0;
        end
        end
end 
% figure;imshow(Mask_image);

Subtractive_image=zeros(row+2,col+2);

for r=2:row-1
    for c = 2:col-1
        if Mask_image(r,c)~=0
            win=Mask_image(r-1:r+1,c-1:c+1);
            win=[win(1,:) win(2,:) win(3,:)];
            if maskcompare(win,Final_ST) ==1
                 Subtractive_image(r,c)=Initial_image(r,c);
            else Subtractive_image(r,c)=0;
            end
        elseif Mask_image(r,c)~=1
            Subtractive_image(r,c) = Initial_image(r,c);
        end
    end
end
Subtractive_image = Subtractive_image(2:row+1,2:col+1);
% imshow(Mask_image);title('Mask Image');
end
