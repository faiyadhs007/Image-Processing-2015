% Faiyadh Shahid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function  extended_image = extension1(original_image, window_size)

[row col dim] = size(original_image);
extended_image = zeros(row+(window_size-1),col+(window_size-1),3);
mid = (window_size-1)/2;
%% Placing the original image
for k = 1:dim
    for r = 1:row
        for c = 1:col
            extended_image(r+mid,c+mid,k) = original_image(r,c,k);
        end
    end
end

%% Extending top rows

for k = 1:dim
    for r = 1:mid
        for c = 1:col+(window_size-1)
            extended_image(r,c,k) = extended_image(r+(window_size-1),c,k);
        end
    end
end

%% Extending bottom rows

for k = 1:dim
    for r = 1:+mid
        for c = 1:col+(window_size-1)
            extended_image(row+r+mid,c,k) = extended_image(row-r+1+mid,c,k);
        end
    end
end

%% Extending right columns

for k = 1:dim
   for r = 1:row
       for c = 1:mid
            extended_image(r+mid,col+c+mid,k) = original_image(r,col+c-mid,k);
        end
    end
end

%% Extending left columns

for k = 1:3
    for r = 1:row
        for c = 1:mid
            extended_image(r+mid,c,k) = original_image(r,((window_size+1)/2)-c,k);
        end
    end
end
end

