
imds = imageDatastore('C:\Users\CCF\Desktop\data','IncludeSubfolders',true,'FileExtensions',{'.jpg','.png'});
%while hasdata(imds) 
 %    img = read(imds) ;             % read image from datastore
  %  figure, imshow(img);    % creates a new window for each image
%end
size(img)
numTrainFiles = 10;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
layers = [
    imageInputLayer([1290 3479 1])
    
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
   convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    
    classificationLayer];
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');
trainedNet = trainNetwork(imds,layers,options);
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)



