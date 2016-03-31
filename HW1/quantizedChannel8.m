%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  channel_out = quantizedChannel8(channel,x_val,avg_1,avg_2,avg_3,avg_4,avg_5,avg_6,avg_7,avg_8)

[row col] =size(channel);
channel_out = double(channel);

for r=1:row
    for c=1:col
        if channel(r,c)>0 && channel(r,c)<x_val(1)
            channel(r,c)=avg_1;
        elseif channel(r,c)>x_val(1)+1 && channel(r,c)<x_val(2)
            channel(r,c)=avg_2;
        elseif channel(r,c)>x_val(2)+1 && channel(r,c)<x_val(3)
            channel(r,c)=avg_3;
        elseif channel(r,c)>x_val(3)+1 && channel(r,c)<x_val(4)
            channel(r,c)=avg_4; 
        elseif channel(r,c)>x_val(4)+1 && channel(r,c)<x_val(5)
            channel(r,c)=avg_5; 
        elseif channel(r,c)>x_val(5)+1 && channel(r,c)<x_val(6)
            channel(r,c)=avg_6; 
        elseif channel(r,c)>x_val(6)+1 && channel(r,c)<x_val(7)
            channel(r,c)=avg_7; 
        elseif channel(r,c)>x_val(7)+1 && channel(r,c)<x_val(8)
            channel(r,c)=avg_8; 
        end
    end
    channel_out = channel;
end

