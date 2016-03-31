%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ h ] = myHist( row, col, Channel )
h = zeros(256,1);
for i = 1:row
    for j = 1:col
        xValue= Channel(i,j);
        h(xValue+1) = h(xValue+1)+1;
    end
end
end

