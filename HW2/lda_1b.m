function lda_s = lda_1b()
load train_classifier.mat;
load train_non_classifier1.mat;
load train_non_classifier2.mat;
load train_non_classifier3.mat;
load test_mat.mat;

%% Output Structure
file1='LDA_Output';
lda_s=struct(file1,[]);

%% LDA calculation
negative_vector =[train_non_classifier1;train_non_classifier2;train_non_classifier3];
X = [train_classifier;negative_vector];
Y = [ones(36,1);-ones(36,1)];
obj = fitcdiscr(X,Y);
lda_projection_n = obj.Coeffs(1,2).Linear;
lda_projection_g = obj.Coeffs(2,1).Linear;

%% LDA calculation
grass_lda = train_classifier*lda_projection_g;
negative_lda = negative_vector*lda_projection_n;
grass_mean = mean(grass_lda);grass_var = var(grass_lda);
negative_mean = mean(negative_lda);negative_var = var(negative_lda);

%% Unknown vector calculation
for n=1:size(test_mat,1)
im = test_mat(n,:);
im_lda_g = im*lda_projection_g;
im_lda_n = im*lda_projection_n;
dg_lda = sqrt((im_lda_g-grass_mean)^2/grass_var);
dn_lda = sqrt((im_lda_n-negative_mean)^2/negative_var);

%% Condition for Texture Classification
% Condition for Image Texture Classification
if dg_lda < dn_lda 
    lda_s(n).LDA_Output= 'Yes';
else if dn_lda < dg_lda
           lda_s(n).LDA_Output= 'No';
    end
end
end
end