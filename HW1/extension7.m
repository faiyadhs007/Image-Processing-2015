function [ extendedChannel ] = extension7(Channel)

extendedChannel = zeros(size(Channel)+6);
for r=1:size(Channel,1)
            for c=1:size(Channel,2)
                extendedChannel(r+3,c+3)=Channel(r,c);
            end
end 
 for i=1:size(Channel)
     extendedChannel(1:3,i) = extendedChannel(4,i);
 end
 
 for i=1:size(Channel)
     extendedChannel(516:518,i) = extendedChannel(512,i);
 end 

 for i=1:size(Channel)
     extendedChannel(i,1:3) = extendedChannel(i,4);
 end
 
 for i=1:size(Channel)
     extendedChannel(i,516:518) = extendedChannel(i,512);
 end

end

