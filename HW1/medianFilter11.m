function [ Channel_Filtered, extendedChannel] = medianFilter11( CHANNEL)
% WINDOWSIZE should be the length of the entire window, such as
% 3x3 should be written as 9. 

extendedChannel = zeros(size(CHANNEL)+10);
Channel_Filtered = zeros(size(extendedChannel));

for r=1:size(CHANNEL,1)
            for c=1:size(CHANNEL,2)
                extendedChannel(r+5,c+5)=CHANNEL(r,c);
            end
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(1:5,i) = extendedChannel(6,i);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(513:517,i) = extendedChannel(512,i);
 end 

 for i=1:size(CHANNEL)
     extendedChannel(i,1:5) = extendedChannel(i,5);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(i,513:517) = extendedChannel(i,512);
 end
 
 
 for r= 1:size(extendedChannel,1)-10
    for c=1:size(extendedChannel,2)-10
        window=zeros(11^2,1); 
        count=1;
        for i=1:11
            for j=1:11
                window(count)=extendedChannel(r+i-1,c+j-1);
                count=count+1;
            end
        end
        middleValue=sort(window); % sort is available as qsort in C++
        % for 11x11 filter, 61st element is the median
        Channel_Filtered(r,c)=middleValue(61);
    end
 end
 Channel_Filtered = uint8(Channel_Filtered(1:size(CHANNEL),1:size(CHANNEL)));
end


