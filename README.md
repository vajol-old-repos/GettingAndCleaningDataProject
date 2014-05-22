Getting And Cleaning Data Project
=================================

Human Activity Recognition Using Smartphones Analysis
-----------------------------------------------------

The R Script "run_analysis.R" uses the data from the "Human Activity Recognition Using Smartphones Data Set" and produces a new, tidy dataset, which is then used for further analysis. 

Previously mentioned data set, can be found by using this url:

[Human Activity Recognition Data Set] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


How the script "run_analysis.R" works
-------------------------------------

Here is a list of steps (operations and transformations) performed on the raw data sets:

- Download two sets (test and train) of files by using a temporary file to unzip all the files
- Download features (column names) and activity labels files
- Load all files into program variables
- Add column names to activity labels table
- Convert factor values to character for easier manipulation
- Document when the files have been downloaded
- Remove special signs from column names
- Make variable names stand out by using mixed case
- Bind together test data sets: activities + subjects + features
- Bind together train data sets: activities + subjects + features
- Merge (APPEND) together both data sets: test + train
- Add column names to the new data set (using file "features.txt")
- Merge activity labels set with features to produce the complete set with descriptive names for activities
- Extract only measurements on the mean and standard deviation
- Bind together and create final set with columns on the mean and standard deviation, subjects and activities
- Create melted data set with descriptive activity names
- Cast the melted dataset according calculating average value for each variable, per subject and activity
- Create final data file with the tidy dataset

