%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function [ out ] = binarycompare( i1,i2 )
% Equivalent of binary comparison for checking similar or different element
out = abs(i1-i2);
out = logical(out);

end

