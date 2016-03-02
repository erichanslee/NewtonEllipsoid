function out = newtonellipsoid(f,J,initial,maxiter, rectboundaries, roots)
%starting variables
counter=0;
initial=transpose(initial);
realroots=imag(roots);
%% initialize B, the ellipse matrix
B=zeros(length(initial));
for j=1:length(initial)
    B(j,j)=norm(-rectboundaries(j)*ceil(initial(j)/100000)-initial(j));
end
%% start looping
while 1
    
    %create a, the direcion of iteration
    a=J(initial)\f(initial);
    
    %iterate 
    
    iterate=B*a/(3*sqrt(transpose(a)*B*a));
    sol= initial - iterate;
    Bprime=4/3*( B - 2*B*a*transpose(B*a)/(3*transpose(a)*B*a));
   
    %check for convergence
    if norm(f(sol)) < 10^-1;
%         out = counter; display(sol); break; 
        comp=abs(sol(2)*ones(1,length(realroots))-realroots) < 10^-2;
        out=find(comp)
        break;
    end
    
    %ends loop when max number of iterations is reached
    if counter==maxiter
        out=0; break;
    end
    initial=sol;
    B=Bprime;
    counter=counter+1;
end