function  FeatureValue= energy( LawsImage)
% This function finds 25 feature values obtained from Law's filter
[row,col]= size(LawsImage);
sum =0;
for r=1:row
    for c=1:col
        Output(r,c) = LawsImage(r,c)*LawsImage(r,c);
        sum = sum+Output(r,c);
    end
end
FeatureValue = sum/(row*col);
end

