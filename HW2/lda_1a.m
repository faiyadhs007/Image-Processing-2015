function lda_s = lda_f()
load grass_vector;
load straw_vector;
load unknown_vector;
load unknown_file_names.mat;

%% Output Structure
file1='File_Name';
file2='LDA_Output';
lda_s=struct(file1,[],file2,[]);

%% LDA calculation
X = [grass_vector;straw_vector];
Y = [ones(36,1);-ones(36,1)];
obj = fitcdiscr(X,Y);
lda_projection_s = obj.Coeffs(1,2).Linear;
lda_projection_g = obj.Coeffs(2,1).Linear;

%% Grass and Straw calculation
grass_lda = grass_vector*lda_projection_g;
straw_lda = straw_vector*lda_projection_s;
grass_mean = mean(grass_lda);grass_var = var(grass_lda);
straw_mean = mean(straw_lda);straw_var = var(straw_lda);

%% Unknown vector calculation
for n=1:size(unknown_vector,1)
im = unknown_vector(n,:);
im_lda_g = im*lda_projection_g;
im_lda_s = im*lda_projection_s;
dg_lda = sqrt((im_lda_g-grass_mean)^2/grass_var);
ds_lda = sqrt((im_lda_s-straw_mean)^2/straw_var);
% Recording File Name
lda_s(n).File_Name=unknown_file_names(n).UnknownFileName;

%% Condition for Texture Classification
% Condition for Image Texture Classification
if dg_lda < ds_lda 
    lda_s(n).LDA_Output= 'Grass';
else if ds_lda < dg_lda
           lda_s(n).LDA_Output= 'Straw';
    end
end
end


end

