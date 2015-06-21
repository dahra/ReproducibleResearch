##filename:  run_analysis.R

#The purpose of this project is to 
#collect, work with, and clean a UCI HAR Dataset data set. 
#The goal is to prepare tidy data that can be used for later analysis.

#The data linked to from the course website represent data 
#collected from the accelerometers from the Samsung Galaxy S smartphone. 

#A full description is available at the site where the data was obtained: 
  
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#Here are the data for the project: 
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

################################################
##  READING DATA INTO R AND CREATE DATASETS   ##
################################################

##Extract column names and activities labels

  coltemp <- "gcd_prj/UCI HAR Dataset/features.txt"
  colnames <- read.table(coltemp)

##Extract activities codes and labels 

  acttemp <- "gcd_prj/UCI HAR Dataset/activity_labels.txt"
  actnames <- read.table(acttemp, header=FALSE, col.names=c("activity_code", "activity_label"))

##Read in data for test, train, subject and activity

  ##a. Create variables for filepaths##
 
    #filepaths for test and train data
    testfile <- "gcd_prj/UCI HAR Dataset/test/X_test.txt"
    trainfile <- "gcd_prj/UCI HAR Dataset/train/X_train.txt"

    #filepaths for subjects data
    subjtest <- "gcd_prj/UCI HAR Dataset/test/subject_test.txt"
    subjtrain <- "gcd_prj/UCI HAR Dataset/train/subject_train.txt" 

    #filepaths for activities data
    acttest <- "gcd_prj/UCI HAR Dataset/test/y_test.txt"
    acttrain <- "gcd_prj/UCI HAR Dataset/train/y_train.txt"
  
  ##b. Read data files into R##
  
    #read files for test and train data
    data_test <- read.table(testfile)
    data_train <-  read.table(trainfile)
  
    #read files for subjects data
    subj_test <- read.table(subjtest)
    subj_train <-  read.table(subjtrain)
 
    #read files for activities data
    act_test <- read.table(acttest)
    act_train <- read.table(acttrain)

  ##c.  Combine/merge data to create 3 datasets in R
  
    train_test <- rbind(data_train, data_test)        #combine train and test data  
    subj_train_test <- rbind(subj_train, subj_test)   #combine subject data
    act_train_test <- rbind(act_train, act_test)      #combine activity code and labels data

#######################################################################################
####PRJ QUESTION 4.  Appropriately label the data set with descriptive variable names##
#######################################################################################

##Apply column headers to the data frame
#The 2nd column of colnames is the list of headers for the dataset
#apply column names from column 2 of colnames to merged dataset

names(train_test) = colnames[,2]
names(subj_train_test) = "subject"
names(act_train_test) = "activity_code"

      
##############################################################################
##PRJ QUESTION 2.  Extract mean and standard deviation for each measurement.##
##############################################################################

setwd("gcd_prj/UCI HAR Dataset")

##Extract for headers names that include the string mean or std 
data_meanstdev <- train_test[, grep("(mean|std)", ignore.case = TRUE, names(train_test), value=T)]

#test
#length(data_meanstdev)

#######################################################################################
####PRJ QUESTION 1. 1.  Merges the training and the test sets to create one data set.##
#######################################################################################

##Combine all datasets into 1 table.  (datasets:  subject, activity test, train)

datatbl <- data.frame(subject=subj_train_test, activity_code=act_train_test, data_meanstdev)

###########################################################################################
##PRJ QUESTION 3.  Uses descriptive activity names to name the activities in the data set##
###########################################################################################

##a. Create vector of activity labels based on all rows in column 2 of dataset "datatbl"
    activitylabel <- datatbl[,2]                           #initial vector with column of activities (coded 1-6)
    activitylabel <- gsub(1,"WALKING",activitylabel)              #replace activity code 1 with WALKING
    activitylabel <- gsub(2,"WALKING_UPSTAIRS",activitylabel)     #replace activity code 2 with WALKING_UPSTAIRS
    activitylabel <- gsub(3,"WALKING_DOWNSTAIRS",activitylabel)   #replace activity code 3 with WALKING_DOWNSTAIRS
    activitylabel <- gsub(4,"SITTING",activitylabel)              #replace activity code 4 with SITTING
    activitylabel <- gsub(5,"STANDING",activitylabel)             #replace activity code 5 with STANDING
    activitylabel <- gsub(6,"LAYING",activitylabel)               #replace activity code 6 with LAYING

    #Could have used a loop
    #for i in 1:nrow(act_train_test) {
    #  activitylabel <- gsub(i, act_train_test[i,2],activitylabel)
    #}

##b. Change column name to Activity
names(activitylabel) = "activity_labels"

##c. Add this vector with activity lables as a new column to the dataset using cbind

dataset_final <- cbind(activitylabel, datatbl)

##d. Reorder Columns
dataset_final <- dataset_final[c(2, 1, 3, 4:89)]

    #test
    #nrow(dataset_final)
    #ncol(dataset_final)
    #tail(dataset_final[,1:6])
    #tail(dataset_final[,83:89])
    #head(dataset_final[,1:6])
    #head(dataset_final[,83:89])
###########################################################################################
##PRJ QUESTION 5.  From the data set in step 4, creates a second, independent tidy data set
##                 with the average of each variable for each activity and each subject.
###########################################################################################

##a.  Mean by Activities and Subject

aggdata <-aggregate(dataset_final[,6:89], by=list(activity_code=dataset_final$activity_code, subject=dataset_final$subject),  
                    mean, na.rm=TRUE)

    #test
    #head(aggdata[,1:6])
    #aggdata[,1:6]

##b.  print data for "PRJ QUESTION 5" to a text file
#setwd("C:/Users/dahra/Documents/R/WorkingDirectory")
write.table(aggdata ,file="prjNum5.txt",sep = ",", row.name=FALSE)

##c.  Remove what we no longer need

rm(act_train_test)
rm(acttemp) 
rm(actnames) 
rm(coltemp) 
rm(colnames)
rm(testfile)
rm(trainfile)
rm(subjtest)
rm(subjtrain)
rm(subj_test)
rm(subj_train)
rm(acttest)
rm(acttrain)
rm(data_test)
rm(data_train)
rm(act_test)
rm(act_train)
rm(train_test)
rm(subj_train_test)
rm(activitylabel)
rm(data_meanstdev)
rm(datatbl)


