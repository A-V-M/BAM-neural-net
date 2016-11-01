%based on bidirectional heteroassociative memory model by
%Chartier & Boukadoum, 2006.

function [y_sq_error x_sq_error W V] = linear_associator(X,Y,delta,output_iter,perc,trial_num)

samples = size(X,2);

X(X == 0) = -1;
Y(Y == 0) = -1;

maxnum = max([size(X,1) size(Y,1)]);

hetta=(1/(2*(1-2*(delta))*maxnum))*perc;

W = zeros(size(Y(:,1)*X(:,1)'));
V = zeros(size(X(:,1)*Y(:,1)'));

Y_ = zeros(size(Y));
X_ = zeros(size(X));

for n=1:trial_num; 
    tic

    for o = 1:output_iter;
    
    W = W + hetta.*((Y*X')+(Y*X_') - (Y_*X') - (Y_*X_'));
        
    V = V + hetta.*((X*Y')+(X*Y_') - (X_*Y') - (X_*Y_'));
    
    alpha = W*X;
    
    Y_(alpha > 1) = 1;
    
    Y_(alpha < -1) = -1;
    
    Y_ = (delta + 1)*alpha - delta*(alpha.^3); 
        
    beta = V*Y;
    
    X_(beta > 1) = 1;
    
    X_(beta < -1) = -1;
    
    X_ = (delta + 1)*beta - delta*(beta.^3);
    
    end
              

Yt = zeros(size(Y));
Xt = zeros(size(X));

A=W*X;

     
    Yt = (delta + 1)*A - delta*(A.^3);
    Yt(A > 1) = 1; 
    Yt(A < -1) = -1;

B=V*Y;

    Xt = (delta + 1)*B - delta*(B.^3);
    Xt(B > 1) = 1; 
    Xt(B < -1) = -1; 


    Xt(Xt > 0) = 1;
    Xt(Xt < 0) = -1;
    
    Yt(Yt > 0) = 1;
    Yt(Yt < 0) = -1;
      
   y_sq_error(n) = mean((abs(sum(Y - Yt))./size(Y,1)));    
   x_sq_error(n) = mean((abs(sum(X - Xt))./size(X,1)));   
   
   y_corr(n) = mean(diag(corr(Yt,Y)));
   x_corr(n) = mean(diag(corr(Xt,X)));
   
   eT=toc;
   
   fprintf(1,'%d Y [sq error]: %6.2f | X [sq error]: %6.2f | Y*Y'' corr: %5.2f | X*X'' corr: %5.2f (%5.2f secs)\n',n, y_sq_error(n), x_sq_error(n), y_corr(n), x_corr(n),eT)
  
if (y_sq_error(n) < 0.01 && x_sq_error(n) < 0.01); break; end

end

