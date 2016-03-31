%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function [outPosition, out] = getPosOfCapture(pixelDensity, sizeCapture, T, inputPosition)

% T is the transformation matrix
% This function gives the position of pixels to be placed on 3D cube

out = T * inputPosition;
outPosition = [out(1)/out(3)*pixelDensity,out(2)/out(3)*pixelDensity];

offset = sizeCapture/2;
outPosition(1) = floor((outPosition(1)+offset));
outPosition(2) = floor((outPosition(2)+offset));

temp = floor(outPosition(1));
outPosition(1) = floor(outPosition(2));
outPosition(2) = temp;

end

