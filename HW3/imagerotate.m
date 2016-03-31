%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
% This function rotates the image by an angle specified. 

function final_img  = imagerotate(input_image,angle )
%% Necessary Parameters
[row,col,dim] = size(input_image);
x0 = .5 * (row-1); y0 = .5 * (col-1);

%% Rotation transformation
final_img = zeros(row,col,3);
for r =1:row
        for c =1:col
            dx = r - x0;
            dy = c - y0;
            radius  = sqrt((dx*dx) + (dy*dy));
            tx = floor((dx*cos(angle)) - (dy*sin(angle)) + x0);
            ty = floor((dx*sin(angle)) + (dy*cos(angle)) + y0);

            if (tx >= 1 &&  tx <= row && ty >= 1 && ty <= col)
                final_img(r,c,1) = input_image(tx,ty,1);
                final_img(r,c,2) = input_image(tx,ty,2);
                final_img(r,c,3) = input_image(tx,ty,3);
            end
        end
end
final_img = uint8(final_img);
end

