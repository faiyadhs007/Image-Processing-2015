%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function Subtractive_image = skeletonizing(Hole_filled_image, row,col)

M_conditional = [[0 1 0 0 1 1 0 0 0];[0 1 0 1 1 0 0 0 0];[0 0 0 1 1 0 0 1 0];[0 0 0 0 1 1 0 1 0];
[0 0 1 0 1 1 0 0 1];[1 1 1 0 1 0 0 0 0];[1 0 0 1 1 0 1 0 0];[0 0 0 0 1 0 1 1 1];
[1 1 1 0 1 1 0 0 0];[0 1 1 0 1 1 0 0 1];[0 0 0 0 1 1 1 1 1];[0 0 1 0 1 1 0 1 1];
[1 1 1 1 1 0 0 0 0];[0 1 1 1 1 0 1 0 0];[1 0 0 1 1 0 1 1 0];[0 0 0 1 1 0 1 1 1];
[1 1 1 0 1 1 0 0 1];[1 1 1 1 1 0 1 0 0];[1 0 0 1 1 0 1 1 1];[0 0 1 0 1 1 1 1 1];
[0 1 1 0 1 1 0 1 1];[1 1 1 1 1 1 0 0 0];[1 1 0 1 1 0 1 1 0];[0 0 0 1 1 1 1 1 1];
[1 1 1 0 1 1 0 1 1];[0 1 1 0 1 1 1 1 1];[1 1 1 1 1 1 1 0 0];[1 1 1 1 1 1 0 0 1];
[1 1 1 1 1 0 1 1 0];[1 1 0 1 1 0 1 1 1];[1 0 0 1 1 1 1 1 1];[0 0 1 1 1 1 1 1 1];
[1 1 1 0 1 1 1 1 1];[1 1 1 1 1 1 1 0 1];[1 1 1 1 1 0 1 1 1];[1 0 1 1 1 1 1 1 1];
[1 1 1 1 1 1 0 1 1];[1 1 1 1 1 1 1 1 0];[1 1 0 1 1 1 1 1 1];[0 1 1 1 1 1 1 1 1]];

mask_UC_without_D = [[0 0 0 0 1 0 0 0 1];[0 0 0 0 1 1 0 0 0];[0 0 0 0 1 1 0 1 0];[0 0 0 1 1 0 0 1 0];
[0 0 0 0 1 0 0 1 0];[0 0 0 0 1 1 0 0 0];[0 0 0 1 1 0 0 0 0];[0 0 0 1 1 0 0 1 0];
[0 1 0 0 1 1 0 0 0];[0 1 0 1 1 0 0 0 0];[0 0 0 0 1 1 0 1 0];[0 0 0 1 1 0 0 1 0];
[0 1 0 0 1 1 1 0 0];[1 1 0 0 1 1 1 0 0];[0 1 0 0 1 1 1 0 1];[1 1 0 0 1 1 1 0 1];
[0 1 0 1 1 0 0 0 1];[0 1 1 1 1 0 0 0 1];[0 1 0 1 1 0 1 0 1];[0 1 1 1 1 0 1 0 1];
[0 0 1 1 1 0 0 1 0];[1 0 1 1 1 0 0 1 0];[0 0 1 1 1 0 0 1 1];[1 0 1 1 1 0 0 1 1];
[1 0 0 0 1 1 0 1 0];[1 0 1 0 1 1 0 1 0];[1 0 0 0 1 1 1 1 0];[1 0 1 0 1 1 1 1 0]];
 
