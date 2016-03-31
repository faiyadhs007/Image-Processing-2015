%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ Channel_out ] = eqHist( Channel,cumu_Channel,row,col )

N = (row*col)/256;
in = zeros(256,1);

for r=1:row
    for c=1:col
        in(Channel(r,c))=in(Channel(r,c))+1;
        Lr= floor((cumu_Channel(Channel(r,c))+in(Channel(r,c))-1)/N);
        Channel_out(r,c)=Lr;
        if Lr>=256
            Lr =255;
        end
    end
end
end

