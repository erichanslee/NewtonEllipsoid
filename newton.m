function p=newton(f,df,init,tol)

while 1
  p=init-f(init)/df(init);
  if abs(p-init)<tol, break; end
  init=p;
end