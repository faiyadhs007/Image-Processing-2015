function I2 = zeromean(I1,WindowSize )
% This function removes the DC component from an image
[row,col]=size(I1);
index=(WindowSize-1)/2;
I1_mean = extension(I1,WindowSize); 
for r =1:row
    for c =1:col
        window = zeros(WindowSize*WindowSize,1);
        count =1; sum =0;
        for i=1:WindowSize
            for j=1:WindowSize
                window(count) = I1_mean(r+i-1,c+j-1);
                sum = sum + window(count);
                count=count+1;
            end
        end
        meanValue=floor(sum/(WindowSize*WindowSize));
        I1_mean(r,c)=meanValue;
    end
end
I1_mean = I1_mean(index+1:row+index,index+1:col+index);
% Subtracting the average filter from the original image
I2 = I1-I1_mean;
% I2 is the zero-mean image


end

