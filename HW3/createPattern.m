%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
clear all; clc

M = 1;

%% Corner Cluster
D1 = getcondvects(5);
corner_cluster = false(1,9);
for i = 1: size(D1,1)
    corner_cluster(i,:)= [M M D1(i,1) M M D1(i,2) D1(i,3) D1(i,4) D1(i,5)];
end

%% Tee Branch 
D2 = getcondvects(2);

for i = 1: size(D2,1)
    tee_branch1(i,:) = [D2(i,1) M 0 M M M D2(i,2) 0 0];
    tee_branch2(i,:) = [0 M D2(i,1) M M M 0 0 D2(i,2)];
    tee_branch3(i,:) = [0 0 D2(i,1) M M M 0 M D2(i,2)];
    tee_branch4(i,:) = [D2(i,1) 0 0 M M M D2(i,2) M 0];
    tee_branch5(i,:) = [D2(i,1) M D2(i,2) M M 0 0 M 0];
    tee_branch6(i,:) = [0 M 0 M M 0 D2(i,1) M D2(i,2)];
    tee_branch7(i,:) = [0 M 0 0 M M D2(i,1) M D2(i,2)];
    tee_branch8(i,:) = [D2(i,1) M D2(i,2) 0 M M 0 M 0];
end
    tee_branch = [tee_branch1;tee_branch2;tee_branch3;tee_branch4;...
                  tee_branch5;tee_branch6;tee_branch7;tee_branch8];
              
%% Vee Branch 
A=2; B=3; C=4; 
D3 = getcondvects(3);

for i = 1: size(D3,1)
    vee_branch1(i,:) = [M D3(i,1) M D3(i,2) M D3(i,3) A B C];
    vee_branch2(i,:) = [M D3(i,1) C D3(i,2) M B M D3(i,3) A];
    vee_branch3(i,:) = [C B A D3(i,1) M D3(i,2) M D3(i,3) M];
    vee_branch4(i,:) = [A D3(i,1) M B M D3(i,2) C D3(i,3) M];
end
    vee_branch1 = repmat(vee_branch1,7,1);
    vee_branch2 = repmat(vee_branch2,7,1);
    vee_branch3 = repmat(vee_branch3,7,1);
    vee_branch4 = repmat(vee_branch4,7,1);
    
ABC = getcondvects(3);
ABC2 = repmat(ABC(2,:),8,1);ABC3 = repmat(ABC(3,:),8,1);
ABC4 = repmat(ABC(4,:),8,1);ABC5 = repmat(ABC(5,:),8,1);
ABC6 = repmat(ABC(6,:),8,1);ABC7 = repmat(ABC(7,:),8,1);
ABC8 = repmat(ABC(8,:),8,1);
ABC1 = [ABC2; ABC3; ABC4; ABC5; ABC6; ABC7; ABC8];
for i =1:56
    A3(i,1) = ABC1(i,1);
    B3(i,1) = ABC1(i,2);
    C3(i,1) = ABC1(i,3);
end
for i =1:56
    for j =1:9
        if vee_branch1(i,j) ==2
            vee_branch1(i,j) = A3(i,1);
        elseif vee_branch1(i,j) ==3
            vee_branch1(i,j) = B3(i,1);
        elseif vee_branch1(i,j) ==4
            vee_branch1(i,j) = C3(i,1);
        end
        if vee_branch2(i,j) ==2
            vee_branch2(i,j) = A3(i,1);
        elseif vee_branch2(i,j) ==3
            vee_branch2(i,j) = B3(i,1);
        elseif vee_branch2(i,j) ==4
            vee_branch2(i,j) = C3(i,1); 
        end
        if vee_branch3(i,j) ==2
            vee_branch3(i,j) = A3(i,1);
        elseif vee_branch3(i,j) ==3
            vee_branch3(i,j) = B3(i,1);
        elseif vee_branch3(i,j) ==4
            vee_branch3(i,j) = C3(i,1);
        end
        if vee_branch4(i,j) ==2
            vee_branch4(i,j) = A3(i,1);
        elseif vee_branch4(i,j) ==3
            vee_branch4(i,j) = B3(i,1);
        elseif vee_branch4(i,j) ==4
            vee_branch4(i,j) = C3(i,1);
        end
    end
end
vee_branch = [vee_branch1;vee_branch2;vee_branch3;vee_branch4];
%% Diagonal Branch 
D4 = getcondvects(2);

for i = 1: size(D4,1)
    diagonal_branch1(i,:) = [D4(i,1) M 0 0 M M M 0 D4(i,2)];
    diagonal_branch2(i,:) = [0 M D4(i,1) M M 0 D4(i,2) 0 M];
    diagonal_branch3(i,:) = [D4(i,1) 0 M M M 0 0 M D4(i,2)];
    diagonal_branch4(i,:) = [M 0 D4(i,1) 0 M M D4(i,2) M 0];
end
    diagonal_branch = [diagonal_branch1;diagonal_branch2;diagonal_branch3;...
                       diagonal_branch4];
                   
%% Final Table-2 (Shrinking and Thinning) 
Final_ST = [ [0 0 1 0 1 0 0 0 0]; [1 0 0 0 1 0 0 0 0]; % Spur 
         [0 0 0 0 1 0 0 1 0]; [0 0 0 0 1 1 0 0 0];     % Single 4-connection
         [0 0 1 0 1 1 0 0 0]; [0 1 1 0 1 0 0 0 0]; [1 1 0 0 1 0 0 0 0];...
         [1 0 0 1 1 0 0 0 0]; [0 0 0 1 1 0 1 0 0]; [0 0 0 0 1 0 1 1 0];...
         [0 0 0 0 1 0 0 1 1]; [0 0 0 0 1 1 0 0 1];     % L Cluster
         [0 1 1 1 1 0 0 0 0]; [1 1 0 0 1 1 0 0 0]; [0 1 0 0 1 1 0 0 1];... 
         [0 0 1 0 1 1 0 1 0];                          % 4-connected offset
         [0 0 M 0 M 1 M 0 0]; [0 1 M 0 M 0 M 0 0]; [0 1 M 0 M 1 M 0 0];...
         [M 0 0 1 M 0 0 0 M]; [M 1 0 0 M 0 0 0 M]; [M 1 0 1 M 0 0 0 M];...
         [0 0 M 0 M 0 M 1 0]; [0 0 M 1 M 0 M 0 0]; [0 0 M 1 M 0 M 1 0];...
         [M 0 0 0 M 0 0 1 M]; [M 0 0 0 M 1 0 0 M]; [M 0 0 0 M 1 0 1 M];... %Spur Corner Cluster
         corner_cluster; tee_branch; vee_branch; diagonal_branch
      
       ]; 
save('Final_Unconditional_Mask_ST.mat');