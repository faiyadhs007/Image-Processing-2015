function [ B ] = transpose( A )
% This returns the transpose of a matrix
[r c] = size(B);
B = zeros(c,r);
for i =1:r
    for j =1:c
        B(j,i) = A(i,j);
    end
end
end

