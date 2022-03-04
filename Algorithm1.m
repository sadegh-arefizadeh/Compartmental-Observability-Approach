%using Algorithm1. to obtain desired partition
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

% you can either create stochastic paramethers or use the saved ones
%% stochastic W
% creating stochastic game
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


%% using saved files
load('W_o_to_3.mat')
% load('W_3_to_6.mat')
% load('W_6_to_9.mat')
z=108;%z can be any integer from 1 to 1000 since 1000 games are made for each condition

W = W_inf{z};
B = b_inf{z};

%computing C using b
C=compute_C(B);
% computing welfare corresponding any given partition
Welfare_partition= @(X)sum((V11(W*nash_compute( W,B,X),n))'-C*nash_compute( W,B,X));

%Algorithm1.
%solving convex optimization problem 
H_convex = compute_convex_( W, B, C);
%using community detection algorithm to obtain partition and calculating
%corresponding welfare
welfare_algorithm_1=Welfare_partition(get_partitiong( H_convex ));


%%
% exhaustive search
%calculating nash equilibrium for each possible partition an the
%corresponding welfare
for q=1:c2
welfare(q)= Welfare_partition(F{q});
end
%%

% sorting all welfares corresponding different partitioning
% this can latter be used to determine how close the achieved partition is to real best partition
[Wo,I]=sort(welfare);

%%

%the results of saved parameters are saved in variable 'welfare' and can be
%achieved by using following codes
% load('welfare_0to3_3.mat')
% load('welfare_3to6_3.mat')
% load('welfare_6to9_3.mat')

%%the output of this code is two variables:welfare_algorithm_1 and Wo which
%%can later be used to evaluate the results
