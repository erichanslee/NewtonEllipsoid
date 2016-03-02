

f=@(x,y) [x.^3-3*x.*y.^2-1, 3*x.^2.*y-y.^3]; df=@(x,y) [3*x.^2-3*y.^2, 3*x.^2-3*y.^2]; tol=10^-3; maxiter=20;

format long

[m1,m2] = meshgrid(linspace(-2,2,100), linspace(-2,2,100));
guesses = m1(:) + 1*(i)*m2(:);

init=[guesses , -1*ones(size(guesses))];
counter=0;
sol=init;
iters=ones(length(guesses),1 ); d=zeros(length(guesses),1);
oldx=init; oldy=init;
for j=1:maxiter
    
    if mod(counter,2)==0
        
        %do a newton step with x2 fixed
        
        foo=f(init(:,1),init(:,2)); dfoo = df(init(:,1),init(:,2));
        sol(:,1)= init(:,1)-foo(:,1)./dfoo(:,1);
        
        diff=abs(oldx-sol);
        for k=1:length(sol)
            d(k) = norm(diff(k,:));
        end
        update=d > tol;
        counter=counter+1; iters=iters+update;
        oldx=sol;
        init=sol;
    end
    if mod(counter,2)==1
        
        %newton step with x1 fixed
        
        foo=f(init(:,1),init(:,2)); dfoo = df(init(:,1),init(:,2));
        sol(:,2)= init(:,2)-foo(:,2)./dfoo(:,2);
        
        counter=counter+1;
        init=sol;
    end
end
m=reshape(iters,size(m1));
imagesc(m)
