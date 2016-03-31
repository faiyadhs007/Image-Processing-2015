function [ Channel_Filtered] = medianFilter3( CHANNEL)
% WINDOWSIZE should be the length of the entire window, such as
% 3x3 should be written as 9. 

extendedChannel = zeros(size(CHANNEL)+2);
Channel_Filtered = zeros(size(extendedChannel));

for r=1:size(CHANNEL,1)
            for c=1:size(CHANNEL,2)
                extendedChannel(r+1,c+1)=CHANNEL(r,c);
            end
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(1,i) = extendedChannel(2,i);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(size(extendedChannel),i) = extendedChannel(size(extendedChannel)-1,i);
 end 

 for i=1:size(CHANNEL)
     extendedChannel(i,1) = extendedChannel(i,2);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(i,size(extendedChannel)) = extendedChannel(i,size(extendedChannel)-1);
 end
 
 
 for r= 1:size(extendedChannel,1)-2
    for c=1:size(extendedChannel,2)-2
        window=zeros(9,1); 
        count=1;
        for i=1:3
            for j=1:3
                window(count)=extendedChannel(r+i-1,c+j-1);
                count=count+1;
            end
        end
        middleValue=sort(window); % sort is available as qsort in C++
        % for 3x3 filter, 5th element is the median
        Channel_Filtered(r,c)=middleValue(5);
    end
 end
 Channel_Filtered = uint8(Channel_Filtered(1:size(CHANNEL),1:size(CHANNEL)));
end

