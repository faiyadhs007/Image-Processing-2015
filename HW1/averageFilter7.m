function Channel_Filtered = averageFilter7(CHANNEL)

for r= 1:512
    for c=1:512
        window=zeros(7^2,1); 
        count=1;
        sum =0;
        for i=1:7
            for j=1:7
                window(count)=CHANNEL(r+i-1,c+j-1);
                sum = sum + window(count);
                count=count+1;
            end
        end
        meanValue=floor(sum/(49));
        Channel_Filtered(r,c)=meanValue;
    end
 end
end



