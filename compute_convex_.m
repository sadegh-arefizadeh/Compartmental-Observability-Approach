function [ A] = compute_convex_( W, b, C)
B=b;
n=length(W);
welfare_convex=0;
cvx_begin 

variable A(n,n)
% 
L=(eye(n)-W)*A;
Nx_convex=(eye(n)+L)*B;
penalty_convex=0;
myu = 0;
for i =1:n*n
    penalty_convex=penalty_convex+power(A(i),0.5);
end
u_convex=-(V11(W*Nx_convex,n))'+C*Nx_convex;
% u=-(V1(W*A,n))'+C*A;
welfare_convex=sum(u_convex)-myu*penalty_convex;

minimize welfare_convex

subject to 


(A)==semidefinite(n);

sum(A)==ones(1,n);
sum(A')==ones(1,n);

% A'==A;
A>zeros(n,n);
cvx_end


end

