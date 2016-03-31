function  I= lawfilter(Image,WindowSize,FilterType )
% This applies law's filter to the image 
Image_ext = extension(Image,WindowSize); 
[row, col]= size(Image);
for r= 1:row
    for c=1:col
        sum =0;
        window=zeros(WindowSize,WindowSize); 
        window=Image_ext(r:r+WindowSize-1,c:c+WindowSize-1);
        filtwindow=dotM(window,FilterType);
        for i = 1:5
            for j=1:5
                sum=filtwindow(i,j)+sum;
            end
        end
        I(r,c) = sum; 
    end 
end


end

