function out=createcolormap
n=3;
m = 256;
map = zeros(m , 3);
level=floor(256/n);
gradient = linspace(1,0,level)';
map(1:level, 1)= gradient;
map(level+1:2*level, 2)= gradient;
map(2*level+1:3*level, 3)= gradient;
map(level,:)=[0 0 0];
map(255,:)=[0 0 0];
map(256,:)=[0 0 0];
out=map;