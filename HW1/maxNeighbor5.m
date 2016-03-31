%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 569 Homework #1
% Date: Sept. 20, 2015
% Name: Faiyadh Shahid
% ID: 4054-4699-70
% e-mail: fshahid@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function max_numb= maxNeighbor5(row_matrix)

a=row_matrix;
count=0;
for i=1:25
    for j=1:25
        if a(1,i)==a(1,j)
            count=count+1;
        end
    end
    a(2,i)=count;
    count=0;
end
max1=max(a(2,:));
for i=1:25
    if a(2,i)==max1
        max_numb=a(1,i);
    end
end


end

