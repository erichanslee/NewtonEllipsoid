
clear all;
%% starting information (edit as needed)
f=@(x,y) [x.^3-3*x.*y.^2-1, 3*x.^2.*y-y.^3]; df=@(x,y) [3*x.^2-3*y.^2, 3*x.^2-3*y.^2]; 
% f=@(x,y) [x.^3-3*x.*y.^2-2*x+2, 3*x.^2.*y-y.^3-2*y]; df=@(x,y) [3*x.^2-3*y.^2-2, 3*x.^2-3*y.^2-2]; 
% f=@(x,y) [x.^6-15.*x.^4.*y.^2-2.*x.^3+15.*x.^2.*y.^4+6.*x.*y.^2-y.^6+1, 6.*x.^5.*y-20.*x.^3.*y.^3-6.*x.^2.*y+6.*x.*y.^5+2.*y.^3];
% df=@(x,y) [6.*x.^5-60.*x.^3.*y.^2-6.*x.^2+30.*x.*y.^4+6.*y.^2, 6.*x.^5-60.*x.^3.*y.^2-6.*x.^2+30.*x.*y.^4+6.*y.^2];
root= [1, -.5+sqrt(3)/2*i, -.5-sqrt(3)/2*i];

tol=10^-3; maxiter=20; 
format short
fixedvalue=1;
pixels=200;
boundaries=4;
%% initial variables
[m1,m2] = meshgrid(linspace(-boundaries,boundaries,pixels), linspace(-boundaries,boundaries,pixels));
guesses = m1(:) + (i)*m2(:);
init=[guesses , (fixedvalue)*ones(size(guesses))];
counter=0;
sol=init;
iters=ones(length(guesses),1 ); d=zeros(length(guesses),1);
multiplier = ones(length(guesses),1);
base=[ multiplier 0*multiplier ];
oldx=init; oldy=init;

%% iterate
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

%% multiplying by the multipliers to achieve different colors for roots
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


%% creating the image for preview
m=reshape(iters,size(m1));
createcolormap;

imagesc(m)
