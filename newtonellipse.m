function out = newtonellipse(f,df,initial,maxiter, rectboundaries, roots)
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
    if norm(f(initial)) < 10^-2
%         out=counter; break;
        comp=(abs(initial*ones(1,length(roots))-roots) < 10^-2);
        out=find(comp); break;
    end
    

    %iterate
    iterdirection=f(initial)/df(initial);
    a=[real(iterdirection) ; imag(iterdirection)];
    sol= [real(initial); imag(initial)] - B*a/sqrt((3*transpose(a)*B*a));
    Bprime=4/3*( B - 2*B*a*transpose(B*a)/(3*transpose(a)*B*a));
    
    %ends loop when max number of iterations is reached
    if counter==maxiter
%         out=maxiter;
        out=0; 
        break;
    end
    
    
    initial=sol(1)+1i*sol(2);
%     display(initial);
    B=Bprime;
    counter=counter+1;
end

