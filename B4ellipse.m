function out = B4ellipse(f,df,ddf,dddf,initial,maxiter, rectboundaries, roots)
%starting variables
counter=0;
initial=transpose(initial);
%% initialize B, the ellipse matrix
B=zeros(2);
r=norm(-rectboundaries*sign(initial)-initial);
B(1,1)=r; B(2,2)=r;


%% start looping
while 1
    
    %check for convergence
    if norm(f(initial)) < 0.89^maxiter
%         out=counter; break;
        comp=abs(initial*ones(1,length(roots))-roots) < 10^-2;
        out=find(comp); break;
    end
    

    %iterate
    iterdirection=(6*f(initial)*df(initial)^2-3*f(initial)^2*ddf(initial))/(f(initial)^2*dddf(initial)+6*df(initial)^3-6*f(initial)*df(initial)*ddf(initial));
    
    %alpha tuning parameter
    alpha = 1;
    a=alpha * [real(iterdirection) ; imag(iterdirection)];
    sol= [real(initial); imag(initial)] - B*a/sqrt((3*transpose(a)*B*a));
    Bprime=4/3*( B - 2*B*a*transpose(B*a)/(3*transpose(a)*B*a));
    
    %ends loop when max number of iterations is reached
    if counter==maxiter
%         out=maxiter;
        out=0; 
        break;
    end
    
    
    initial=sol(1)+i*sol(2);
%     display(initial);
    B=Bprime;
    counter=counter+1;
end