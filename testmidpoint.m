clear all;
%z^2-1 system
%f=@(x,y)[x^2-y^2-1;2*x*y];  J=@(x,y)[2*x, -2*y; 2*y, 2*x]; 

%z^3+1 system
f=@(x,y) [x.^3-3*x.*y.^2+1, 3*x.^2.*y-y.^3]; df=@(x,y) [3*x.^2-3*y.^2, 3*x.^2-3*y.^2]; ddf=@(x,y) [6*x,-6*y];

%z^3-2z+2 system
%f=@(x,y) [x.^3-3*x.*y.^2-2*x+2; 3*x.^2.*y-y.^3-2*y]; J=@(x,y) [3*x.^2-3*y.^2-2,-6*x*y; 6*x*y, 3*x.^2-3*y.^2-2]; 
tol=10^-3;
format short

[m1,m2] = meshgrid(linspace(-10,10,500), linspace(-10,10,500));
guesses = [m1(:) m2(:)];
iters=zeros(length(guesses),2);
for i=1:length(guesses)
    iters(i,:)=iterativemid(f,df,ddf, [guesses(i,1); guesses(i,2)], tol);
end
iters(:,1)=iters(:,1).*iters(:,2);
m=reshape(iters(:,1),size(m1));
colormap(jet );
imagesc(m)