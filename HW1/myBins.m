%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function   x = myBins(cumu_Channel,pixelValue)

for j=1:3
    for i=1:256
        if cumu_Channel(i)==pixelValue*j
            x(j)=i;
        end
        if cumu_Channel(i)<pixelValue*j
            x(j)=i+1;
        end
    end
end
x(4)=256;
x=x-1;
end

