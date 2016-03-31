%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
row= 636; col = 424;BytesPerPixel = 1;

fileID = fopen('parrot_CFA.raw');
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
I2 = uint8(I1);

I2_big=zeros(row+4,col+4);
for r=1:row
    for c=1:col
        I2_big(r+2,c+2)=I2(r,c);
    end
end
for r=1:row
    for c=1:col
        I2_big(r+2,2)=I2(r,2);  % Left Extension
        I2_big(r+2,1)=I2(r,3);  
        I2_big(r+2,col+3)=I2(r,col-1); % Right Extension
        I2_big(r+2,col+4)=I2(r,col-2); 
        I2_big(1,c+2)=I2(3,c); % Top Extension
        I2_big(2,c+2)=I2(2,c);
        I2_big(row+3,c+2)=I2(row-1,c); %Bottom Extension
        I2_big(row+4,c+2)=I2(row-2,c);
    end
end

I2_big(1:2,1:2)=I2_big(3:4,1:2);
I2_big(row+3:row+4,1:2)=I2_big(row+1:row+2,1:2);
I2_big(1:2,col+3:col+4)=I2_big(3:4,col+3:col+4);
I2_big(row+3:row+4,col+3:col+4)=I2_big(row+1:row+2,col+3:col+4);

%% Part 2: Creating R G B Arrays for the image
I_R = zeros(row+4,col+4);
I_G = zeros(row+4,col+4);
I_B = zeros(row+4,col+4);


for r= 1:row+4
    for c=1:col+4
        if mod(r,2) ~= 0 && mod(c,2) ~= 0
            I_R (r,c)=1;
        else I_R(r,c)=0;
        end
    end
end

for r= 1:row+4
    for c=1:col+4
        if mod(r+c,2) ~= 0 
            I_G (r,c)=1;
        else I_G(r,c)=0;
        end
    end
end

for r= 1:row+4
    for c=1:col+4
        if mod(r,2) == 0 && mod(c,2) == 0
            I_B (r,c)=1;
        else I_B(r,c)=0;
        end
    end
end

for r= 1:row+4
    for c= 1:col+4
        I_R(r,c)= I2_big(r,c)*I_R(r,c);
        I_G(r,c)= I2_big(r,c)*I_G(r,c);
        I_B(r,c)= I2_big(r,c)*I_B(r,c);
    end
end

%% Temporary Red, Green, Blue Channels
I_Rt = I_R;
I_Bt = I_B;
I_Gt = I_G;

%% Necessary parameters for MHC Algorithm
alpha = 1/2; beta = 5/8; gamma = 3/4;

%% Missing Red at Green and Blue Channel
for r= 3:row+2
    for c= 3:col+2     
        if I_R(r,c) == 0
                if mod(r,2) == 0 && mod(c,2) == 0
                    I_R(r,c) = 1/4*(I_R(r-1,c-1)+I_R(r-1,c+1)+I_R(r+1,c-1)+I_R(r+1,c+1));
                    corrected_term_rb = I_Bt(r,c)- 1/4*(I_Bt(r-2,c)+I_Bt(r+2,c)+I_Bt(r,c+2)+I_Bt(r,c-2));
                    I_R(r,c) = I_R(r,c)+ gamma*corrected_term_rb;
                elseif mod(r,2) ==0 && mod(c,2) ~= 2
                        I_R(r,c) = 1/2*(I_R(r-1,c)+I_R(r+1,c));
                        corrected_term_rg1 = I_Gt(r,c) - 1/8*(I_Gt(r-2,c)+I_Gt(r+2,c)+I_Gt(r,c+2)+I_Gt(r,c-2)...
                        + I_Gt(r-1,c-1)+I_Gt(r+1,c-1)+I_Gt(r-1,c+1)+I_Gt(r+1,c+1));
                        I_R(r,c) = I_R(r,c) + beta*corrected_term_rg1;
                    elseif mod(r,2) ~= 0 && mod(c,2) == 0
                        I_R(r,c) = 1/2*(I_R(r,c-1)+I_R(r,c+1));
                        I_R(r,c) = 1/2*(I_R(r-1,c)+I_R(r+1,c));
                        corrected_term_rg2 = I_Gt(r,c) - 1/8*(I_Gt(r-2,c)+I_Gt(r+2,c)+I_Gt(r,c+2)+I_Gt(r,c-2)...
                        + I_Gt(r-1,c-1)+I_Gt(r+1,c-1)+I_Gt(r-1,c+1)+I_Gt(r+1,c+1));
                        I_R(r,c) = I_R(r,c) + beta*corrected_term_rg2;
                end
        end
    end
