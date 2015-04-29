%Train Data : Test Data 1:1 (on training data)
Threshold = [0 1 5 10 20 50];
Accuracy1 = [0 52.06 0 0 0 0];
Accuracy2 = [93.07 91.29 66.19 59.95 57.06 52.67];
Accuracy3=[0 0 93.55 94.31 94.99 94.65];
Accuracy4 = [0 60.43 51.99 0 0 0];

figure
plot (Threshold,Accuracy1,'o',...
    Threshold,Accuracy2,'o',...
    Threshold,Accuracy3,'o',...
    Threshold,Accuracy4,'o')
legend('Obscene junk words','Remaining words','Words below threshold','Words with Hashtags','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for Naïve Bayes on Train Data (Train:Test=1:1)')

%Train Data : Test Data 1:1 (on test data)
Threshold = [0 1 5 10 20 50];
Accuracy1 = [0 52.68 0 0 0 0];
Accuracy2 = [63.55 63.14 59.86 57.00 57.00 52.96];
Accuracy3=[0 0 60.38 61.74 62.16 62.51];
Accuracy4 = [0 53.73 52.68 0 0 0];

figure
plot (Threshold,Accuracy1,'o',...
    Threshold,Accuracy2,'o',...
    Threshold,Accuracy3,'o',...
    Threshold,Accuracy4,'o')
legend('Obscene junk words','Remaining words','Words below threshold','Words with Hashtags','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for Naïve Bayes on Test Data (Train:Test=1:1)')

%Train Data : Test Data 4:1 (on train data)
Threshold = [0 1 5 10 20 50];
Accuracy1 = [0 60.06 0 0 0 0];
Accuracy2 = [92.96 91.69 68.77 63.25 60.80 59.93];
Accuracy3=[0 0 93.35 94.36 94.09 93.74];
Accuracy4 = [0 66.58 60.06 0 0 0];

figure
plot (Threshold,Accuracy1,'o',...
    Threshold,Accuracy2,'o',...
    Threshold,Accuracy3,'o',...
    Threshold,Accuracy4,'o')
legend('Obscene junk words','Remaining words','Words below threshold','Words with Hashtags','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for Naïve Bayes on Train Data (Train:Test=4:1)')

%Train Data : Test Data 4:1 (on test data)
Threshold = [0 1 5 10 20 50];
Accuracy1 = [0 52.68 0 0 0 0];
Accuracy2 = [94.32 93.04 75.09 73.99 71.79 71.79];
Accuracy3=[0 0 94.69 95.05 95.05 94.69];
Accuracy4 = [0 76.01 72.34 0 0 0];

figure
plot (Threshold,Accuracy1,'o',...
    Threshold,Accuracy2,'o',...
    Threshold,Accuracy3,'o',...
    Threshold,Accuracy4,'o')
legend('Obscene junk words','Remaining words','Words below threshold','Words with Hashtags','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for Naïve Bayes on Test Data (Train:Test=4:1)')

%For SVM
Threshold = [1 5 10 20];
Accuracy1 = [60.91 60.72 59.94 59.77];
Accuracy2 = [59.38 57.90 60.59 60.88];

figure
plot (Threshold,Accuracy1,'o',Threshold,Accuracy2,'o')
legend('Remaining words','Words below threshold','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for SVM on Train Data (Train:Test=4:1)')

Threshold = [1 5 10 20];
Accuracy1 = [70.70 74.73 73.81 73.99];
Accuracy2 = [66.30 61.54 67.03 65.38];

figure
plot (Threshold,Accuracy1,'o',Threshold,Accuracy2,'o')
legend('Remaining words','Words below threshold','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for SVM on Test Data (Train:Test=4:1)')

Threshold = [1 5 10 20];
Accuracy1 = [62.42 60.77 60.25 59.84];
Accuracy2 = [60.59 60.98 61.40 59.46];

figure
plot (Threshold,Accuracy1,'o',Threshold,Accuracy2,'o')
legend('Remaining words','Words below threshold','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for SVM on Train Data (Train:Test=1:1)')

Threshold = [1 5 10 20];
Accuracy1 = [76.37 73.44 72.71 74.54];
Accuracy2 = [62.82 67.03 69.96 64.47];

figure
plot (Threshold,Accuracy1,'o',Threshold,Accuracy2,'o')
legend('Remaining words','Words below threshold','Location','southeast');
xlabel('Threshold');
ylabel('Accuracy (%)');
title('Accuracy % for SVM on Test Data (Train:Test=1:1)')