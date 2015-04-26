## loading the "plyr" package
library(plyr)

## selecting variables and editing the names of the selected variables
features <- read.table("features.txt",header=F,colClasses="character")  # read features.txt
# to select measurements on the mean and standard deviation
selectedfeature <- grepl("mean",features[[2]],fixed=F) | grepl("std",features[[2]],fixed=F) 
# building the names of variable from editing the names of measurements selected previously
variablename <- features[selectedfeature,2]
variablename <- sub("BodyBody","Body",variablename,fixed=T)  # correct the repeated words
variablename <- sub("tBody","timebody",variablename)    # t means time-domain
variablename <- sub("fBody","freqbody",variablename)    # f means frequency
variablename <- sub("tGravity","timegravity",variablename)   # t means time-domain
variablename <- tolower(variablename)    # make all characters lower-case letters
variablename <- sub("\\(\\)","",variablename)   # remove "()"
variablename <- gsub("-","",variablename)    # remove "-"

## building the activity names
activitylabels <- read.table("activity_labels.txt",header=F,colClasses="character") #read activity_labes.txt
activityname <- activitylabels[[2]]
activityname <- tolower(activityname)    # make all characters lower-case letters
activityname <- sub("_","",activityname)   #remove "_"

## data processing

# train set
traindata <- read.table("./train/X_train.txt",header=F)   # read file
traindataselected <- traindata[,selectedfeature]    # select the measurements
trainsubject <- read.table("./train/subject_train.txt",header=F)   # read subject number
trainlabel <- read.table("./train/y_train.txt",header=F)    # read activity number
train <- cbind(trainsubject,trainlabel,traindataselected)   # bind columns

# test set
testdata <- read.table("./test/X_test.txt",header=F)  # read file
testdataselected <- testdata[,selectedfeature]   # select the measurements
testsubject <- read.table("./test/subject_test.txt",header=F)   # read subject number
testlabel <- read.table("./test/y_test.txt",header=F)   # read activity number
test <- cbind(testsubject,testlabel,testdataselected)   # bind columns

# merge two sets
totaldata <- rbind(train,test)
names(totaldata) <- c("subject","activity",variablename)
totaldata$subject <- as.factor(totaldata$subject)
totaldata$activity <- as.factor(totaldata$activity)
levels(totaldata$activity) <- activityname   # change activity numbers to descriptive activity names

## make average data set from the total data set

averagetidy <- ddply(totaldata, .(subject,activity), numcolwise(mean))
names(averagetidy)[3:81] <- paste0("average",names(averagetidy)[3:81])   # change the names of variables

## output

write.table(averagetidy,"average.txt",row.names=F)
