function [trainV,valV,testV,trainInd,valInd,testInd] = mydivide(allV,trainNum,valNum,testNum)

%% FUNCTION INFO
if ischar(allV)
  switch (allV)
    case 'name'
      trainV = 'User specified ranges';
    case 'fpdefaults'
      defaults = struct;
      defaults.trainNum = 1:10;
      defaults.valNum = 11:20;
      defaults.testNum = 21:30;
      trainV = defaults;
    otherwise
      error('NNET:Arguments','Unrecognized string: %s',allV)
  end
  return
end

%% divide
[allV,mode] = nnpackdata(allV);

testInd = trainNum.testNum;
valInd = trainNum.valNum; 
trainInd = trainNum.trainNum; 

[trainV,valV,testV] = divideind(allV,trainInd,valInd,testInd);


trainV = nnunpackdata(trainV,mode);
valV = nnunpackdata(valV,mode);
testV = nnunpackdata(testV,mode);