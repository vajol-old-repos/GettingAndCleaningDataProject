## Set/create working directory
setwd("c:/")
if (!file.exists("tmp")) {
  dir.create("tmp")
}
setwd("c:/tmp")

## Download the files. Use temporay file to unzip all the files
tempFile <- tempfile()

## Set URL for download
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = tempFile)

## Load test subjects (30 distinct values in file "subject_test.txt")
testSubjects <- read.table(unz(tempFile, "UCI HAR Dataset/test/subject_test.txt"), header = FALSE, sep = "", na.strings = "")

## Load test activities (6 distinct values in file "y_test.txt")
testActivities <- read.table(unz(tempFile, "UCI HAR Dataset/test/y_test.txt"), header = FALSE, sep = "", na.strings = "")

## Load test features (561 distinct features in file "X_test.txt")  
testFeatures <- read.table(unz(tempFile, "UCI HAR Dataset/test/X_test.txt"), header = FALSE, sep = "", na.strings = "")

## LOad train subjects (30 distinct values in file "subject_train.txt")
trainSubjects <- read.table(unz(tempFile, "UCI HAR Dataset/train/subject_train.txt"), header = FALSE, sep = "", na.strings = "")

## Load train activities (6 distinct values in file "y_train.txt")
trainActivities <- read.table(unz(tempFile, "UCI HAR Dataset/train/y_train.txt"), header = FALSE, sep = "", na.strings = "")

## Load train features (561 distinct features in file "X_train.txt")  
trainFeatures <- read.table(unz(tempFile, "UCI HAR Dataset/train/X_train.txt"), header = FALSE, sep = "", na.strings = "")

## Load features (column names)
columnNames <- read.table(unz(tempFile, "UCI HAR Dataset/features.txt"), header = FALSE, sep = "", na.strings = "")

## Load activity labels file
activityLabels <- read.table(unz(tempFile, "UCI HAR Dataset/activity_labels.txt"), header = FALSE, sep = "", na.strings = "")

## Add column names to activity labels table
names(activityLabels) <- c("activitycode","activityname")

## Convert to character
activityLabels$name <- as.character(activityLabels$name)

## Remove the temp file
unlink(tempFile)

## Document when the files have been downloaded
dateDownloaded <- date()
dateDownloaded

## Add two more column names to the set
featureNames <- c("activitycode", "subjectid", as.character(columnNames[, 2]))

## Remove special signs: "(", ")", "-", ","
featureNames <- gsub(pattern="\\(|\\)|-|,", x=featureNames, replacement="")

## Make variable names stand out by using mixed case
featureNames <- gsub(pattern="std", x=featureNames, replacement="Std")

## Make variable names stand out by using mixed case
featureNames <- gsub(pattern="mean", x=featureNames, replacement="Mean")

## Bind together test data sets: activities + subjects + features
testSet <- cbind(testActivities, testSubjects, testFeatures)

## Bind together train data sets: activities + subjects + features
trainSet <- cbind(trainActivities, trainSubjects, trainFeatures)

## Merge (APPEND) together both data sets: test + train
completeSet <- rbind(testSet, trainSet)

## Add column names to the new data set (using file "features.txt")
names(completeSet) <- featureNames

## Merge activity labesl set with features to produce the complete set with descriptive names for activities
completeSet <- merge(activityLabels,completeSet,by.x="activitycode",by.y="activitycode",all=TRUE)

## Extract only measurements on the mean and standard deviation
stdSet <- completeSet[, grep("std",names(completeSet),ignore.case = TRUE)]
meanSet <- completeSet[, grep("mean",names(completeSet),ignore.case = TRUE)]

## Create final set with columns on the mean and standard deviation, subjects and activities
finalSet <- cbind(completeSet[, c("subjectid", "activitycode", "activityname")], stdSet, meanSet)

## Load lybraries for metling/casting
library(reshape)
library(reshape2)

## Create melted data set with descriptive activity names
meltedSet <- melt(finalSet,id=c("subjectid","activitycode","activityname"))

##Cast the melted dataset according calculating average value for each variable, per subject and activity
avgData <- dcast(meltedSet, subjectid + activitycode + activityname ~ variable, mean)

## Create final data file with the tidy dataset
write.table(avgData,"tidy_human_activity_data.txt")
