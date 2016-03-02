
clear all;
f=@(x,y) [x.^3-3*x.*y.^2+1, 3*x.^2.*y-y.^3]; df=@(x,y) [3*x.^2-3*y.^2, 3*x.^2-3*y.^2]; tol=10^-3; maxiter=30;
n=20;
format long

[m1,m2] = meshgrid(linspace(-1,1,n), linspace(-1,1,n)); 
guesses = m1(:) + 1*(i)*m2(:); %create initial guesses
root(1)= -1; root(2)=0.5-sqrt(3)/2*i; root(3)=.5+sqrt(3)/2*i;
init=[guesses , (1)*ones(size(guesses))];
counter=0;
sol=init;
iters=ones(length(guesses),1 ); d=zeros(length(guesses),1);
multiplier = ones(length(guesses),1);
base=[ multiplier 0*multiplier ];
oldx=init; oldy=init;
for j=1:maxiter
    if ((counter == 40) && (mod(counter,2)==0))
        indices= iters > 15;
        places=find(indices);
        return;
        for i=1:length(places)
            init(places(i),:)=(init(places(i),:)+oldy(places(i),3:4))/2;
        end
    end
    if mod(counter,2)==0
        %do a newton step with x2 fixed
        
        foo=f(init(:,1),init(:,2)); dfoo = df(init(:,1),init(:,2));
        sol(:,1)= init(:,1)-foo(:,1)./dfoo(:,1);
        
        diff=abs(oldx(:,1:2)-sol);
        for k=1:length(sol)
            d(k) = norm(diff(k,:));
        end
        update=d > tol;
        counter=counter+1; iters=iters+update;
        oldx=[sol oldx(:,1:2)];
        init=sol;
        
    end
    if mod(counter,2)==1
        
        %newton step with x1 fixed
        
        foo=f(init(:,1),init(:,2)); dfoo = df(init(:,1),init(:,2));
        sol(:,2)= init(:,2)-foo(:,2)./dfoo(:,2);
        
        counter=counter+1;
        oldy=[sol oldy(:,1:2)];
        init=sol;
        
        
    end
end
mu=[];foo=zeros(length(sol),length(root));
for i=1:length(root)
    diff=abs(root(i)*base(:,1)-sol(:,1));
    for k=1:length(sol)
        foo(k,i) = norm(diff(k,:));
    end
    mu(:,i)=foo(:,i) < tol;
end


multiplier = mu(:,1)+2*mu(:,2)+mu(:,3);
multiplier(multiplier==1)=16;
iters=iters.*multiplier;
m=reshape(iters,size(m1));
colormap(jet );
imagesc(m)
