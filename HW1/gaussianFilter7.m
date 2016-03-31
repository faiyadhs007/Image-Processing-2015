function [ Channel_Filtered] = gaussianFilter7(CHANNEL)
% WINDOWSIZE should be the length of the entire window, such as
% 3x3 should be written as 9. 

% Necessary Parameters

extendedChannel = zeros(size(CHANNEL)+6);
Channel_Filtered = zeros(size(extendedChannel));

 for r=1:size(CHANNEL,1)
            for c=1:size(CHANNEL,2)
                extendedChannel(r+3,c+3)=CHANNEL(r,c);
            end
 end
 
for i=1:size(CHANNEL)
     extendedChannel(1:3,i) = extendedChannel(4,i);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(513:515,i) = extendedChannel(512,i);
 end 

 for i=1:size(CHANNEL)
     extendedChannel(i,1:3) = extendedChannel(i,4);
 end
 
 for i=1:size(CHANNEL)
     extendedChannel(i,513:515) = extendedChannel(i,512);
 end
 
 
 for r= 1:size(extendedChannel,1)-6
    for c=1:size(extendedChannel,2)-6
        window=zeros(49,1); 
        count=1;
        sum =0;
        for i=1:7
            for j=1:7
                window(count)=extendedChannel(r+i-1,c+j-1);
                sum = sum + window(count);
                count=count+1;
            end
        end
        meanValue=floor(sum/(49));
        Channel_Filtered(r,c)=meanValue;
    end
 end
 Channel_Filtered = uint8(Channel_Filtered(1:size(CHANNEL),1:size(CHANNEL)));
end

