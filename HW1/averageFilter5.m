function Channel_Filtered = averageFilter5(CHANNEL)

for r= 1:512
    for c=1:512
        window=zeros(5^2,1); 
        count=1;
        sum =0;
        for i=1:5
            for j=1:5
                window(count)=CHANNEL(r+i-1,c+j-1);
                sum = sum + window(count);
                count=count+1;
            end
        end
        meanValue=floor(sum/(25));
        Channel_Filtered(r,c)=meanValue;
    end
 end
end



