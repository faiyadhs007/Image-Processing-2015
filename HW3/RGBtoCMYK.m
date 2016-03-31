%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function CMYK_img = RGBtoCMYK(RGB_img)

% Converts RGB to CMYK 

[row, col, dim] = size(RGB_img);

for k=1:dim
    for r =1:row
        for c=1:col
            CMYK_img(r,c,k) = 1- (double(RGB_img(r,c,k))/255);
        end
    end
end


end

