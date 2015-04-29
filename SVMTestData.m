function [Label_test_original,Label_test_predited,sizeOfTestingSet] = SVMTestData(SVMStruct...
                                                                        ,probabilitiesSet,testingSet)
%Testing Set
testingSetFile = strcat(testingSet,'.txt');
featureSetsFile = strcat(probabilitiesSet,'_featureSet.txt');
probabilitiesSetFile = strcat(probabilitiesSet,'.txt');

systemCommand2 = strcat('C:\Python27\pythonw.exe',{' '},'MergeFiles.py',{' '},probabilitiesSet,{' '},testingSet);
[status2] = system(systemCommand2{:});
Tweets_pruned_Test = importdata(testingSetFile);
mfprob = importdata(probabilitiesSetFile);
probability_words = mfprob.data(:,3);
[numberOfFeatures,~]=size(probability_words);
[sizeOfTestingSet,~]=size(Tweets_pruned_Test);
fid = fopen( featureSetsFile, 'r' ) ;
segsize = numberOfFeatures+1;
featureSet_temp = zeros(sizeOfTestingSet,(segsize));
k=1;
while ~feof(fid)
    currData = fread(fid, segsize);
    if ~isempty(currData)
        A=currData';
        featureSet_temp(k,:)=A;
        k=k+1;
    end
end
featureSet_temp=featureSet_temp - 48;
featureSet = featureSet_temp(:,1:numberOfFeatures);
Label_test_original= featureSet_temp(:,numberOfFeatures+1);
prob_word_for_mf_test = zeros(sizeOfTestingSet,numberOfFeatures);


fem_prob = mfprob.data(:,1);
male_prob = mfprob.data(:,2);
relative_prob = fem_prob./male_prob;

for i = 1:sizeOfTestingSet
    prob_word_for_mf_test(i,:) = featureSet(i,:) .* relative_prob';
end
prob_word_for_mf_test = horzcat(prob_word_for_mf_test,ones(sizeOfTestingSet,1));
Label_test_predited = svmclassify(SVMStruct,prob_word_for_mf_test);