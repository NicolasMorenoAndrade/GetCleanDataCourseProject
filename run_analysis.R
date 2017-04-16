library(dplyr)

# Download data if not found in current working directory -----------------
zippedfilename <- "FUCI_HAR_DATASET.zip"
dirname <- "UCI HAR Dataset"
if(!dir.exists(dirname)) {
  if(!file.exists(zippedfilename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = zippedfilename, method="curl")
  }
  unzip(zippedfilename)
}

# Merge data into one data set: fulldataset -------------------------------

#read train data 
trainvalues <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
trainactivity <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
trainsubject <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")

#read test data
testvalues <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
testactivity <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
testsubject <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")

#Bind columns and rows to create one single table
fulldataset <- rbind(cbind(trainsubject, trainvalues, trainactivity), cbind(testsubject, testvalues, testactivity)) 


# Get names for features and activities -----------------------------------

# read features
features <- read.table(file = "./UCI HAR Dataset/features.txt", as.is = TRUE)
names(features) <- c("featureID", "featureName")
# names of features with "mean()" and "std()" names
meanSdMeasurements <- features[grep("mean\\(\\)|std\\(\\)", features$featureName), "featureName"]

# read and prepare activities names table
activities <- read.table(file = "./UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("activityCode", "activityName")


# Descriptive activity names and feature labels ---------------------------

# rename variables of fulldataset 
names(fulldataset) <- c("Subject", features$featureName, "Activity")
#extract only mean() and std() measurments
fulldataset <- fulldataset[, c("Subject", meanSdMeasurements, "Activity")]

# Convert $Activity and $Subject  into factor
fulldataset$Activity <- factor(fulldataset$Activity, levels = activities$activityCode, labels = activities$activityName)
fulldataset$Subject <- as.factor(fulldataset$Subject)

# Extract only the measurements on the mean and standard deviation --------

#summarise by taking the mean of each measurment by subject and activity
fulldatasetMeans <- fulldataset %>% 
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean))

# write out the final table to "tidydataset.txt"
write.table(fulldatasetMeans, "tidydataset.txt", row.names = FALSE, quote = FALSE)

