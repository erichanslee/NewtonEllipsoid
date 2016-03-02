function out=iterativemid(f,df,ddf,init, tol)
sol=init; oldx=init; oldy=init;
counter=0;
%hold on; grid on;
while 1
    foo=f(init(1),init(2)); dfoo=df(init(1),init(2)); ddfoo=ddf(init(1),init(2));
    sol(1)= init(1)-(2*foo(1).*dfoo(1))./(2*dfoo(1).^2-foo(1).*ddfoo(1));
%    plot([sol(1) init(1)],[sol(2) init(2)],'-o'); %pause(1);
    if norm(f(sol(1),sol(2))) < tol && counter>0;
       out=[counter, 1];return;
    end
    init=sol; oldx=sol;
    foo=f(init(1),init(2)); dfoo=df(init(1),init(2)); ddfoo=ddf(init(1),init(2));
    sol(2)= init(2)-(2*foo(2).*dfoo(2))./(2*dfoo(2).^2-foo(2).*ddfoo(2));
%     plot([sol(1) init(1)],[sol(2) init(2)],'-o'); %pause(1);
    if norm(f(sol(1),sol(2))) < tol && counter>0;
       out=[counter, 1]; return;
    end
    init=sol; oldy=sol;
    sol(1)=(init(1)-(2*foo(1).*dfoo(1))./(2*dfoo(1).^2-foo(1).*ddfoo(1)));
    sol=(sol+oldx)/2;
%     plot([sol(1) init(1)],[sol(2) init(2)],'r-o'); %pause(1);
    init=sol;
    counter=counter+1;
    if counter > 40
%         fprintf('No Convergence of Method'); 
        out=[40, 1]; return;
    end
end

end