end

%% Missing Green at Red and Blue Channel
for r= 3:row+2
    for c= 3:col+2 
        if I_G(r,c) == 0
            if mod(r,2) ~= 0 && mod(c,2) ~= 0
                    I_G(r,c) = 1/4*(I_G(r-1,c)+I_G(r+1,c)+I_G(r,c-1)+I_G(r,c+1));
                    corrected_term_gr = I_Rt(r,c)- 1/4*(I_Rt(r-2,c)+I_Rt(r+2,c)+I_Rt(r,c-2)+ I_Rt(r,c+2));
                    I_G(r,c) = I_G(r,c)+ alpha*corrected_term_gr;
                elseif mod(r,2) == 0 && mod(c,2) == 0
                    I_G(r,c) = 1/4*(I_G(r-1,c)+I_G(r+1,c)+I_G(r,c-1)+I_G(r,c+1));  
                    corrected_term_gb = I_Bt(r,c)- 1/4*(I_Bt(r-2,c)+I_Bt(r+2,c)+I_Bt(r,c-2)+ I_Bt(r,c+2));
                    I_G(r,c) = I_G(r,c)+ alpha*corrected_term_gb;
            end
        end
    end
end

%% Missing Blue at Red and Green Channel
for r= 3:row+2
    for c= 3:col+2      
        if I_B(r,c) == 0
                if mod(r,2) ~= 0 && mod(c,2) ~= 0
                    I_B(r,c) = 1/4*(I_B(r-1,c-1)+I_B(r+1,c-1)+I_B(r+1,c-1)+I_B(r+1,c+1));
                    corrected_term_br = I_Rt(r,c)- 1/4*(I_Rt(r-2,c)+I_Rt(r+2,c)+I_Rt(r,c+2)+I_Rt(r,c-2));
                    I_B(r,c) = I_B(r,c)+ gamma*corrected_term_br;
                elseif mod(r,2) ~= 0 && mod(c,2) == 0
                         I_B(r,c) = 1/2*(I_B(r-1,c)+I_B(r-1,c));
                         corrected_term_bg1 = I_Gt(r,c) - 1/8*(I_Gt(r-2,c)+I_Gt(r+2,c)+I_Gt(r,c+2)+I_Gt(r,c-2)...
                        + I_Gt(r-1,c-1)+I_Gt(r+1,c-1)+I_Gt(r-1,c+1)+I_Gt(r+1,c+1));
                        I_B(r,c) = I_B(r,c) + beta*corrected_term_bg1;
                    elseif mod(r,2) == 0 && mod(c,2) ~= 0
                            I_B(r,c) = 1/2*(I_B(r,c-1)+I_B(r,c+1));      
                            corrected_term_bg2 = I_Gt(r,c) - 1/8*(I_Gt(r-2,c)+I_Gt(r+2,c)+I_Gt(r,c+2)+I_Gt(r,c-2)...
                        + I_Gt(r-1,c-1)+I_Gt(r+1,c-1)+I_Gt(r-1,c+1)+I_Gt(r+1,c+1));
                        I_B(r,c) = I_B(r,c) + beta*corrected_term_bg2;
                end
        end
    end
end

I_b = cat(3, uint8(I_R),uint8(I_G), uint8(I_B));
out = I_b(3:638,3:426,1:3);
imshow(out); title('Demosaiced Image using upgraded Bayer filter');
%% Writing the raw image
new_row = size(out,1);new_col = size(out,2);
final = uint8(zeros(new_col,new_row,3));

for k =1:3
    for r = 1:new_col 
        for c = 1:new_row
            final(r,c,k)=out(c,r,k);
        end
    end
end
fid = fopen('solution1c.raw','w+');
finalImage = fwrite(fid,final,'uint8');