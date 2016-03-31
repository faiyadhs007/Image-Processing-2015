clc; clear all;
tic
files = dir('*.raw');
NumberOfFiles= length(files);
count1=0;
count2=0;
count3=0;
count4=0;
for i = 1:NumberOfFiles
    a=files(i).name;
    if a(1:2) == 'gr'
        grass_vector_1b(i-count2-count3-count4,1:25)=featureExtract(a);
        count1=count1+1;
    end
    if a(1:2) == 'le'
        leather_vector_1b(i-count1-count3-count4,1:25)=featureExtract(a);
        count2=count2+1;
    end
    if a(1:2) == 'sa'
        sand_vector_1b(i-count1-count2-count4,1:25)=featureExtract(a);
        count3=count3+1;
    end
    if a(1:2) == 'st'
        straw_vector_1b(i-count1-count2-count3,1:25)=featureExtract(a);
        count4=count4+1;
    end
end
t=toc;
save('grass_vector_1b.mat','grass_vector_1b');
save('leather_vector_1b.mat','leather_vector_1b');
save('sand_vector_1b.mat','sand_vector_1b');
save('straw_vector_1b.mat','straw_vector_1b');