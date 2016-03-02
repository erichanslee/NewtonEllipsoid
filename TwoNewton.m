
function out=TwoNewton(f,J,init)
maxiter=20; iters=0;
%root1=[-1; 0]; root2=[.5; sqrt(3)/2]; root3=[.5; -sqrt(3)/2];
root1= [-1.7693;0]; root2= [0.88465;-0.58974]; root3=[0.88465;+0.58974];
for k=1:maxiter
    
    if det(J(init(1),init(2)))==0
        out=[maxiter 20]; return;
    end
    sol= init-J(init(1),init(2))\f(init(1),init(2));
    if abs(sol(1)-init(1))>10^-4
        iters=iters+1;
    end
    init=sol;
    
end

if norm(sol-root1)<10^-3
out=[iters 2];
elseif norm(sol-root2)<10^-3
out=[iters 12];
elseif norm(sol-root3)<10^-3
out=[iters 16];
else
out=[iters 20];
end