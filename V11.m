function f = V11(wx,n)
%the concave function
% in our paper its notation is S(x) while in original paper it is represented by V(x)
for i=1:n

f(i)=20000*sqrt(wx(i));
% f(i)=(log(wx(i)))*10;
end

end

