# Coursera *Getting and Cleaning Data* course project

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Source the script to create a tidy data set

The script `run_analysis.R` can be sourced to create the tidy data set the project requires. If neccessary, it downloads the source data set and manipulates it in order  to produce the final data set. The script performs the following steps:

- Download all raw data if it is not in the current  the working directory.
- Read data into tables.
- Bind the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to label the activities in the data set.
- Label the data set with descriptive variable names.
- Create a second, independent tidy set with the average of each variable for each activity and each subject.
- Write the tidy data set to the `tidydataset.txt` file.

This script requires the `dplyr` package.
