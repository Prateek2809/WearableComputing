###############################################################################
#### 0. Read in the data 
#      Assume the data have been downloaded into the current folder. If not, see
#      `downloadData.R` on how to do this
#
path <- file.path("./", "UCI HAR Dataset")
list.files(path, recursive = TRUE)

# use `data.table` library to read data (instead of `data frames`; it's faster)
library(data.table)

# read the subject files (`subject IDs`):
DT.subject.ID.Train <- fread(file.path(path, "train", "subject_train.txt"))
DT.subject.ID.Test <- fread(file.path(path, "test", "subject_test.txt"))

# the `activity labels` (6 of them; see README):
DT.label.Train <- fread(file.path(path, "train", "Y_train.txt"))
DT.label.Test <- fread(file.path(path, "test", "Y_test.txt"))

# `fread` may fail to read the larger files. Solution: read the text files
# into `data frame`s and convert them to `data table`s.
df <- read.table(file.path(path, "train", "X_train.txt")) #takes a minute
DT.train <- data.table(df)
df <- read.table(file.path(path, "test", "X_test.txt"))   #takes a minute
DT.test <- data.table(df)


###############################################################################
#### 1. Merge the training and the test sets to create one data set.
#
#

# subject IDs:
DT.All.subject.IDs <- rbind(DT.subject.ID.Train, DT.subject.ID.Test)
setnames(DT.All.subject.IDs, "V1", "subject")  #10, 299 total subjects

# labels: 
DT.All.labels <- rbind(DT.label.Train, DT.label.Test)
setnames(DT.All.labels, "V1", "activity.label")

# the `train` and `test` dataset:
DT.Train.and.Test <- rbind(DT.train , DT.test)


# Finally, merge the colums:
DT.All <- cbind(DT.All.subject.IDs, DT.Train.and.Test)
DT.All <- cbind(DT.All, DT.All.labels)
dim(DT.All)
################### good! this is the merged dataset we want ################### 
# We have `10,299` observations and `563` variables in the meged dataset. The 
# first variable in `DT.All` is `subject` (ID) and the last variable is the 
# `activity.label` (a number 1-6 that represents an activity). 
#

###############################################################################
#### 2. Extract only the measurements on the mean and standard deviation for
######  each measurement.
#
# The `features.txt` file lists the names of all features. From these names 
# we will extract the ones that contain `mean` and `std` 
DT.features <- fread(file.path(path, "features.txt"))
setnames(DT.features, names(DT.features), c("feature.number", "feature.name"))
DT.features <- DT.features[grepl("mean\\(\\)|std\\(\\)", feature.name)]
dim(DT.features)   # 66 by 2 - we 
######     #####     ######     #####     ######     #####     ######     #####       


#    Now with each of these features we associate a `feature.code` that matches
#    the column name in the `DT.All` data table.

DT.features$feature.code <- DT.features[, paste0("V", feature.number)]
tail(DT.features)
DT.features$feature.code

##### Set `subject` and `activity.label` as keys:
setkey(DT.All, subject, activity.label)
##### And append the `feature.code` to this. These are the columns that we want
#     to extract from the `data.table`:
the.columns.we.want <- c(key(DT.All), DT.features$feature.code)
result <- DT.All[, the.columns.we.want, with=FALSE]
str(result)

###############################################################################
#### 3. Uses descriptive activity names to name the activities in the data set

# So far, our activity labels were some not-very-informative-to-the-unitiated 
# integers. We now set the more natural names for these 
# labels. `activity_labels.txt` contains such 'natural' names. 
DT.activity.names <- fread(file.path(path, "activity_labels.txt"))
setnames(DT.activity.names, names(DT.activity.names), c("activity.label", "activity.name"))
#DT.activity.names

###############################################################################
#### 4. Appropriately label the data set with descriptive activity names
#
# Now we can merge the `DT.activity.names` `data.table` with the `DT.All` 
# `data.table` by `activity.label`:

DT <- merge(result, DT.activity.names, by = "activity.label", all.x = TRUE)
str(DT)


library(reshape2)
setkey(DT, subject, activity.label, activity.name)
DT <- data.table(melt(DT, key(DT), variable.name = "feature.code"))
DT <- merge(DT, DT.features[, list(feature.number, feature.code, feature.name)], by = "feature.code", 
            all.x = TRUE)

head(DT, n=10); tail(DT, n=10)



###############################################################################
#### 5. Creates a second, independent tidy data set with the average of each 
######  variable for each activity and each subject. 

############## TODO .... PICKUP HERE.... ############


### delete everything in the workspace and just leave DT
l = ls()
rm(list=l[l != "DT"])
rm(l)

### make a copy to experiment
dt <- DT


###################### EXPERIMENTAL

# We will be looking at features. First, make feature.name a factor: 

dt[ ,feature := factor(dt$feature.name)]


#### 1: Is the feature from Time domain or Frequency domain?
levels <- matrix(1:2, nrow=2)
logical <- matrix(c(grepl("^t", dt$feature), grepl("^f", dt$feature)), ncol = 2)
dt$Domain <- factor(logical %*% levels, labels = c("Time", "Freq"))


#### 2: Was the feature measured on Accelerometer or Gyroscope?
levels <- matrix(1:2, nrow=2)
logical <- matrix(c(grepl("Acc", dt$feature), grepl("Gyro", dt$feature)), ncol = 2)
dt$Instrument <- factor(logical %*% levels, labels = c("Accelerometer", "Gyroscope"))


#### 3: Was the Acceleration due to Gravity or Body (other force)?
levels <- matrix(1:2, nrow=2)
logical <- matrix(c(grepl("BodyAcc", dt$feature), grepl("GravityAcc", dt$feature)), ncol = 2)
dt$Acceleration <- factor(logical %*% levels, labels = c(NA, "Body", "Gravity"))


#### 4: The statistics - mean and std?
logical <- matrix(c(grepl("mean()", dt$feature), grepl("std()", dt$feature)), ncol = 2)
dt$Statistic <- factor(logical %*% levels, labels = c("Mean", "SD"))

#### 5, 6: Features on One category - "Jerk", "Magnitude"
dt$Jerk <- factor( grepl("Jerk", dt$feature),labels = c(NA, "Jerk"))
dt$Magnitude <- factor(grepl("Mag", dt$feature), labels = c(NA, "Magnitude"))

#### 7 Axial variables, 3-D:
levels <- matrix(1:3, 3)
logical <- matrix(c(grepl("-X", dt$feature), grepl("-Y", dt$feature), grepl("-Z", dt$feature)), ncol=3)
dt$Axis <- factor(logical %*% levels, labels = c(NA, "X", "Y", "Z"))


################################################################################
################# FINALLY, CREATE A TIDY DATASET #########################

dt[ ,activity :=  factor(dt$activity.name)]
setkey(dt, subject, activity, Domain, Acceleration, Instrument, 
       Jerk, Magnitude, Statistic, Axis)
TIDY <- dt[, list(count = .N, average = mean(value)), by = key(dt)]


key(TIDY)

################# AND SAVE THE THING
f <- file.path(".", "TIDY_HumanActivity.txt")
write.table(TIDY, f, quote = FALSE, sep = "\t", row.names = FALSE)
f <- file.path(".", "TIDY_HumanActivity.csv")
write.csv(TIDY, f, quote = FALSE, row.names = FALSE)
