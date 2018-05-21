%load('threes.mat','-ascii')
%first
mean_3=mean(threes);
%second
[pn,ps1] = mapstd(threes);
cov_3=cov(pn);
[v,d]=eig(cov_3);
Diag=diag(d);
%plot(Diag)
%top 30 eigenvalues in d, eigenvectors in v
[v,d]=eigs(cov_3,30); 

%third

FP.maxfrac = 0.1;

[ptrans,ps2] = processpca(pn, FP);
% transformed inputs
%force2 = ptrans';
%plot(force2(:,:),'.')