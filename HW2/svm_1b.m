function svm_f = svm_1b()
load train_classifier.mat;
load train_non_classifier1.mat;
load train_non_classifier2.mat;
load train_non_classifier3.mat;
load test_mat.mat;

%% Output Structure
file1='SVA_Output';
svm_f=struct(file1,[]);

%% Training data collection
negative_vector =[train_non_classifier1;train_non_classifier2;train_non_classifier3];
X = [train_classifier;negative_vector];
y = [ones(36,1);-ones(36,1)];
model = svmtrain(y, X,'-t 0');
X_test = test_mat;
y_test = [ones(12,1);-ones(12,1)];
[predicted_label,accuracy, dec_values] = svmpredict(y_test, X_test, model);

%% Final Result
for n=1:size(test_mat,1)
% Recording File Name
% no_red(n).File_Name=test_file_names(n).TestFileName;
if predicted_label(n,1) == 1
    svm_f(n).SVA_Output= 'Yes';
else if predicted_label(n,1) ~= 1
        svm_f(n).SVA_Output= 'No';
    end
end
end
end

