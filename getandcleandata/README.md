filename:  README.md


Description of Script Name:  run_analysis.R
Created: June 19, 2015

-------------------
Objective of script
-------------------
-Merges the training and the test sets to create one data set.
-Extracts only the measurements on the mean and standard deviation for each measurement. 
-Uses descriptive activity names to name the activities in the data set
-Appropriately labels the data set with descriptive variable names. 
-From the data set in step 4, creates a second, independent tidy data set with the 
 average of each variable for each activity and each subject.

---------------------
File Path Assumptions
---------------------

1.  Test data has been downloaded to path: 				<anypath>/gcd_prj/UCI HAR Dataset/test
2.  Train data has been downloaded to path: 			<anypath>/gcd_prj/UCI HAR Dataset/train
3.  All other data files have been downloaded to path:	<anypath>/gcd_prj/UCI HAR Dataset


------------------------------------------
Text File Created by run_analysis.R Script
------------------------------------------

"prjNum5.txt"	- Output text file with aggregate data created using write.table  
                - This file will get overwritten everytime run_analysis.R script is run, without warning.  
					Move it to another directory or rename it to avoid this.

-------------------
Output Dataset in R
-------------------

dataset_final	- final merged dataset 
				- includes columns:
					subject 
					activity labels
					activity codes
					and all mean and standard deviation columns

aggdata		- average of each variable for each activity and each subject

--------------------------------------------------------
Verify validity of data using the following test scripts
--------------------------------------------------------

dataset_final dataset tests
    nrow(dataset_final)			#total number of rows
    ncol(dataset_final)			#total number of columns
    tail(dataset_final[,1:6])		#view last 6 rows of the first 6 columns
    tail(dataset_final[,83:89])		#view last 6 rows of the last 6 columns
    head(dataset_final[,1:6])		#view first 6 rows of the first 6 columns
    head(dataset_final[,83:89])		#view first 6 rows of the last 6 columns

aggdata	dataset tests
    nrow(aggdata)			#total number of rows
    ncol(aggdata)			#total number of columns
    tail(aggdata[,1:6])			#view last 6 rows of the first 6 columns
    tail(aggdata[,83:89])		#view last 6 rows of the last 6 columns
    head(aggdata[,1:6])			#view first 6 rows of the first 6 columns
    head(aggdata[,83:89])		#view first 6 rows of the last 6 columns
    tail(aggdata[,83:89])
    head(aggdata[,83:89])