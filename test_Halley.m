%% Initial Information about starting function
clear all;
f=@(x,y) [x.^3-3*x.*y.^2-1, 3*x.^2.*y-y.^3]; df=@(x,y) [3*x.^2-3*y.^2, 3*x.^2-3*y.^2]; ddf =@(x,y) [6*x,-6*y]; 
% f=@(x,y) [x.^3-3*x.*y.^2-2*x+2, 3*x.^2.*y-y.^3-2*y]; df=@(x,y) [3*x.^2-3*y.^2-2, 3*x.^2-3*y.^2-2]; ddf=@(x,y) [6*x, -6*y];
tol=10^-3; maxiter=20;
format long
root(1)= 1; root(2)=-0.5-sqrt(3)/2*i; root(3)=-.5+sqrt(3)/2*i;
% root(1)= -1.7693; root(2)= 0.88465-0.58974i; root(3)=0.88465+0.58974i;
fixedvalue=i;
%%
[m1,m2] = meshgrid(linspace(-4,4,2000), linspace(-4,4,2000));
guesses = m1(:) + i*m2(:);
init=[guesses , (fixedvalue)*ones(size(guesses))];
counter=0;
sol=init;
iters=ones(length(guesses),1 ); d=zeros(length(guesses),1);
multiplier = ones(length(guesses),1);
base=[ multiplier 0*multiplier ];
oldx=init; oldy=init;

%% Starting iteration 
for j=1:maxiter
    
    if mod(counter,2)==0
        
        %do a newton step with x2 fixed
        
        foo=f(init(:,1),init(:,2)); dfoo = df(init(:,1),init(:,2)); ddfoo=ddf(init(:,1),init(:,2));
        sol(:,1)= init(:,1)-(2*foo(:,1).*dfoo(:,1))./(2*dfoo(:,1).^2-foo(:,1).*ddfoo(:,1));
        
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
        
        foo=f(init(:,1),init(:,2)); dfoo = df(init(:,1),init(:,2)); ddfoo=ddf(init(:,1),init(:,2));
        sol(:,2)= init(:,2)-(2*foo(:,2).*dfoo(:,2))./(2*dfoo(:,2).^2-foo(:,2).*ddfoo(:,2));
        
        counter=counter+1;
        init=sol;
    end
end

%% Inclusion of Multipliers
mu=[];foo=zeros(length(sol),length(root));
for i=1:length(root)
    diff=abs(root(i)*base(:,1)-sol(:,1));
    for k=1:length(sol)
        foo(k,i) = norm(diff(k,:));
    end
    mu(:,i)=foo(:,i) < tol;
end
multiplier = mu(:,1)+2*mu(:,2) + 3*mu(:,3);
% multiplier(multiplier==1)=3;
iters=iters+maxiter*multiplier;

%%
m=reshape(iters,size(m1));
colormap(hsv);
imagesc(m)
