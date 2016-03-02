function out=rgbmap()
image(1:256);

R(256,1) = 0;
G(256,1) = 0;
B(128,1) = 0;

dx = 0.8;

for f=0:(1/256):1
    g = (6-2*dx)*f+dx;
    index = int16(f*256 + 1);
    R(index,1) = max(0,(3-abs(g-4)-abs(g-5))/2);
    G(index,1) = max(0,(4-abs(g-2)-abs(g-4))/2); 
    B(index,1) = max(0,(3-abs(g-1)-abs(g-2))/2);

end

%concatenate arrays horizontally
map = horzcat(R, G, B);
out=map;