clc;
clear all;
tic
files = dir('*.raw');
unknown_file_names=struct('UnknownFileName',[]);
NumberOfFiles= length(files);
count1=0;
count2=0;
count3=0;
for i = 1:NumberOfFiles
    a=files(i).name;
    if a(1:2) == 'gr'
        grass_vector(i-count2-count3,1:25)=featureExtract(a);
        count1=count1+1;
    end
    if a(1:2) == 'st'
        straw_vector(i-count1-count3,1:25)=featureExtract(a);
        count2=count2+1;
    end
    if a(1:2) == 'un'
        unknown_vector(i-count1-count2,1:25)=featureExtract(a);
        unknown_file_names(i-count1-count2).UnknownFileName=files(i).name;
        count3=count3+1;
    end
end
save('grass_vector.mat','grass_vector');
save('straw_vector.mat','straw_vector');
save('unknown_vector.mat','unknown_vector');
save('unknown_file_names.mat','unknown_file_names');
t=toc