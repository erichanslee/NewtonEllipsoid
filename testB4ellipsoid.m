clear all;

f=@(x) x^3-1; df=@(x) 3*x^2;  ddf=@(x) 6*x; dddf=@(x) 6;
roots=[1, -.5+sqrt(3)/2*i,  -.5-sqrt(3)/2*i];



% f=@(x) x^3-2*x+2; df=@(x) 3*x^2-2;
% roots=[ -1.7693, 0.88465-0.58974*i,  0.88465+0.58974*i] ;

% f=@(x) x^3-3i*x^2-4*x+2i; df=@(x) 3*x^2-6i*x-4;
% roots=[i, i+1, i-1];

maxiter=100; rectboundaries=3;

[m1,m2] = meshgrid(linspace(-4,4,80), linspace(-4,4,80));
guesses = [m1(:) m2(:)];
iters=zeros(length(guesses),1);

for j=1:length(guesses)
    iters(j)=B4ellipse(f,df,ddf,dddf,guesses(j,1) + i*guesses(j,2),maxiter,rectboundaries, roots);
end

m=reshape(iters,size(m1));
colormap(hsv );
imagesc(m)