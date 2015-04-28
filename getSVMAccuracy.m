clear all;
trainingSet = 'Trainingtweets_without_RT_final_prune';
testingSet = 'Testingtweets_without_RT_final_prune';
probabilitiesSet2 = 'fs_svm_remainingWords_1gm_trng';
probabilitiesSet3='fs_svm_wordsBelowThreshold_1gm_trng';
[accuracyTest1,accuracyCrossValind1] = genderDetectionusingSVM(trainingSet...
                                                    ,testingSet,probabilitiesSet2);
% [accuracyTrain,accuracyTest,accuracyCrossValind] = genderDetectionusingSVM(trainingSet...
%                                                     ,testingSet,probabilitiesSet3);
                                                