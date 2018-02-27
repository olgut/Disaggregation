% Copyright by Olgu Tanriverdi, 02-22-2018
% This script sets up random three contributing inputs to test disintegrate function
clear all;
close all;
n=40;
o=zeros(3,1);
co=[25;60;15];
r1=zeros(3,1);
r2=zeros(3,1);
r3=zeros(3,1);
for i=1:3
    r1(i)=floor(rand()*10)+1;
    o(i)=r1(i)*co(i);
end
struc=zeros(n,3);
strucin=zeros(n,3);
for i=1:3
    r2(i)=min(max(floor(rand()*3*n/4),2),n-2);
    r3(i)=floor((n-r2(i))/2);
    struc(:,i)=[zeros(n-r2(i)-r3(i),1);o(i)*ones(r2(i),1);zeros(r3(i),1)];
    strucin(:,i)=[ones(r2(i),1);zeros(n-r2(i),1)];
end
y=sum(struc,2);
numprofile=size(struc,2);
strucin=[strucin;zeros(1,numprofile)];
struc=[struc;zeros(1,numprofile)];
y=[y;sum(unique(struc))];
[fval, c, yb]=disintegrate(strucin, y);
sum(y-yb)
plot(y(1:end-1));
hold on;
plot(yb(1:end-1),'r');
figure;
plot(struc);
figure;
plot(find(c>0.1),c(find(c>0.1)),'r*');
grid on;




