% since there is not a well defined solver to solve a general nonlinear
% optimization problem given a positive definite constraint, we break down
% the postive definite matrix H into product of three other matrices which
% are X'*diag(1/sum(H))*X 
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
load('C:\Users\Sadegh\Desktop\Automatica\welfare_0to3_3.mat')
load('C:\Users\Sadegh\Desktop\Automatica\W_o_to_3.mat')
z=964; %z can be any integer from 1 to 1000 since 1000 games are made
W = W_inf{z};
B = b_inf{z};
%  any arbitrary stochastic game can be made by this module
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
B=zeros(n,1);
for i=1:n
    B(i)=unifrnd(500,1000);
end



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



%computing C using b
C=compute_C(B);
% computing welfare corresponding any given partition
Welfare_partition= @(X)sum((V11(W*nash_compute( W,B,X),n))'-C*nash_compute( W,B,X));


%Algorithm2.
x0=eye(n);

Nx = @(X)(eye(n)+((eye(n)-W)*(X*diag(1./sum(X))*X')))*B;
fun_1 = @(X)sum(-(V11(W*Nx(X),n))'+C*Nx(X));
A_optimal_1 = fmincon(fun_1,x0,A,b,Aeq,beq,[],[],[],options);
A_or_1=reshape(A_optimal_1,[n,n]);
fun_optimal_1=fun_1(A_optimal_1);

H_or_1=H(A_or_1);

% using solution of previous stage as an initial point for 
Nx_or = @(X) inv(eye(n)-((eye(n)-W)*(X*diag(1./sum(X))*X')))*B;
fun = @(X)sum(-(V11(W*Nx_or(X),n))'+C*Nx_or(X));
 A_optimal = fmincon(fun,x0,A,b,Aeq,beq,[],[],[],options);
A_or=reshape(A_optimal,[n,n]);
fun_optimal=fun(A_optimal);
H_or=H(A_or); 
welfare_algorithm_tmp=Welfare_partition(get_partitiong( H_or_1 ));
welfare_algorithm_2=Welfare_partition(get_partitiong( H_or ));

% choosing algorithm 1 result if algorithm 2 is not better
if welfare_algorithm_2<welfare_algorithm_tmp
    welfare_algorithm_2=welfare_algorithm_tmp;
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