mask_UC_with_D = [[1 1 0 1 1 0 0 0 0];[0 0 0 0 1 1 0 1 1];                                        % Corner Cluster
 [0 1 0 1 1 1 0 0 0];[0 1 0 1 1 0 0 1 0];[0 0 0 1 1 1 0 1 0];[0 1 0 0 1 1 0 1 0];% Tee Branch
 [1 0 1 0 1 0 1 0 0];[1 0 1 0 1 0 0 1 0];[1 0 1 0 1 0 0 0 1];[1 0 1 0 1 0 1 1 0];% Vee Branch
 [1 0 1 0 1 0 0 1 1];[1 0 1 0 1 0 1 0 1];[1 0 1 0 1 1 1 1 1];[1 0 0 0 1 0 1 0 1];
 [1 0 0 0 1 1 1 0 0];[1 0 1 0 1 0 1 0 0];[1 0 0 0 1 1 1 0 1];[1 0 1 0 1 1 1 0 0];
 [1 0 1 0 1 0 1 0 1];[1 0 1 0 1 1 1 0 1];[0 0 1 0 1 0 1 0 1];[0 1 0 0 1 0 1 0 1];
 [1 0 0 0 1 0 1 0 1];[0 1 1 0 1 0 1 0 1];[1 1 0 0 1 0 1 0 1];[1 0 1 0 1 0 1 0 1];
 [1 1 1 0 1 0 1 0 1];[1 0 1 0 1 0 0 0 1];[0 0 1 1 1 0 0 0 1];[0 0 1 0 1 0 1 0 1];
 [1 0 1 1 1 0 0 0 1];[0 0 1 1 1 0 1 0 1];[1 0 1 0 1 0 1 0 1];[1 0 1 1 1 0 1 0 1]];% Vee Branch
                         
D_mask = [[1 1 0 1 1 0 0 0 0];[0 0 0 0 1 1 0 1 1]                               % Corner Cluster
[0 1 0 1 1 1 0 0 0];[0 1 0 1 1 0 0 1 0];[0 0 0 1 1 1 0 1 0];[0 1 0 0 1 1 0 1 0];% Tee Branch
[1 0 1 0 1 0 1 0 0];[1 0 1 0 1 0 0 1 0];[1 0 1 0 1 0 0 0 1];[1 0 1 0 1 0 1 1 0];% Vee Branch
[1 0 1 0 1 0 0 1 1];[1 0 1 0 1 0 1 0 1];[1 0 1 0 1 1 1 1 1];[1 0 0 0 1 0 1 0 1];
[1 0 0 0 1 1 1 0 0];[1 0 1 0 1 0 1 0 0];[1 0 0 0 1 1 1 0 1];[1 0 1 0 1 1 1 0 0];
[1 0 1 0 1 0 1 0 1];[1 0 1 0 1 1 1 0 1];[0 0 1 0 1 0 1 0 1];[0 1 0 0 1 0 1 0 1];
[1 0 0 0 1 0 1 0 1];[0 1 1 0 1 0 1 0 1];[1 1 0 0 1 0 1 0 1];[1 0 1 0 1 0 1 0 1];
[1 1 1 0 1 0 1 0 1];[1 0 1 0 1 0 0 0 1];[0 0 1 1 1 0 0 0 1];[0 0 1 0 1 0 1 0 1];
[1 0 1 1 1 0 0 0 1];[0 0 1 1 1 0 1 0 1];[1 0 1 0 1 0 1 0 1];[1 0 1 1 1 0 1 0 1]];


%% Main Thinning
Initial_image = logical(extension(Hole_filled_image,3)); 
Mask_image=zeros(row+2,col+2);

for r =2:row-1
    for c =2:col-1
        if Initial_image(r,c)~=0
            win=Initial_image(r-1:r+1,c-1:c+1);
            win=[win(1,:) win(2,:) win(3,:)];
            if maskcompare(win,M_conditional) ==1
                 Mask_image(r,c)=1;
            end
        else  Mask_image(r,c)=0;
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
            if maskcompare(win,mask_UC_without_D) ==1 
                Subtractive_image(r,c)= Initial_image(r,c);
            else
            for i=1:size(D_mask,1)
                dont_care(i,:)=and(win,D_mask(i,:));
                val=maskcompare(dont_care(i,:),mask_UC_with_D(i,:));
               if val==1 
                   Subtractive_image(r,c) = Initial_image(r,c);
                   break;
               else Subtractive_image(r,c) = 0;
               end
            end
            end
        elseif Mask_image(r,c)~=1
            Subtractive_image(r,c) = Initial_image(r,c);
        end
    end
end
Subtractive_image = Subtractive_image(2:276,2:361);
end