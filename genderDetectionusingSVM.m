function [accuracyTest,accuracyCrossValind] = genderDetectionusingSVM(trainingSet,testingSet,probabilitiesSet)
accuracyTest=0;
accuracyCrossValind=0;
Test_Set_Enabled=1;

featureSetsFile = strcat(probabilitiesSet,'_featureSet.txt');
trainingSetFile = strcat(trainingSet,'.txt');

probabilitiesSetFile = strcat(probabilitiesSet,'.txt');
systemCommand1 = strcat('C:\Python27\pythonw.exe',{' '},'MergeFiles.py',{' '},probabilitiesSet,{' '},trainingSet);

%python script to be executed
[status1] = system(systemCommand1{:});


%Training
Tweets_pruned_Train = importdata(trainingSetFile);

mfprob = importdata(probabilitiesSetFile);

if ~isempty(mfprob)
probability_words = mfprob.data(:,3);
[numberOfFeatures,~]=size(probability_words);
[sizeOfTrainingSet,~]=size(Tweets_pruned_Train);
fid = fopen( featureSetsFile, 'r' ) ;
segsize = numberOfFeatures+1;
featureSet_temp = zeros(sizeOfTrainingSet,(segsize));
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
Label_train= featureSet_temp(:,numberOfFeatures+1);
final_fs_for_mf_train = zeros(sizeOfTrainingSet,numberOfFeatures);

fem_prob = mfprob.data(:,1);
male_prob = mfprob.data(:,2);
relative_prob = fem_prob./male_prob;

for i = 1:sizeOfTrainingSet
    final_fs_for_mf_train(i,:) = featureSet(i,:) .* relative_prob';
end
final_fs_for_mf_train = horzcat(final_fs_for_mf_train,ones(sizeOfTrainingSet,1));

%Cross-Validation
k=10;
cvFolds = crossvalind('Kfold', Label_train, k);

for i = 1:k
Train_index = (cvFolds == i);
Test_index=~Train_index;
Label_Train_CV = Label_train(Train_index);
final_fs_for_mf_train_CV = final_fs_for_mf_train(Train_index,:);
final_fs_for_mf_test_CV = final_fs_for_mf_train(Test_index,:);
SVMStructCV = svmtrain(final_fs_for_mf_train_CV,Label_Train_CV);
Label_Train_predited_CV = svmclassify(SVMStructCV,final_fs_for_mf_test_CV,'Showplot',true);
Label_Test_CV = Label_train(Test_index);
[size_Label_Train,~]=size(Label_Test_CV);
countMatch=0;
for j=1:size_Label_Train
    if Label_Test_CV(j,1) == Label_Train_predited_CV(j,1)
        countMatch=countMatch+1;
    end
end

if accuracyCrossValind < countMatch/size_Label_Train
    accuracyCrossValind = countMatch/size_Label_Train;
    SVMStructTrain = SVMStructCV;
end
end
end
%Testing Set
if Test_Set_Enabled==0
[Label_test_original,Label_test_predited,sizeOfTestingSet] = SVMTestData(SVMStructTrain...
                                                                ,probabilitiesSet,testingSet);
countMatch=0;

for j=1:sizeOfTestingSet
    if Label_test_original(j,1) == Label_test_predited(j,1)
        countMatch=countMatch+1;
    end
end
accuracyTest = countMatch/sizeOfTestingSet;
end
end