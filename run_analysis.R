## script to read house energy data and save plot of global active power to file

## library calls
library(tidyr)

## downloads source file from website
## name of file on website
sourcezipfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## name of local zip file
destzipfile <-"getdata_projectfiles_UCI HAR Dataset.zip"
## source files within zip file
trainfile <- "UCI HAR Dataset/train/X_train.txt"
trainlabelfile <- "UCI HAR Dataset/train/y_train.txt"
trainsubjectfile <- "UCI HAR Dataset/train/subject_train.txt"
testfile <- "UCI HAR Dataset/test/X_test.txt"
testlabelfile <- "UCI HAR Dataset/test/y_test.txt"
testsubjectfile <- "UCI HAR Dataset/test/subject_test.txt"
activityfile <- "UCI HAR Dataset/activity_labels.txt"
featuresfile <- "UCI HAR Dataset/features.txt"

## only download if not already downloaded
if(!file.exists(destzipfile)){
	download.file(
		sourcezipfile, 
		destzipfile, 
		method="curl"
	)
}

## unzips train measure file and reads into data table
traindata <- read.fwf(
	unz(destzipfile, trainfile), 
	16
)

## unzips train label file and reads into column of train data table
traindata <- cbind(
	traindata,
	read.table(
		unz(destzipfile, trainlabelfile)
	)
)

## unzips train subject file and reads into column of train data table
traindata <- cbind(
	traindata,
	read.table(
		unz(destzipfile, trainsubjectfile)
	)
)

## unzips test measure file and reads into data table
testdata <- read.fwf(
	unz(destzipfile, testfile), 
	16
)

## unzips test label file and reads into column of test data table
testdata <- cbind(
	testdata,
	read.table(
		unz(destzipfile, testlabelfile)
	)
)

## unzips test subject file and reads into column of test data table
testdata <- cbind(
	testdata,
	read.table(
		unz(destzipfile, testsubjectfile)
	)
)

## unzips activty label file and reads into data table
activitylabeldata <- read.table(
	unz(destzipfile, activityfile)
)

## unzips features file and reads into data table
featuresdata <- read.table(
	unz(destzipfile, featuresfile)
)

## set names of fields and then merge data
names(traindata) <- c("measure", "activity", "subject")
names(testdata) <- c("measure", "activity", "subject")
dataset <- rbind(traindata, testdata)

## lookup factor name for subject
dataset$subject <- featuresdata$V2[match(unlist(dataset$subject), featuresdata$V1)]

## convert to factor and set label for activities
dataset$activity <- as.factor(dataset$activity)
levels(dataset$activity) <- as.character(activitylabeldata$V2)

## extract mean and standard deviation measures
dataset <- dataset[grep("std()|mean()", dataset$subject),]

## calculate mean for each factor
outdata <- aggregate(. ~ activity + subject, dataset, mean)

## save to text
write.table(outdata, file = "tidy dataset.txt", row.name=F)