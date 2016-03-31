load Cougar_GT1.mat; load Cougar_GT2.mat;
load Cougar_GT3.mat; load Cougar_GT4.mat;
load Cougar_GT5.mat;
% Converting to logical
Cougar_GT1 = logical(Cougar_GT1);
Cougar_GT2 = logical(Cougar_GT2);
Cougar_GT3 = logical(Cougar_GT3);
Cougar_GT4 = logical(Cougar_GT4);
Cougar_GT5 = logical(Cougar_GT5);
% Converting to structure 
GT1 = struct('Boundaries',{Cougar_GT1});
GT2 = struct('Boundaries',{Cougar_GT2});
GT3 = struct('Boundaries',{Cougar_GT3});
GT4 = struct('Boundaries',{Cougar_GT4});
GT5 = struct('Boundaries',{Cougar_GT5});
groundTruth = {GT1,GT2,GT3,GT4,GT5};