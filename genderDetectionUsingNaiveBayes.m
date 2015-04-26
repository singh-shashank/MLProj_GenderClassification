function accuracy = genderDetectionUsingNaiveBayes(trainingSet,probabilitiesSet)
accuracy=0;
%constants
featureSetsFile = strcat(probabilitiesSet,'_featureSet.txt');
trainingSetFile = strcat(trainingSet,'.txt');
probabilitiesSetFile = strcat(probabilitiesSet,'.txt');
systemCommand = strcat('C:\Python27\pythonw.exe',{' '},'MergeFiles.py',{' '},probabilitiesSet,{' '},trainingSet);

%python script to be executed
[status] = system(systemCommand{:});

%Training
Tweets_pruned = importdata(trainingSetFile);
mfprob = importdata(probabilitiesSetFile);
if ~isempty(mfprob)
probability_words = mfprob.data(:,3);
[numberOfFeatures,~]=size(probability_words);
[sizeOfTrainingSet,~]=size(Tweets_pruned);
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
labels_train= featureSet_temp(:,numberOfFeatures+1);

prob_word_for_female = zeros(sizeOfTrainingSet,numberOfFeatures);
prob_word_for_male=zeros(sizeOfTrainingSet,numberOfFeatures);

fem_prob = mfprob.data(:,1);
male_prob = mfprob.data(:,2);

for i = 1:sizeOfTrainingSet
    prob_word_for_female(i,:) = featureSet(i,:) .* fem_prob';
    prob_word_for_male(i,:) = featureSet(i,:) .* male_prob';
end

countFem=0;
for i=1:sizeOfTrainingSet
    if(labels_train(i,1)==2)
        countFem=countFem+1;
    end
end
femaleProbability=countFem/sizeOfTrainingSet;
maleProbability=1-femaleProbability;
for i = 1:sizeOfTrainingSet
    p_male=1;
    p_female=1;
    for j=1:numberOfFeatures
        if(prob_word_for_female(i,j)>0)
            p_female = p_female*prob_word_for_female(i,j);
        end
        if(prob_word_for_male(i,j)>0)
            p_male = p_male*prob_word_for_male(i,j);
        end
    end
    prob_male(i,1)=p_male;
    prob_female(i,1)=p_female;
end

prob_test_m = prob_male*maleProbability;
prob_test_fm=prob_female*femaleProbability;
labels_test=ones(sizeOfTrainingSet,1);

for i=1:sizeOfTrainingSet
    if prob_test_fm(i,1)>=prob_test_m(i,1)
        labels_test(i,1)=2;
    end
end
countMatch=0;

for j=1:sizeOfTrainingSet
    if labels_test(j,1) == labels_train(j,1)
        countMatch=countMatch+1;
    end
end
accuracy = countMatch/sizeOfTrainingSet
end