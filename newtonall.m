function out=newtonall(f,df,init,tol)

sol=init;
counter=0; innercounter=0;
hold on; grid on; view(3);
while 1
    for i=1:length(init)
        while 1
            foo=f(init); dfoo=df(init);
            sol(i)=init(i) - foo(i)/dfoo(i);
            if norm(sol(i)-init(i)) < tol && innercounter>0;
                break;
            end
            if norm(f(sol)) < tol && counter>0;
                plot3(sol(1),sol(2),sol(3),'ro');
                out=sol; display(counter);return;
            end
            plot3([init(1) sol(1)],[init(2) sol(2)],[init(3) sol(3)],'-o'); pause(.2);
            init=sol
            innercounter=innercounter+1
            if innercounter >20
                break;
            end
        end
        counter=counter+1;
    end
    if counter>600
        out=600; return;
    end
end