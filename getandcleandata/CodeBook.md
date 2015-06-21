filename:  CodeBook.md



Description of Script: run_analysis.R
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
Description of Data
-----------------------

Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset. 

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link]


Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Data Set Characteristics:  

Multivariate, Time-Series

Number of Instances:

10299

Area:

Computer

Attribute Characteristics:

N/A

Number of Attributes:

561

Date Donated

2012-12-10

Associated Tasks:

Classification, Clustering

Missing Values?

N/A

Number of Web Hits:

196406


Source:

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws


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
Codes
-----------------------

activitylabel			activity_code
        WALKING			1
        WALKING_UPSTAIRS	2
        WALKING_DOWNSTAIRS	3
        SITTING			4
        STANDING		5
        LAYING			6

subject	
	1-30



Mean and Standard Deviation (std) columns

---------------------------
Data Transformation Process
---------------------------

Apply column headers to the data frame
Combine all datasets into 1 table.  (datasets:  subject, activity test, train)

Exytract std() and mean() from the original datasetReplace Activity codes with Activity labels

---------------------------
Data Details
---------------------------

**For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

**The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

