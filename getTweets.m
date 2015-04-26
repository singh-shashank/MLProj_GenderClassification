function getTweets(train)
fileID = fopen('Datasets\LisofCelebritiesArranged.txt');
ListofCelebrities=textscan(fileID,'%s %s');
ListSize=size(ListofCelebrities{1});
Number=ListSize(1,1);
credentials.ConsumerKey = 'Zhkvref6a1hCQeRmBtMOTE97U';
credentials.ConsumerSecret = 'pAzKnbpMXKf5rKrsJPF0KhaSSlg91WKBE1Lda2HGQbpdVD02EK';
credentials.AccessToken = '3091370837-6MBvswZPFQsoLQ9VtL2bkRW28S4HQBxljDWAiyb';
credentials.AccessTokenSecret = 'Jbf5yB7Keq8LA4NXTdt2rggGNdi8nguQbj9LwEMT9kfba';
tw = twitty(credentials);
countTrain=1;
countTest=1;
for i=1:Number
    S = tw.userTimeline('screen_name', ListofCelebrities{1,1}{i});
    jsonData=JSON.parse(S);
    sizeOfJson=size(jsonData);
    sizeOfJson=sizeOfJson(1,2);
    for j=1:sizeOfJson
        if(j<=train)
            TrainData{countTrain,1}=jsonData{1,j}.text;
            TrainData{countTrain,2}=ListofCelebrities{1,2}{i};
            countTrain=countTrain+1;
        else
            TestData{countTest,1}=jsonData{1,j}.text;
            TestData{countTest,2}=ListofCelebrities{1,2}{i};
            countTest=countTest+1;
        end
        
       
        
    end
end
TrainTable=cell2table(TrainData);
TestTable = cell2table(TestData);
writetable(TrainTable,'RawTweetsTraining.txt','Delimiter','\t')
writetable(TestTable,'RawTweetsTesting.txt','Delimiter','\t')
system('copy RawTweetsTraining.txt+RawTweetsTesting.txt combinedTweets.txt')