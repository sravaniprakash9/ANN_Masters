
%%Load all data from explorer

 A = winequalityred{1:1599,{'fixedacidity','volatileacidity','citricacid','residualsugar','chlorides','freesulfurdioxide','totalsulfurdioxide','density','pH','sulphates','alcohol','quality'}};
 
 X= A(:,1:11);
 T= A(:,12);

 indL = T;
 indL(ismember(indL, 5)) = 4;
 ind_no7 = T ~=7;
 classes_4and6 = indL(ind_no7)';
 
 %%Extract only 4,6
 
 Xnew=X(ind_no7,:)';
 
 transferFcn='tansig';
 nEpochs=1000;
 
%x=Xnew;
%t=classes_4and6;

data_size = size(classes_4and6,2);

net = feedforwardnet(10);

for i = 1:size(net.layers,1)
    net.layers{i}.transferFcn=transferFcn;
end


net.divideFcn = 'divideblock'; % Divide targets into three sets using blocks of indices
net.divideParam.trainRatio = 0.6; % Ratio of targets for training. Default = 0.7.
net.divideParam.valRatio = 0.2; % Ratio of targets for validation. Default = 0.15.
net.divideParam.testRatio = 0.2; % Ratio of targets for testing. Default = 0.15.
net.divideMode = 'time';
net.trainParam.max_fail=10;

net.performFcn = 'mse'; 


net.trainParam.epochs=nEpochs; 

data_x=con2seq(Xnew);
data_y=con2seq(classes_4and6);

%% Net training
  [neti,tr] = train(net, data_x, data_y);
%   y = sim(neti,data_x);
%   
% 
% %%CCR = Number of Correctly classifieddata x 100 / Total number of data
% 
%  % CCR=count(y==data_y)*100/1400
%  
% y_Vec=cell2mat(y);
% y_Vec=round(y_Vec);
% 
% CCR=mean(y_Vec  == classes_4and6) * 100;


%% PCA Variance-0.2
% [x, PS_std] = mapstd(Xnew);
% [Y,PS] = processpca(x,0.02);
% x_restored = processpca('reverse',Y,PS);
% x_restored = mapstd('reverse',x_restored,PS_std);
% error = sqrt(mean(mean((Xnew-x_restored).^2)));
 
[Mx, PS_std] = mapstd(Xnew);
covM = cov(Mx');
[v,d] = eigs(covM,8);
eig_val = diag(d)';
plot(eig_val)

X_pca= v'*Xnew; 

data_x = con2seq(X_pca);
[neti,tr] = train(net, data_x, data_y);
y = sim(neti,data_x);

y_Vec=cell2mat(y);
 y_Vec=round(y_Vec);
% 
 newCCR=mean(y_Vec  == classes_4and6) * 100;