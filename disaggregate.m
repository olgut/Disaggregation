% Copyright by Olgu Tanriverdi, 02-22-2018
% The function disintegrates a given signal into three indicidual contributing signals given
% that the profiles of those contributing signals are known. i.e. Magnitude and duration.
function [fval, c, yb]=disintegrate(struc, y)
numprofile=size(struc,2);
lenprofile=size(struc,1);
levelprofile=zeros(numprofile,1);
ite=zeros(numprofile,1);
countprofile=zeros(numprofile,1);
for i=1:numprofile
    levelprofile(i)=max(struc(:,i));
    countprofile(i)=sum(struc(:,i)>0);
    ite(i)=lenprofile-countprofile(i)+1;
end
strucr=struc;
dim=ite(end-1)*(ite(end)+1)+1;
for i=1:numprofile-2
    dim=dim*ite(i);
end
a=zeros(lenprofile,dim);
for i=1:ite(1)
    a(:,((ite(2)*(ite(3)+1)+1)*(i-1)+1))=strucr(:,1);
    strucr(:,2)=struc(:,2);
    for j=1:ite(2)
        a(:,((ite(2)*(ite(3)+1)+1)*(i-1)+1)+(j-1)*ite(3)+j)=strucr(:,2);
        strucr(:,3)=struc(:,3);
        for k=1:ite(3)
            a(:,((ite(2)*(ite(3)+1)+1)*(i-1)+1)+(ite(3)+1)*(j-1)+k+1)=strucr(:,3);
            strucr(:,3)=circshift(strucr(:,3),1);
        end
        strucr(:,2)=circshift(strucr(:,2),1);
    end
    strucr(:,1)=circshift(strucr(:,1),1);
end
lb = zeros(1,dim);
options = optimoptions('intlinprog','RootLPAlgorithm','primal-simplex','Display', 'off') ;
a(end,:)=ones(1,dim);
[c,fval,exitflag,output]= intlinprog(-ones(dim,1),1:dim,[],[],a,y,lb,[],[]);
if exitflag~=1
    display('Exiting due to non-convergent')
    return;
end
fc=find(c>0.1);
d=a(:,fc)*c(fc);
yb=a*c;
end












