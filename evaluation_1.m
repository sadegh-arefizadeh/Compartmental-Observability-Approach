clear
clc

% load('welfare_0to3_3.mat')
load('welfare_3to6_3.mat')
% load('welfare_6to9_3.mat')


percentage_convex=zeros(1,1000);
percentage_improvement=zeros(1,1000);


for i=1:1000   
   percentage_convex(i)= (1-((welfares{i}{3}(end)-welfares{i}{1})/(welfares{i}{3}(end)-welfares{i}{3}(1))))*100;
   percentage_improvement(i)=(1-((welfares{i}{3}(end)-welfares{i}{2})/(welfares{i}{3}(end)-welfares{i}{3}(1))))*100;
  
end


median(percentage_convex)
median(percentage_improvement)

