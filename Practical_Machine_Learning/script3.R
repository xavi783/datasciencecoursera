library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

ns = c(names(training)[grepl('^IL',names(training))],"diagnosis")
nv = length(ns)

preProc <- preProcess(training[,ns[-nv]],method="pca",thresh=0.8)
trainPC <- predict(preProc,training[,ns[-nv]])
modelFit_pca <- train(training$diagnosis ~ ., method="glm", data=trainPC)
modelFit_raw <- train(training$diagnosis ~ ., method="glm", data=training[,ns[-nv]])

testPC <- predict(preProc,testing[,ns[-nv]])
a = confusionMatrix(testing$diagnosis, predict(modelFit_pca,testPC))
b = confusionMatrix(testing$diagnosis, predict(modelFit_raw,testing[,ns[-nv]]))



