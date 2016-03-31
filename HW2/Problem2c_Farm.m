%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Oct. 11, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% Email: fshahid@usc.edu
%------------------------------------------------------------------------%
% Demo for Structured Edge Detector (please see readme.txt first).
clear all; clc;
%% set opts for training (see edgesTrain.m)
opts=edgesTrain();                % default options (good settings)
opts.modelDir='models/';          % model will be in models/forest
opts.modelFnm='modelBsds';        % model name
opts.nPos=5e5; opts.nNeg=5e5;     % decrease to speedup training
opts.useParfor=0;                 % parallelize if sufficient memory

%% train edge detector (~20m/8Gb per tree, proportional to nPos/nNeg)
tic, model=edgesTrain(opts); toc; % will load model if already trained

%% set detection parameters (can set after training)
model.opts.multiscale=1;          % for top accuracy set multiscale=1
model.opts.sharpen=2;             % for top speed set sharpen=0 
model.opts.nTreesEval=4;          % for top speed set nTreesEval=1
model.opts.nThreads=4;            % max number threads for evaluation
model.opts.nms=0;                 % set to true to enable nms

%% evaluate edge detector on BSDS500 (see edgesEval.m)
if(0), edgesEval( model, 'show',1, 'name','' ); end

%% Detect edge and visualize results
row = 321; col =481; BytesPerPixel = 3;
fileID = fopen('Farm.raw');
[I,Red2,Green2,Blue2] = readImage(fileID, row,col, BytesPerPixel);
tic, E=edgesDetect(I,model); toc
figure(1); im(I); figure(2); im(1-E);
B = E;
for r=1:row
    for c =1:col
if E(r,c) > 0.25
    B(r,c) = 1;
else B(r,c) =0;
end
    end
end
figure(3); im(~B);

%% Writing the raw image
new_row = size(E,1);new_col = size(E,2);

for r = 1:new_row
    for c = 1:new_col
        SE_Farm_pe(c,r)=E(r,c);
        SE_Farm_be(c,r)=B(r,c);
    end
end
fid1 = fopen('SE_Farm_pe.raw','w+'); fid2 = fopen('SE_Farm_be.raw','w+');
finalImage1 = fwrite(fid1,im2uint8(1-SE_Farm_pe));
finalImage2 = fwrite(fid2,im2uint8(~SE_Farm_be),'uint8');