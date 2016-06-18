#########################################
#Getting and Cleaning Data Course Project
#########################################

#Read in training data
subjectTrainData  <- read.table("data/train/subject_train.txt")
xTrainData <- read.table("data/train/X_train.txt")
yTrainData <- read.table("data/train/y_train.txt")

#Read in test data
subjectTestData  <- read.table("data/test/subject_test.txt")
xTestData <- read.table("data/test/X_test.txt")
yTestData <- read.table("data/test/y_test.txt")

################################################################
#1. Merges the training and the test sets to create one data set.
################################################################
subjectAllData <- rbind(subjectTrainData, subjectTestData)
xAllData <- rbind(xTrainData, xTestData)
yAllData <- rbind(yTrainData, yTestData)

#########################################################################################
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#########################################################################################

#Read in feature data and give the dataset more descriptive column names
allFeatures <- read.table("data/features.txt")
names(xAllData) <- allFeatures[,2]

#Find relevant feature names and subset x data with those features
relevantFeatures <- grep(".*(mean|std)\\(\\)", allFeatures[,2], perl=TRUE, value=TRUE)
xAllData <- xAllData[,relevantFeatures]

#Clean up x column names
names(xAllData) <- gsub("-std", "SDev", names(xAllData))
names(xAllData) <- gsub("-mean", "Mean", names(xAllData))
names(xAllData) <- gsub("\\(|\\)|-", "", names(xAllData))
names(xAllData) = gsub("^(t)","time",names(xAllData))
names(xAllData) = gsub("^(f)","freq",names(xAllData))

#########################################################################
#3.Uses descriptive activity names to name the activities in the data set
#########################################################################

#Read in activity data and format the activity text
activities <- read.table("data/activity_labels.txt")
activities[,2] = tolower(gsub("_", " ", activities[,2]))

#Change y dataset to have more descriptive text
yAllData[,1] = activities[yAllData[,1],2]

#####################################################################
#4.Appropriately labels the data set with descriptive variable names.
#####################################################################

#Label the data columns w/o labels
names(subjectAllData) <- "subjectID"
names(yAllData) <- "activity"

#Combine the data and write it out
tidyData <- cbind(subjectAllData, yAllData, xAllData)
write.table(tidyData, "tidyData.txt")

################################################################################
#5.From the data set in step 4, creates a second, independent tidy data set with 
#  the average of each variable for each activity and each subject. 
################################################################################

#Create the new dataset with the means grouped by activity and subject
library(plyr)
meanData <- ddply(tidyData, .(subjectID, activity), function(x) colMeans(x[, 3:68]))

#Save to file
write.table(meanData, "meansBySubjectAndActivity.txt")
