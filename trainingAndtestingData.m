function trainingAndtestingData(trSize)
Data = importdata('combinedTweets.txt');
[sizeData,~]=size(Data);
trainSize = round(trSize * sizeData/100);
for i = 1:trainSize
TrainData{i,1} = Data{i,1};
end
sizeTest = (sizeData-trainSize-1);
for i = 1:sizeTest
TestData{i,1} = Data{i,1};
end
TrainTable=cell2table(TrainData);
TestTable = cell2table(TestData);
writetable(TrainTable(2:trainSize,1),'RawTweetsTraining.txt','Delimiter','\t');
writetable(TestTable(2:sizeTest,1),'RawTweetsTesting.txt','Delimiter','\t');
end