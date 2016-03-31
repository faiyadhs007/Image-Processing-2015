function [ Channel_Filtered, extendedChannel] = medianFilter9( CHANNEL)
% WINDOWSIZE should be the length of the entire window, such as
% 3x3 should be written as 9. 

extendedChannel = zeros(size(CHANNEL)+8);
Channel_Filtered = zeros(size(extendedChannel));

for r=1:size(CHANNEL,1)
            for c=1:size(CHANNEL,2)
                extendedChannel(r+4,c+4)=CHANNEL(r,c);
            end
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(1:4,i) = extendedChannel(5,i);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(513:516,i) = extendedChannel(512,i);
 end 

 for i=1:size(CHANNEL)
     extendedChannel(i,1:4) = extendedChannel(i,5);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(i,513:516) = extendedChannel(i,512);
 end
 
 
 for r= 1:size(extendedChannel,1)-8
    for c=1:size(extendedChannel,2)-8
        window=zeros(9^2,1); 
        count=1;
        for i=1:9
            for j=1:9
                window(count)=extendedChannel(r+i-1,c+j-1);
                count=count+1;
            end
        end
        middleValue=sort(window); % sort is available as qsort in C++
        % for 9x9 filter, 41st element is the median
        Channel_Filtered(r,c)=middleValue(41);
    end
 end
 Channel_Filtered = uint8(Channel_Filtered(1:size(CHANNEL),1:size(CHANNEL)));
end


