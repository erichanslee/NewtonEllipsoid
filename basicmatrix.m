function out=basicmatrix(f,m)
if m==0
    out=1;
elseif m==1
    out=diff(f);
else
    M(1,1)=f;
    for i=1:m
        for j=1:m
            M(i,j)=0;
        end
    end
    for j=1:m-1
        for i=1:m
            M(i,i)=diff(f);
            M(i+1,i)=f;
            M(i,i+j)=diff(f,j+1)/factorial(j+1);
        end
    end
    out=M(1:m,1:m);
end
