%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ cdfChannel ] = cdfHist(Channel_cumu,row,col) 

for i = 1:256
   cdfChannel(i) = Channel_cumu(i)/(row*col);
end

end

