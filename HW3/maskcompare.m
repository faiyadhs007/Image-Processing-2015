%% ------------------------------------------------------------------------%
% EE 569 Homework #3
% Date: Nov. 1, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
function out = maskcompare(input1,input2)
out=0;
[row col]=size(input2);
for r=1:row 
    if input1==input2(r,:)
        out=1;
        break;
    end
    end
end


