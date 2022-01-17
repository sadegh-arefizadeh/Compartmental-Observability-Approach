% using both algorithm 1 and 2 for 1000 different games
clear
clc
n=10;
%creating all possible partitions
P=partitions(n);
[r,c]=size(P);
PN=P';
c2=r;


%%creating matrix F corresponding to partitioning

for i=1:c2
    [r3,c3]=size(PN{1,i});
    for j=1:c3
        f{j}=zeros(1,n);
         [r4,c4]=size(PN{1,i}{1,j});
        for k=1:c4
        f{j}(PN{1,i}{1,j}(k))=1;
        end
    end
    F{i}=zeros(n,n);
    for j=1:c3
    F{i}=F{i}+f{j}'*f{j}/(norm(f{j}'*f{j},inf));
    end
end

%% stochastic W
W_inf = {};
b_inf = {};
% order_percentage=ones(1,games_count);
% value_percentage=ones(1,games_count);

%load build stochastic games
load('03_06_inf','order_percentage','value_percentage','W_inf','b_inf')

% optimization constraints and options
Aeq=zeros(n,n*n);
for i=1:n
    for j=1:n
        Aeq(i,i+(j-1)*n)=1;
    end
end
b=-1*ones(n*n,1)*(1/(10000000*n));
A=-1*eye(n*n);
options = optimoptions('fmincon','Display','iter');
options.MaxFunctionEvaluations = 3000000;
options.MaxIterations=200;
options.OptimalityTolerance=1e-7;
options.Algorithm='interior-point';
H=@(X)X*diag(1./sum(X))*X';
beq=ones(n,1);
load('C:\Users\Sadegh\Desktop\Automatica\welfare_0to3_3.mat')

for z=1:2
z=193;

W = W_inf{z};
B = b_inf{z};
%computing C using b
C=compute_C(B);
% computing welfare corresponding any given partition
Welfare_partition= @(X)sum((V11(W*nash_compute( W,B,X),n))'-C*nash_compute( W,B,X));

%Algorithm1.
%solving convex optimization problem 
H_convex = compute_convex_( W, B, C);
%using community detection algorithm 
welfare_algorithm_1=Welfare_partition(get_partitiong( H_convex ));

%Algorithm2.
x0=eye(n);

Nx = @(X)(eye(n)+((eye(n)-W)*(X*diag(1./sum(X))*X')))*B;
fun_1 = @(X)sum(-(V11(W*Nx(X),n))'+C*Nx(X))-penalty(X);
A_optimal_1 = fmincon(fun_1,x0,A,b,Aeq,beq,[],[],[],options);
A_or_1=reshape(A_optimal_1,[n,n]);
fun_optimal_1=fun_1(A_optimal_1);

H_or_1=H(A_or_1);

% using solution of previous stage as an initial point for 
Nx_or = @(X) inv(eye(n)-((eye(n)-W)*(X*diag(1./sum(X))*X')))*B;
fun = @(X)sum(-(V11(W*Nx_or(X),n))'+C*Nx_or(X))-penalty(X);
 A_optimal = fmincon(fun,x0,A,b,Aeq,beq,[],[],[],options);
A_or=reshape(A_optimal,[n,n]);
fun_optimal=fun(A_optimal);
H_or=H(A_or);   
welfare_algorithm_2=Welfare_partition(get_partitiong( H_or ));

% choosing algorithm 1 result if algorithm 2 is not better
if welfare_algorithm_2<welfare_algorithm_1
    welfare_algorithm_2=welfare_algorithm_1;
end


%%
% exhaustive search
%calculating nash equilibrium for each possible partition an the
%corresponding welfare
for q=1:c2
Nashh_x{q}  = nash_compute( W,B,F{q});
welfare(q)= Welfare_partition(F{q});
end
%%

% sorting all welfares corresponding different partitioning
[Wo,I]=sort(welfare);

%%

welfares{z}={welfare_algorithm_1, welfare_algorithm_2, Wo};

  
end
%saving welfare in welfares_1.mat
save('welfares_1','welfares')
