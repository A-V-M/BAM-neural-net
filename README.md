# BAM-neural-net

Background
==========

Based on bidirectional heteroassociative memory model by Chartier & Boukadoum, 2006.

Free parameters
---------------
**delta**

**epsilon = f(hetta)**

**number of trials**

**number of iterations**

Output
------
**y squared error**

**x squared error**

**W => Y = WX (threshold > 0 first)**

**V => X = VY (threshold > 0 first)**

Example
-------
*X = abs(double(normrnd(0,1,35,5))>0.1);*

*Y = abs(double(normrnd(10,10,2000,5))>3);*

*[y_sq_error x_sq_error W V] = linear_associator(X,Y,0.1,64,0.5,5);*


