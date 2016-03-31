function [ Channel_Filtered, extendedChannel] = medianFilter5( CHANNEL)
% WINDOWSIZE should be the length of the entire window, such as
% 3x3 should be written as 9. 

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
        window=zeros(5^2,1); 
        count=1;
        for i=1:5
            for j=1:5
                window(count)=extendedChannel(r+i-1,c+j-1);
                count=count+1;
            end
        end
        middleValue=sort(window); % sort is available as qsort in C++
        % for 5x5 filter, 13th element is the median
        Channel_Filtered(r,c)=middleValue(13);
    end
 end
 Channel_Filtered = uint8(Channel_Filtered(1:size(CHANNEL),1:size(CHANNEL)));
end



