function [C] = compute_C(b)
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


