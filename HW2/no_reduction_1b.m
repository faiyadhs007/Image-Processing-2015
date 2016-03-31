function no_red = no_reduction_1b()
%% Loading all given vectors
load train_classifier.mat;
load train_non_classifier1.mat;
load train_non_classifier2.mat;
load train_non_classifier3.mat;
load test_mat.mat;

%% Output Structure
file1='No_Reduction_Output';
no_red=struct(file1,[]);

%% Mean and variance
for c=1:25
    sum1=0;
    gr(1:36,1)=train_classifier(1:36,c);
     for i = 1:36
        sum1= gr(i,1)+ sum1;
     end
     grass_mean(1,c)=sum1/36;
end

for c=1:25
    sum2=0;sum3=0;sum4=0;
    le(1:12,1)=train_non_classifier1(1:12,c);
    sa(1:12,1)=train_non_classifier2(1:12,c);
    st(1:12,1)=train_non_classifier3(1:12,c);
    for i = 1:12
        sum2= le(i,1)+ sum2;
        sum3= sa(i,1)+ sum3;
        sum4= st(i,1)+ sum4;
    end
    leather_mean(1,c)=sum2/12;
    sand_mean(1,c)=sum3/12;
    straw_mean(1,c)=sum4/12;
end

for c=1:25
    grass_var(1,c)=var(train_classifier(1:36,c));
    leather_var(1,c)=var(train_non_classifier1(1:12,c));
    sand_var(1,c)=var(train_non_classifier2(1:12,c));
    straw_var(1,c)=var(train_non_classifier3(1:12,c));
end

%% Mahalanobis Distance Calculation
for n=1:size(test_mat,1)
for c = 1:25
    d_grass(1,c)= ((test_mat(n,c)-grass_mean(1,c)))^2/grass_var(1,c);
    d_leather(1,c)= ((test_mat(n,c)-leather_mean(1,c)))^2/leather_var(1,c);
    d_sand(1,c)= ((test_mat(n,c)-sand_mean(1,c)))^2/sand_var(1,c);
    d_straw(1,c)= ((test_mat(n,c)-straw_mean(1,c)))^2/straw_var(1,c);
end
u1g(n,1)=sqrt(sum(d_grass)); u1le(n,1)=sqrt(sum(d_leather));
u1sa(n,1)=sqrt(sum(d_sand)); u1st(n,1)=sqrt(sum(d_straw));

%% Condition for Image Texture Classification
if u1g(n,1) < u1le(n,1) && u1g(n,1) < u1sa(n,1) && u1g(n,1) < u1st(n,1)
    no_red(n).No_Reduction_Output= 'Yes';
else if u1g(n,1) > u1le(n,1) || u1g(n,1) > u1sa(n,1)|| u1g(n,1) > u1st(n,1)
            no_red(n).No_Reduction_Output= 'No';
end
end
end
end