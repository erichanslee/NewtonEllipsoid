function out = ellipsestep(initial,maxiter, rectboundaries, roots)
%starting variables
counter=0;
initial=transpose(initial);
%% initialize B, the ellipse matrix
B=zeros(2);
r=norm(-rectboundaries*sign(initial)-initial);
B(1,1)=r; B(2,2)=r;


%% start looping
while 1
    [k,j]=min(abs(initial*ones(1,length(roots))-roots));
    %check for convergence
    
    %iterate
    iterdirection = (roots(j)-initial);
    a=[real(iterdirection); imag(iterdirection)];
    
    sol= [real(initial); imag(initial)] - B*a/sqrt((3*transpose(a)*B*a));
    Bprime=4/3*( B - 2*B*a*transpose(B*a)/(3*transpose(a)*B*a));
    
    %ends loop when max number of iterations is reached
    if k < 10^-2
        out=j;  break;
    end
    if counter==maxiter
        %         out=maxiter;
        out=length(initial)+1;
        break;
    end
    
    
    initial=sol(1)+i*sol(2);
    %     display(initial);
    B=Bprime;
    counter=counter+1;
end

