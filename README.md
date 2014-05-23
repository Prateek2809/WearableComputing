Wearable Computing 
========================================================

## Introduction
One of the hottest areas of all of Data Science as of this writing is [wearable computing] (http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data explored in this project have been collected from the accelerometers from the Samsung Galaxy S smartphone.

The description of the [Human Activity Recognition Using Smartphones Data Set] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is available from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets.html) and can be downloaded [from here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## What's done here
The purpose of this project is to show how to to collect, clean, and  work with a data set. Concretely, the `run_analysis.R` does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#### Click on `run_analysis.md` above for a quick look at how this is done.

## How the different scripts fit together

- `downloadData.R` Downloads and unzips the data from the above url and stores it in the `current directory for further analysis
- `run_analysis.R` contains the full code and can be run to reproduce the results
- `CodeBook.md` describes the variables, the data, and transformations performed to clean up the data
- `// TODO`

