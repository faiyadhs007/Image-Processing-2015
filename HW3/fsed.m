%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function final_image = fsed(original_image,min,max)
%% Extension
FSED_extended = extension(original_image,3);
error =0; 
%% Floyd-Steinberg's error diffusion
for r=1:size(original_image,1)
    for c =1:size(original_image,2)
       Id = FSED_extended(r+1,c+1);
      if Id >= (min+max)/2
        FSED_extended(r+1,c+1) = max; 
        error = Id -max;
        FSED_extended(r+1,c+2) = FSED_extended(r+1,c+2) + ((7/16)*error);
        FSED_extended(r+2,c+0) = FSED_extended(r+2,c) + ((3/16)*error);
        FSED_extended(r+2,c+1) = FSED_extended(r+2,c+1) + ((5/16)*error);
        FSED_extended(r+2,c+2) = FSED_extended(r+2,c+2) + ((1/16)*error);
        continue;
      elseif Id < (min+max)/2
        FSED_extended(r+1,c+1) = min; 
        error = Id -min;
        FSED_extended(r+1,c+2) = FSED_extended(r+1,c+2) + ((7/16)*error);
        FSED_extended(r+2,c+0) = FSED_extended(r+2,c) + ((3/16)*error);
        FSED_extended(r+2,c+1) = FSED_extended(r+2,c+1) + ((5/16)*error);
        FSED_extended(r+2,c+2) = FSED_extended(r+2,c+2) + ((1/16)*error);

      end
    end
end
final_image = FSED_extended(2:513,2:513,:);
end