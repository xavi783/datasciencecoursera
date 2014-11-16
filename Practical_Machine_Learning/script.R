library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

ns = names(training)[-length(names(training))]
featurePlot(x=training[,ns], y=training$CompressiveStrength, plot='pairs')

plot(seq(dim(training)[1]), training$CompressiveStrength)

split = cut(training$CompressiveStrength, breaks=4)