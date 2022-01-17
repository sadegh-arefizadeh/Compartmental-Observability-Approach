clc
clear
 n=10;
for z=1:1000
   
W=zeros(n,n);
for i=1:n
for j=1:n
    W(i,j)=rand;
    W(i,j)= W(i,j)*randsample([-1 1],1);%%defining 
end
W(i,i)=0;
W(i,:)=unifrnd( 0.6, 0.9 )*W(i,:)/(sum(abs(W(i,:))));
W(i,i)=1;
end
b=zeros(n,1);
for i=1:n
    b(i)=unifrnd(500,1000);
end
W_inf{z}=W;
b_inf{z}=b;
end
save('W_6_to_9','b_inf','W_inf')