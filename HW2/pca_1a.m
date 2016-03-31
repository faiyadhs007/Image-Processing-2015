function pca_s = pca_f()
load grass_vector;
load straw_vector;
load unknown_vector;
load unknown_file_names.mat;

%% Output Structure
file1='File_Name';
file2='pca_Output';
pca_s=struct(file1,[],file2,[]);
%% PCA vector calculation
X = [grass_vector;straw_vector];
coeff = pca(X); 
coeff_pca = zeros(25,1);
for r = 1:25
    coeff_pca(r,1)= coeff(r,1);
end

%% Grass and Straw calculation
grass_pca = grass_vector*coeff_pca;
straw_pca = straw_vector*coeff_pca;
grass_mean = mean(grass_pca);grass_var = var(grass_pca);
straw_mean = mean(straw_pca);straw_var = var(straw_pca);

%% Unknown vector calculation
for n=1:size(unknown_vector,1)
im = unknown_vector(n,:); 
im_pca = im*coeff_pca;

dg_pca = sqrt((im_pca-grass_mean)^2/grass_var);
ds_pca = sqrt((im_pca-straw_mean)^2/straw_var);

% Recording File Name
pca_s(n).File_Name=unknown_file_names(n).UnknownFileName;

% Condition for Image Texture Classification
if dg_pca < ds_pca 
    pca_s(n).pca_Output= 'Grass';
else if ds_pca < dg_pca
            pca_s(n).pca_Output= 'Straw';
    end
end
end


end

