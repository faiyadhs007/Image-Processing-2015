function pca_s = pca_f()
%% Loading all given vectors
load train_classifier.mat;
load train_non_classifier1.mat;
load train_non_classifier2.mat;
load train_non_classifier3.mat;
load test_mat.mat;

%% Output Structure
file1='pca_Output';
pca_s=struct(file1,[]);

%% PCA calculation
X = [train_classifier;train_non_classifier1;train_non_classifier2;train_non_classifier3];
coeff = pca(X); 
coeff_pca = zeros(25,1);
for r = 1:25
    coeff_pca(r,1:3)= coeff(r,1:3);
end

%% PCA calculation for all the matrices
grass_pca = train_classifier*coeff_pca;
leather_pca = train_non_classifier1*coeff_pca;
sand_pca = train_non_classifier2*coeff_pca;
straw_pca = train_non_classifier3*coeff_pca;
grass_mean = mean(grass_pca);grass_var = var(grass_pca);
leather_mean = mean(leather_pca);leather_var = var(leather_pca);
sand_mean = mean(sand_pca);sand_var = var(sand_pca);
straw_mean = mean(straw_pca);straw_var = var(straw_pca);

%% Test vector calculation
for n=1:size(test_mat,1)
im = test_mat(n,:); 
im_pca = im*coeff_pca;

dg_pca = sqrt(sum((im_pca-grass_mean).^2./grass_var));
dl_pca = sqrt(sum((im_pca-leather_mean).^2./leather_var));
dsa_pca = sqrt(sum((im_pca-sand_mean).^2./sand_var));
dst_pca = sqrt(sum((im_pca-straw_mean).^2./straw_var)); % Check for the sum

%% Condition for Image Texture Classification
if dg_pca < dl_pca && dg_pca < dsa_pca && dg_pca < dst_pca 
    pca_s(n).pca_Output= 'Yes';
else if dg_pca > dl_pca || dg_pca > dsa_pca || dg_pca > dst_pca 
            pca_s(n).pca_Output= 'No';
    end
end
end
end