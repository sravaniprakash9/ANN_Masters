clear
clc
close all

%%%%%%%%%%%
%algorlm.m
% A script comparing performance of 'trainbr' and 'trainlm'
% trainlm - batch gradient descent 
% trainbr - Levenberg - Marquardt
%%%%%%%%%%%

%generation of examples and targets
x=0:0.05:3*pi;

%Gaussian Noise
y = sin(x.^2);

%Random Noise
% xNoise=rand(1,10,'double');
% yNoise=zeros(1,10);
% 
% for i=1:10
%     yNoise(i)=(xNoise(i).^2);
% end
% 
% x=[xT xNoise];
% y=[yT yNoise];

p=con2seq(x); t=con2seq(y); % convert the data to a useful format



%creation of networks
net1=feedforwardnet(200,'trainbr');


%training and simulation
net1.trainParam.epochs=1;  % set the number of epochs for the training 
net2.trainParam.epochs=1;


%TrainRatio and Test Ratio



net1.divideFcn = 'divideblock'; % Divide targets into three sets using blocks of indices
net1.divideParam.trainRatio = 0.6; % Ratio of targets for training. Default = 0.7.
net1.divideParam.valRatio = 0.2; % Ratio of targets for validation. Default = 0.15.
net1.divideParam.testRatio = 0.2; % Ratio of targets for testing. Default = 0.15.
net1.divideMode = 'time';


net2.divideFcn = 'divideblock'; % Divide targets into three sets using blocks of indices
net2.divideParam.trainRatio = 0.6; % Ratio of targets for training. Default = 0.7.
net2.divideParam.valRatio = 0.2; % Ratio of targets for validation. Default = 0.15.
net2.divideParam.testRatio = 0.2; % Ratio of targets for testing. Default = 0.15.
net2.divideMode = 'time';





[net1, tr1]=train(net1,p,t);   % train the networks
a11=sim(net1,p);   % simulate the networks with the input vtr.best_tperfector p


net1.trainParam.epochs=14;
net1=train(net1,p,t);
a12=sim(net1,p);

net1.trainParam.epochs=985;
net1=train(net1,p,t);
a13=sim(net1,p);


