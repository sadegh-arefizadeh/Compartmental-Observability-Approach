function [C] = compute_C(b)
% since v'(b)=c, we obtain c from following procedure
syms x;
n=length(b);
c=zeros(n,n);

V=V11(x,1);

D=diff(V);
for i=1:n
    C(i,i)=subs(D, x, b(i));
end  
C=double(C);
end


