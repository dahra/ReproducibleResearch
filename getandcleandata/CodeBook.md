CodeBook.md

Script name: run_analysis.R
Created:  June 19, 2015

-----------------------
Objective of Script
-----------------------
Collect, work with, and clean a UCI HAR Dataset data set. 
Prepare tidy data that can be used for later analysis.

-----------------------
Raw Data
-----------------------
--Type of Data
The data linked to from the course website represent data 
collected from the accelerometers from the Samsung Galaxy S smartphone. 

--Description of Data
A full description is available at the site where the data was obtained: 
  
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

--Data location:  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


-----------------------
Script Details
-----------------------

--Extract column names and activities labels

--Extract activities codes and labels 

--Read in data for test, train, subject and activity

    a. Create variables for filepaths
    b. filepaths for subjects data
    c. Read data files into R
	read files for test and train data
	read files for subjects data
	read files for activities data
    d.  Combine/merge data to create 3 datasets in R

--Appropriately label the data set with descriptive variable names--
 
   a. Apply column headers to the data frame
	The 2nd column of colnames is the list of headers for the dataset
	apply column names from column 2 of colnames to merged dataset

--PRJ QUESTION 2.  Extract mean and standard deviation for each measurement.--

   a. Extract for headers names that include the string mean or std 

--PRJ QUESTION 1. 1.  Merges the training and the test sets to create one data set.--

   a. Combine all datasets into 1 table.  (datasets:  subject, activity test, train)

--PRJ QUESTION 3.  Uses descriptive activity names to name the activities in the data set--

   a. Create vector of activity labels based on all rows in column 2 of dataset "datatbl"
   b. Change column name to Activity
   c. Add this vector with activity lables as a new column to the dataset using cbind
   d. Reorder Columns

--PRJ QUESTION 5.  From the data set in step 4, creates a second, independent tidy data set
                   with the average of each variable for each activity and each subject.

   a.  Mean by Activities and Subject
   b.  print data for "PRJ QUESTION 5" to a text file
   c.  Remove what we no longer need

-----------------------
Column Description
-----------------------

Activity labels
        WALKING
        WALKING_UPSTAIRS
        WALKING_DOWNSTAIRS
        SITTING
        STANDING
        LAYING

Mean and Standard Deviation (std) columns

---------------------------
Data Transformation Process
---------------------------

Apply column headers to the data frame
Combine all datasets into 1 table.  (datasets:  subject, activity test, train)

Exytract std() and mean() from the original datasetReplace Activity codes with Activity labels

