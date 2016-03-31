%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Oct. 11, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
clc;clear all;
%% Load Data
load grass_vector_1b.mat;
load leather_vector_1b.mat;
load sand_vector_1b.mat;
load straw_vector_1b.mat;

%% Data Formatting
main_mat(:,:,1)= grass_vector;
main_mat(:,:,2)= leather_vector;
main_mat(:,:,3)= sand_vector;
main_mat(:,:,4)= straw_vector;

%% Random Selection of files
r = [1:48];
train_ind_classifier = sort(randperm(48,36));
test_ind_classifier= setdiff(r,train_ind_classifier);
train_ind_nonclassifier= sort(randperm(48,12));
test_ind_nonclassifier= setdiff(r,train_ind_nonclassifier);
test_ind_nonclassifier=test_ind_nonclassifier(1,1:4);

%% User Input
Grass = 1; Leather = 2; Sand = 3; Straw = 4;
user_input= input('Choose one classifier [Grass,Leather,Sand,Straw]: ');
user_set=[1 2 3 4];
non_classifier_set=sort(setdiff(user_set,user_input));

%% Forming Training Matrix
train_mat= main_mat(train_ind_classifier,:,user_input);
for i=1:length(non_classifier_set)
    train_mat(size(train_mat,1)+1:size(train_mat,1)+length(train_ind_nonclassifier),:)= main_mat(train_ind_nonclassifier,:,non_classifier_set(i));
end
train_classifier =train_mat(1:36,:);
train_non_classifier1 =train_mat(37:48,:);
train_non_classifier2 =train_mat(49:60,:);
train_non_classifier3 =train_mat(61:72,:);

%% Forming Test Matrix
test_mat= main_mat(test_ind_classifier,:,user_input);
for i=1:length(non_classifier_set)
    test_mat(size(test_mat,1)+1:size(test_mat,1)+length(test_ind_nonclassifier),:)= main_mat(test_ind_nonclassifier,:,non_classifier_set(i));
end
save('train_classifier.mat','train_classifier');
save('train_non_classifier1.mat','train_non_classifier1');
save('train_non_classifier2.mat','train_non_classifier2');
save('train_non_classifier3.mat','train_non_classifier3');
save('test_mat.mat','test_mat');

%% Creating a table for the final result
field1='Type';
field2='No_Reduction';
field3='PCA';
field4='LDA';
field5 ='SVM';
final_result=struct(field1,{},field2,{},field3,{},field4,{},field5,{});

%% Calling the output for no feature reduction, PCA and LDA
no_reduction=no_reduction_1b();
pca_reduction=pca_1b();
lda_reduction=lda_1b();
svm_prediction = svm_1b();

%% Running the final code
disp('Processing the final output')
disp('...........................')
for i=1:24
final_result(i).No_Reduction=no_reduction(i).No_Reduction_Output;
final_result(i).PCA=pca_reduction(i).pca_Output;
final_result(i).LDA=lda_reduction(i).LDA_Output;
final_result(i).SVM = svm_prediction(i).SVA_Output;
end
disp('Find your output in final_result_1b.mat')
save('final_result_1b.mat','final_result');