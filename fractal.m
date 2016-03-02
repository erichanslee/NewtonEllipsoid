function [Z,renderMat]=fractal(n,d,l)
%% Z is the n-by-n output of solutions to the equation ((x+i*y)^d)-1=0
%% n is the number of points in the domain.
%% d is the degree of the polynomial
%% l is the length of the real and imaginary axes used.
    clc
    maxIter=20;                % Maximum number of Newton iterations to be done
    cx=0;                      % Center of domain (Real axis)
    cy=0;                      % Center of domain (Imag axis)
    tol = 1e-10;               % Tolerance to determine closeness to 0.0
    x=linspace(cx-l,cx+l,n);   % Real space
    y=linspace(cy-l,cy+l,n);   % Imaginary space
    [X,Y]=meshgrid(x,y);
    Z=X+i*Y;
    
    %% Perform Newton iterations
    for k=1:maxIter;
        Z=Z-(f(Z,d)./fprime(Z,d));
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Plotting the fractal %%
    renderMat=zeros(n,n);          % Matrix to render each root convergence as its own color

    %% Find d roots of unity, and the jth mask
    for j=1:d
        root=exp(2*pi*i/d)^j;     % The jth root of the d roots of unity
        Mj=abs(Z-root);           % Where did Z converge close to root
        mask=(Mj<=tol)*j;         % Each root gets a unique number in [1,d]
        renderMat=renderMat+mask; % Add it to the rendering matrix
    end
    colormap(hsv);     % Set the color map
    imagesc(renderMat) % Render the fractal
    shading flat;      % Turn off grid lines
    axis('square','equal','off');
    imgStr=sprintf('newton_%i_d_%i_L_%i.png', n,d,l);
    titleStr=sprintf('Newton Method: N=%i Tol:%3.2e Deg:%i Len:%i', n,tol,d,l);
    title(titleStr)
    print('-dpng',imgStr)  % Output image to file

end

function y=f(x,d);
    y=(x.^d)-1;
end

function y=fprime(x,d);
    y=d*(x.^(d-1));
end