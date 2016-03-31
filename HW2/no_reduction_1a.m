function  no_red = no_reduction_f( )
%% Loading all given vectors
load grass_vector.mat; 
load straw_vector.mat; 
load unknown_vector.mat;
load unknown_file_names.mat;
[rows col]=size(grass_vector);

%% Output Structure
file1='File_Name';
file2='No_Reduction_Output';
no_red=struct(file1,[],file2,[]);

%% Mean and variance
% Grass and Straw - mean and variance 
for c=1:col
    sum1=0;
    sum2=0;
    a(1:rows,1)=grass_vector(1:rows,c);
    b(1:rows,1)=straw_vector(1:rows,c);
    for i = 1:rows
        sum1= a(i,1)+ sum1;
        sum2= b(i,1)+ sum2;
    end
    grass_mean(1,c)=sum1/rows;
    straw_mean(1,c)=sum2/rows;
end

for c=1:col
    grass_var(1,c)=var(grass_vector(1:36,c));
    straw_var(1,c)=var(straw_vector(1:36,c));
end

%% Mahalanobis Distance Calculation
for n=1:size(unknown_vector,1)
for c = 1:col
    d_grass(1,c)= ((unknown_vector(n,c)-grass_mean(1,c)))^2/grass_var(1,c);
    d_straw(1,c)= ((unknown_vector(n,c)-straw_mean(1,c)))^2/straw_var(1,c);
end
u1g(n,1)=sqrt(sum(d_grass)); u1s(n,1)=sqrt(sum(d_straw));

% Recording File Name
no_red(n).File_Name=unknown_file_names(n).UnknownFileName;

% Condition for Image Texture Classification
if u1g(n,1) < u1s(n,1) 
    no_red(n).No_Reduction_Output= 'Grass';
else if u1s(n,1) < u1g(n,1)
            no_red(n).No_Reduction_Output= 'Straw';
end
end
end

end

