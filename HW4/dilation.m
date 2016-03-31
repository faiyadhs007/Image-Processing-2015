%% ------------------------------------------------------------------------%
% EE 569 Homework #4
% Date: Nov. 29, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function image_dilated = dilation(input_image, window_size)

[row,col,dim] = size(input_image);
mid1 = (window_size-1)/2;
mid2 = (window_size+1)/2;
%% Boundary Extension
extended_img = double(zeros(row+(window_size-1),col+(window_size-1)));
for m = 1:row
    for n = 1:col
        extended_img(m+(window_size-1)/2,n+(window_size-1)/2) = input_image(m,n);
    end
end

% Extend top & bottom rows
for i = 1:mid1
    for j = 1:col+(window_size-1)
        extended_img(i,j) = extended_img((window_size-1)+i,j); %top
    end
end
for i = 1:mid1
    for j = 1:col+(window_size-1)
        extended_img(row+(mid1)+i,j) = extended_img(row+(mid1)-i+1,j); %bottom
    end
end

% Extend left & right columns
for j = 1:mid1
    for i = 1:row
        extended_img(i+(mid1),j) = input_image(i,(mid2)-j); % left
    end
end
for j = 1:mid1
    for i = 1:row
        extended_img(i+(mid1),col+(mid1)+j) = input_image(i,col-(mid1)+j); %right
    end
end

%% Dilation operation
image_dilated = uint8(zeros(row,col));
checker = zeros(window_size,window_size);

for r = 1:row
    for c = 1:col
        for i = 1:window_size
            for j = 1:window_size
                checker(i,j) = extended_img((r+(mid1))-(mid2)+i,(c+(mid1))-(mid2)+j);
            end
        end
                image_dilated(r,c) = max(max(checker));
    end
end
end