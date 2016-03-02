clear all;


%%
%ARGUMENTS:
%1. The function f, its derivative df, and its second derivative ddf
%2. The roots of f, given in an array
%3. The maximum number of iterations
%4. The size of the rectange
%5. The colormap you want
%6. The size of your domain

f=@(x) x^3-1; df=@(x) 3*x^2;  ddf=@(x) 6*x;
roots=[1, -.5+sqrt(3)/2*i,  -.5-sqrt(3)/2*i];
maxiter=60; 
rectboundaries=3;
map = 'bone';
GRIDSIZE = 100;

%%
%function body
[m1,m2] = meshgrid(linspace(-4,4,GRIDSIZE), linspace(-4,4,GRIDSIZE));
guesses = [m1(:) m2(:)];
iters=zeros(length(guesses),1);

for j=1:length(guesses)
    iters(j)=halleyellipse(f,df,ddf,guesses(j,1) + i*guesses(j,2),maxiter,rectboundaries, roots);
end

m=reshape(iters,size(m1));

%%
%Displaying the image
colormap(map);
imagesc(m); 