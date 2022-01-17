clear
clc
% load('C:\Users\Sadegh\Desktop\Automatica\welfare_6to9.mat')
% load('C:\Users\Sadegh\Desktop\Automatica\welfare_3to6_asli.mat')
% load('C:\Users\Sadegh\Desktop\Automatica\welfare_0to3_2.mat')
% load('C:\Users\Sadegh\Desktop\Automatica\welfare_0to3_3.mat')
load('C:\Users\Sadegh\Desktop\Automatica\welfare_3to6_3.mat')
r = length(welfares{1}{4});
welfare_avali=zeros(1,1000);
welfare_dovomi=zeros(1,1000);
welfare_sevomi=zeros(1,1000);
percentage_avali=zeros(1,1000);
percentage_dovomi=zeros(1,1000);
percentage_sevomi=zeros(1,1000);
for i=1:1000
    if i~=609
   welfare_avali(i)= welfares{i}{1};
   welfare_dovomi(i)= welfares{i}{2};
   welfare_sevomi(i)= welfares{i}{3};
   order_percentage_avali(i) = 100*find(welfares{i}{4} == welfare_avali(i))/r;
   order_percentage_dovomi(i) = 100*find(welfares{i}{4} == welfare_dovomi(i))/r;
   order_percentage_sevomi(i) = 100*find(welfares{i}{4} == welfare_sevomi(i))/r;
   percentage_avali(i)= (1-((welfares{i}{4}(end)-welfares{i}{1})/(welfares{i}{4}(end)-welfares{i}{4}(1))))*100;
   percentage_dovomi(i)=(1-((welfares{i}{4}(end)-welfares{i}{2})/(welfares{i}{4}(end)-welfares{i}{4}(1))))*100;
   percentage_sevomi(i)= (1-((welfares{i}{4}(end)-welfares{i}{3})/(welfares{i}{4}(end)-welfares{i}{4}(1))))*100;
    end 

end
%%
A=welfare_sevomi~=welfare_avali;
 B=percentage_dovomi<percentage_avali;
 percentage_dovomi_edited=percentage_dovomi;
 order_percentage_dovomi_edited=order_percentage_dovomi;
 percentage_dovomi_edited(B) = percentage_avali(B);
 order_percentage_dovomi_edited(B) = order_percentage_avali(B);
 
%%
clc
mean(percentage_sevomi)
mean(percentage_dovomi_edited)
mean(order_percentage_sevomi)
mean(order_percentage_dovomi_edited)
