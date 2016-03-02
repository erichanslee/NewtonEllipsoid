clear all;
format long
% f=@(x) x^3-2*x+2; df=@(x) 3*x^2-2; 
% roots=[0.88465+0.58974i,-1.7693,0.884650-0.58974i];

roots = [0];
f=@(x) (x^3-1); df=@(x) (3*x^2);
roots=[ 1, -1/2+sqrt(3)/2*i, -1/2-sqrt(3)/2*i ] ;

% f=@(x) x^3-3i*x^2-4*x+2i; df=@(x) 3*x^2-6i*x-4;
% roots=[i, i+1, i-1];

maxiter=60; rectboundaries=5;

[m1,m2] = meshgrid(linspace(-4,4,100), linspace(-4,4,100));
guesses = [m1(:) m2(:)];
iters=zeros(length(guesses),1);

for j=1:length(guesses)
    iters(j)=ellipsestep(guesses(j,1) + i*guesses(j,2),maxiter,rectboundaries, roots);
end

m=reshape(iters,size(m1));
colormap(hsv );
imagesc(m)