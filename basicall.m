function out=basicall(var,f,init,tol)
sol=init;
for l=1:40
    for i=1:length(init)
        %starts substituting in values into function
        temp=f;
        for j=1:i-1
            if i==1
            else
                temp=subs(temp,var(j),init(j));
            end
        end
        for k=i+1:length(init)
            if i==length(init)
            else
                temp=subs(temp,var(k),init(k));
            end
        end
        %ends, necessary function is created.
        sol(i)=basicfamilyiter(temp(i),init(i),tol);
        
        init(i)=sol(i);
        
    end
end
out=sol;