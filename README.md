# Compartmental-Observability-Approach
All codes are writen in matlab

CVX toolbox for solving convex optimization problems should be added to your matlab in order to use algorithm 1

Instructions:
1- after runnig algorithm1.m, you will get a partition and correspondign welfare. you can evaluate it to determine how close it is to real partition by the same procedure we have done in evaluation.m. The same is true for algorithm2.m.
2- For our paper, we create 1000 stochastic W and b correspondign different games for each three conditions in create_games.m then load the obtained paramethers in simulation.m which implement both algorithm 1 and 2 at the same time to obtain partitions. after that, the results are evaluated in evaluation.m.

issues of algorithm2 implementation:
1-Since there is no well defined solver which solve an optimization problem given semidefinite constraints, we replaced the semidefinite matrix H with X'diag(1/sum(X))*X. 
This expression is actually what we had at the first place that led us to positive definite matrix H. the rows of matrix X represents different agents and the columns represent different subset. if x_{ij}=1 it means that agent i is in set j and the matrix is column stochastic with element either zero or one. ths intuition led us to matrix H which represent the way of partitioning which obtained by H=X'diag(1/sum(X))*X.

2-Since solving optimization given complementarity constraint takes too long to reach the optimum, we assumed that the variables are positive so that we can enter the constraint in objective function. however, the original formulation solution will be not different since in almost all the cases, we have positive variables.
