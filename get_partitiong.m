function [ F ] = get_partitiong( H )
v12=GCLFK(H,1);

 if min(v12)<1
     v12=v12+1;
 end
n=10;
%%
P_or={};
k=ones(n,1);
for z=1:n
P_or{v12(z,1)}(k(v12(z,1)))=z;
k(v12(z,1))=k(v12(z,1))+1;
end


[r3,c3]=size(P_or);
    for j=1:c3
        f{j}=zeros(1,n);
         [r4,c4]=size(P_or{j});
        for k=1:c4
        f{j}(P_or{j}(k))=1;
        end
    end
    F=zeros(n,n);
    for j=1:c3
    F=F+f{j}'*f{j}/(norm(f{j}'*f{j},inf));
    end


end

