% Reading the file
row= 321; col = 481;BytesPerPixel = 1;
fileID = fopen('Cougar_GT5.raw');
I = fread(fileID, row*col*BytesPerPixel,'uint8'); 

%% Part 1: Reading the image
I1 = zeros(row,col);
i =1;
for r=1:row
    for c=1:col
        I1(r,c)=I(i,1);
        i=i+1;
    end 
end
Cougar_GT5 = uint8(I1);

% %% Loading the MAT files
% load Farm_GT1.mat; load Farm_GT2.mat;
% load Farm_GT3.mat; load Farm_GT4.mat;
% load Farm_GT5.mat;
% %% Converting to logical
% Farm_GT1 = ~logical(Farm_GT1);
% Farm_GT2 = ~logical(Farm_GT2);
% Farm_GT3 = ~logical(Farm_GT3);
% Farm_GT4 = ~logical(Farm_GT4);
% Farm_GT5 = ~logical(Farm_GT5);
% %% Converting to structure 
% GT1 = struct('Boundaries',{Farm_GT1});
% GT2 = struct('Boundaries',{Farm_GT2});
% GT3 = struct('Boundaries',{Farm_GT3});
% GT4 = struct('Boundaries',{Farm_GT4});
% GT5 = struct('Boundaries',{Farm_GT5});
% groundTruth = {GT1,GT2,GT3,GT4,GT5};