function out=cyclicnewton(f,df,init,tol)

sol=init;
counter=0;
%hold on; grid on;view(3);
while 1
    initold=init;
    for j=1:length(init)
        foo=f(init)
        dfoo=df(init)
        sol(j)=init(j) - foo(j)/dfoo(j);
        
        % plot3([init(1) sol(1)],[init(2) sol(2)],[init(3) sol(3)],'-o'); pause(.2);
        counter=counter+1;
        %         if mod(counter,length(init))==0
        %             sol=(initold+sol)/2;
        %         end
        init=sol;
    end
    if norm(initold-sol) < tol;
        %    plot3(sol(1),sol(2),sol(3),'ro');
        out=counter; return;
    end
    if counter>400
        out=400; return;
    end
end
