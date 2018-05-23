
%% Prepare data
load('Data_Problem1_regression.mat');

rng(1); %for reproducibility
n_units = [10 10];
trainAlg = 'trainbr';
nEpochs = 1000;
maxTime = 30;
numNN = 10;

d1=9;
d2=7;
d3=6;
d4=6;
d5=6;

Tnew = (d1*T1 + d2*T2 + d3*T3 + d4*T4 + d5*T5)/(d1 + d2 + d3 + d4 + d5);

data=[X1,X2,Tnew];

%%nonlinear function

sample_T=  datasample(Tnew,1000);
s_X1 = datasample(X1,1000);
s_X2 = datasample(X2,1000);

X_data=[s_X1,s_X2];


%%neural fit of data_x and s_x1, s_x2
 
%  f = scatteredInterpolant(s_X1,s_X2,sample_T);
%  xlin=linspace(0,1,1000);
%  ylin=linspace(0,1,1000);
%  [x,y] = meshgrid(xlin,ylin);
%  z=f(x,y);
%  mesh(x,y,z)

%%divide into training and test
data_x = [data(:,1)';data(:,2)'];
data_x_seq = con2seq(data_x);
data_y = data(:,3)';
data_y_seq = con2seq(data_y);

data_size = size(data,1);


%% Net parametrization
net=feedforwardnet(n_units,trainAlg);

net.divideFcn = 'divideblock'; % Divide targets into three sets using blocks of indices
net.divideParam.trainRatio = 0.6; % Ratio of targets for training. Default = 0.7.
net.divideParam.valRatio = 0.2; % Ratio of targets for validation. Default = 0.15.
net.divideParam.testRatio = 0.2; % Ratio of targets for testing. Default = 0.15.
net.divideMode = 'time';
net.trainParam.max_fail=10;

net.trainParam.time=maxTime;
net.performFcn = 'mse'; 


net.trainParam.epochs=nEpochs; 

%% Net training

perfs = zeros(1, numNN);
for i = 1:numNN
  [neti,tr] = train(net, data_x_seq, data_y_seq);
  perfs(i) = tr.best_tperf;
  plotperform(tr)
end
meanPerf = sum(perfs)/10;

