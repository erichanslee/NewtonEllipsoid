Functions must be in the MATLAB format:

f = @(x) x^2
g = @(x,y) [x^2,y^2]

anything with the naming scheme:

"test_______.m"

is an executable that you can run that will calculate the fractal image. Hopefully the suffix is self explanatory

The two executables that are well behaved and documented are "testNewtonellipsoid.m" and "testHalleyellipsoid.m". 
Check those to see how the code operates. 

To print the fractal into a PNG file, you have two choices. You can run "printfrac.m" (which stands for print fractal).
You have to go in and put in your favorite colormap. This will create a PNG with name "image.png" with the colors of your 
choice. A simpler method (but one that gives you lower resolution), is simply saving the outputted image manually. 

*Note 1, anything with the naming scheme "test___ellipsoid___.m" is for the Newton Ellipsoid Method, and anything else is 
for solving Systems of Polynomials

**Note 2, there are a lot of helper functions, modifying them will break all the executables. 

***Note 3, There is a lot of unfinished work from the REU that are lying around... you can run them for fun if you want,
but no guarantees! If you see something not in the format mentioned, it is unfinished work. 