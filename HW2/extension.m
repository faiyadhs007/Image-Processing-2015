function extendedChannel = extension(Channel,Windowsize)
% This function extends the given image matrix based on the window size 
% of the filter kernel that will be convolved with the image
[row col dim]=size(Channel);
ext=(Windowsize-1)/2;
extendedChannel = zeros(row+2*ext,col+2*ext);

for r=1:row
    for c=1:col
        extendedChannel(r+ext,c+ext)=Channel(r,c);
    end
end 

%Top
for i=1:ext
    for c=1:col
        extendedChannel(i,c+ext)=Channel(ext+1-i,c);
    end
end

%Bottom
for i=row-ext+1:row
    for c=1:col
        extendedChannel(ext+2*row-i+1,c+ext)=Channel(i,c);
    end
end

%Left
for i=1:ext
    for r=1:row
        extendedChannel(r+ext,i)=Channel(r,ext+1-i);
    end
end

%Right
for i=col-ext+1:col
    for r=1:row
        extendedChannel(r+ext,ext+2*col-i+1)=Channel(r,i);
    end
end

%Null Spaces
extendedChannel(1:ext,1:ext)=Channel(1:ext,1:ext);
extendedChannel(1:ext,col+ext+1:col+2*ext)=Channel(1:ext,col-ext+1:col);
extendedChannel(row+ext+1:row+2*ext,1:ext)=Channel(row-ext+1:row,1:ext);
extendedChannel(row+ext+1:row+2*ext,col+ext+1:col+2*ext)=Channel(row-ext+1:row,col-ext+1:col);