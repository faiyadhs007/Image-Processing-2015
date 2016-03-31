function [ extendedChannel ] = extension5(Channel)

extendedChannel = zeros(size(Channel)+4);
for r=1:size(Channel,1)
            for c=1:size(Channel,2)
                extendedChannel(r+2,c+2)=Channel(r,c);
            end
end 
 for i=1:size(Channel)
     extendedChannel(1:2,i) = extendedChannel(3,i);
 end
 
 for i=1:size(Channel)
     extendedChannel(515:516,i) = extendedChannel(512,i);
 end 

 for i=1:size(Channel)
     extendedChannel(i,1:2) = extendedChannel(i,3);
 end
 
 for i=1:size(Channel)
     extendedChannel(i,515:516) = extendedChannel(i,512);
 end

end

