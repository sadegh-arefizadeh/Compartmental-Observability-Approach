# Compartmental-Observability-Approach
All codes are writen in matlab

CVX toolbox for solving convex optimization problems should be added to your matlab in order to use algorithm 1

Instructions:

1- After runnig Algorithm1.m, you will get a partition and corresponding welfare. You also get best and worst welfare which can be used to evaluate the results of Algorithm1. The same is true for Algorithm2.m.

2- For our paper, we create 1000 stochastic W and b in create_games.m corresponding different games for each three conditions which are saved in W_o_to_3.mat, W_3_to_6.mat, and W_6_to_9.mat. Afterwards, we load them algorithm1.m and algorithm2.m to obtain partitions for each set of parameter. The results of both algorithhms for each game in each condition is saved in welfare_0to3_3.mat, welfare_3to6_3.mat, and welfare_6to9_3.mat. After that, these results are evaluated in evaluation.m to obtain median PPO for each condition.


issues of algorithm2 implementation:
1-Since there is no well defined solver which solve an optimization problem given semidefinite constraints, we replaced the semidefinite matrix H with X'diag(1/sum(X))*X. 
This expression is actually what we had at the first place that led us to positive definite matrix H. the rows of matrix X represents different agents and the columns represent different subset. if x_{ij}=1 it means that agent i is in set j and the matrix is column stochastic with element either zero or one. This intuition led us to matrix H which represent the way of partitioning which obtained by H=X'diag(1/sum(X))*X.

2-Since solving optimization given complementarity constraint takes too long to reach the optimum, we assumed that the variables are positive so that we can enter the constraint in objective function. however, the original formulation solution will be not different since in almost all the cases, we have positive variables.
