clear
clc

% load('welfare_0to3_3.mat')
% load('welfare_3to6_3.mat')
load('welfare_6to9_3.mat')

percentage_convex=zeros(1,1000);
percentage_improvement=zeros(1,1000);

%welfares{i}{3}(end) is the maximum and welfares{i}{3}(1) is minimum welfare

for i=1:1000   
   PPO_algorithm_1(i)= (1-((welfares{i}{3}(end)-welfares{i}{1})/(welfares{i}{3}(end)-welfares{i}{3}(1))));
   PPO_algorithm_2(i)=(1-((welfares{i}{3}(end)-welfares{i}{2})/(welfares{i}{3}(end)-welfares{i}{3}(1))));
end

median(PPO_algorithm_1)
median(PPO_algorithm_2)
