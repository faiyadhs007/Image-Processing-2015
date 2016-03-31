function  outmat= dotM( mat1,mat2 )
% This function performs dot Matrix operation
[h1 w1] = size(mat1);
[h2 w2] = size(mat2);
for r =1:h1
    for c=1:w1
        outmat(r,c) = mat1(r,c)*mat2(r,c);
    end
end
end

