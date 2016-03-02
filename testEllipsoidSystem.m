

f=@(x) [x(1)^3-3*x(1)*x(2)^2-1; 3*x(1)^2*x(2)-x(2)^3];
J=@(x) [3*x(1)^2-3*x(2)^2, -6*x(1)*x(2); 6*x(1)*x(2),3*x(1)^2-3*x(2)^2];

maxiter=50; rectboundaries=[5,5];
roots=[1, -.5+sqrt(3)/2*i,  -.5-sqrt(3)/2*i];
[m1,m2] = meshgrid(linspace(-4,4,1000), linspace(-4,4,1000));
guesses = [m1(:) m2(:)];
iters=zeros(length(guesses),1);

for j=1:length(guesses)
    iters(j)=newtonellipsoid(f,J,[guesses(j,1) , guesses(j,2)],maxiter,rectboundaries, roots);
end

m=reshape(iters,size(m1));
colormap(jet );
imagesc(m)