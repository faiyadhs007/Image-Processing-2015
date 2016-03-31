function [image] = nonmaxsupp(image,angle)
% Perform non-max suppression on im orthogonal to theta.  

if numel(angle)==1,
  angle = angle .* ones(size(image));
end

% Basic requirements
mask = ones(size(image));
[height,width] = size(image);
[x,y] = meshgrid(1:width,1:height);
angle = mod(angle+pi/2,pi);

% Determine the pixels for each cases.
angle1 = ( angle>=0 & angle<pi/4 );angle2 = ( angle>=pi/4 & angle<pi/2 );
angle3 = ( angle>=pi/2 & angle<pi*3/4 );angle4 = ( angle>=pi*3/4 & angle<pi);

% case 1
image_dx = find( angle1 & x<width & y<height);
image_A = image_dx + height;
image_B = image_dx + height + 1;
d = tan(angle(image_dx));
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;
% case 2
image_dx = find(angle2 & x<width & y<height );
image_A = image_dx + 1;
image_B = image_dx + height + 1;
d = tan(pi/2-angle(image_dx));
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;
% case 3
image_dx = find(angle3 & x>1 & y<height );
image_A = image_dx + 1;
image_B = image_dx - height + 1;
d = tan(angle(image_dx)-pi/2);
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;
% case 4
image_dx = find(angle4 & x>1 & y<height );
image_A = image_dx - height;
image_B = image_dx - height + 1;
d = tan(pi-angle(image_dx));
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;
% case 5
image_dx = find(angle1 & x>1 & y>1);
image_A = image_dx - height;
image_B = image_dx - height - 1;
d = tan(angle(image_dx));
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;
% case 6
image_dx = find(angle2 & x>1 & y>1 );
image_A = image_dx - 1;
image_B = image_dx - height - 1;
d = tan(pi/2-angle(image_dx));
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;
% case 7
image_dx = find(angle3 & x<width & y>1 );
image_A = image_dx - 1;
image_B = image_dx + height - 1;
d = tan(angle(image_dx)-pi/2);
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;
% case 8
image_dx = find(angle4 & x<width & y>1 );
image_A = image_dx + height;
image_B = image_dx + height - 1;
d = tan(pi-angle(image_dx));
imI = image(image_A).*(1-d) + image(image_B).*d;
mask(image_dx(find(image(image_dx)<imI))) = 0;

% Final output
image = image .* mask;