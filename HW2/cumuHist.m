%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ cumuChannel ] = cumuHist(Channel_hist,row,col)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
sumChannel = 0;
for i=1:256
    sumChannel = sumChannel+Channel_hist(i);
    cum(i) = sumChannel;
end
cumuChannel = cum;
end

