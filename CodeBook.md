# Code Book

This code book gives a brief overview of how the data was processed for the Getting and Cleaning Data Course Project. 

## Source Data

Source data was retrieved from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Source data was unzipped and placed in a folder called data in the R working directory. 

## Variables and Transformations

Most variable names can be found in the features.txt file in the source data referenced above. The features.txt file lists all of the measurements taken. However, some of the variables names were updated a little to make them more readable. The transformations that were run on these variable names were:

* Removed strings "-" and "()" 
* Updated variables that started with "t" to "time"
* Updated variables that started with "f" to "freq"
* Capitalized "mean"
* Changed "std" to "SDev"

Upon merging the source data that contained the subject ID and activity data, column labels were also added to those. These columns labels were added as "subjectID" and "activity".


