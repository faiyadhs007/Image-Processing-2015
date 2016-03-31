function [ Channel_Filtered] = gaussianFilter5(CHANNEL)
% WINDOWSIZE should be the length of the entire window, such as
% 3x3 should be written as 9. 

% Necessary Parameters

extendedChannel = zeros(size(CHANNEL)+4);
Channel_Filtered = zeros(size(extendedChannel));

 for r=1:size(CHANNEL,1)
            for c=1:size(CHANNEL,2)
                extendedChannel(r+2,c+2)=CHANNEL(r,c);
            end
 end
 
for i=1:size(CHANNEL)
     extendedChannel(1:2,i) = extendedChannel(3,i);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(513:514,i) = extendedChannel(512,i);
 end 

 for i=1:size(CHANNEL)
     extendedChannel(i,1:2) = extendedChannel(i,3);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(i,513:514) = extendedChannel(i,512);
 end

 
 for r= 1:size(extendedChannel,1)-4
    for c=1:size(extendedChannel,2)-4
        window=zeros(25,1); 
        count=1;
        sum =0;
        for i=1:5
            for j=1:5
                window(count)=extendedChannel(r+i-1,c+j-1);
                sum = sum + window(count);
                count=count+1;
            end
        end
        meanValue=floor(sum/(25));
        Channel_Filtered(r,c)=meanValue;
    end
 end
 Channel_Filtered = uint8(Channel_Filtered(1:size(CHANNEL),1:size(CHANNEL)));
end

