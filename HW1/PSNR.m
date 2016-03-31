function [ p,mse,sum ] = PSNR( noisyImage,filteredImage,row,col)

max =255; mse =0; sum =0; 
for r=1:row
    for c=1:row
        mse(r,c) = (filteredImage(r,c)-noisyImage(r,c))^2;
        sum = sum+ mse(r,c);
    end
end
p = abs(10* log10(max^2/sum));
end

