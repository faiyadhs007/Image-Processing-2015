%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Oct. 11, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%----------------------------------------------------------%
clc; clear all;
%% Load feature matrices for grass (36x25); straw (36x25); unknown (24x25)
load grass_vector;
load straw_vector;
load unknown_vector;
load unknown_file_names.mat;

%% Calling the output for no feature reduction, PCA and LDA
no_reduction=no_reduction_1a();
pca_reduction=pca_1a();
lda_reduction=lda_1a();

%% Creating a table for the final result
field1='Files_Name';
field2='No_Reduction';
field3='PCA';
field4='LDA';
final_result=struct(field1,{},field2,{},field3,{},field4,{});

%% running the final code
disp('Processing the final output')
disp('...........................')
for i=1:size(unknown_file_names,2)
final_result(i).Files_Name=no_reduction(i).File_Name;
final_result(i).No_Reduction=no_reduction(i).No_Reduction_Output;
final_result(i).PCA=pca_reduction(i).pca_Output;
final_result(i).LDA=lda_reduction(i).LDA_Output;
end
disp('Find your output in final_result_1a.mat')
save('final_result_1a.mat','final_result');