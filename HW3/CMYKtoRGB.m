%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function RGB_image = CMYKtoRGB(CMY_image)

[row, col, dim] = size(CMY_image);

for k=1:dim
    for r=1:row
        for c=1:col
            RGB_image(r,c,k) = 255*(1-CMY_image(r,c,k));
        end
    end
end
end

