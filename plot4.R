##Exploratory Data Analysis
##Project 1
##obj:  Duplicate graphs using "Household Power Consumption" data.

##data files location -
##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip


###########################
#Load Zipped File from url#
###########################

#Create directory for data if it doesn't exist already
if(!file.exists("class_ExplData")) {dir.create("class_ExplData")}

#Create a variable for the url
prj1_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download zipped file into new directory ad temp.zip
download.file(prj1_url, "./class_ExplData/temp.zip", mode="wb")     #wb for binary

#unzip temp.zip files into new directory "class_ExplData"
unzip("./class_ExplData/temp.zip", exdir="./class_ExplData")


#read unzipped data into R format
rdata_prj1 <- read.table("./class_ExplData/household_power_consumption.txt", header=T, sep=";", na.strings="?")

#Record date of download
dateDownloaded <- date()

##CONVERT & SUBSET DATASET TO SHOW ONLY DATA FOR DATES 2007-02-01 and 2007-02-02
##RECALL COLUMN Date is in format dd/mm/yyyy

#Convert Date column to R date format
rdata_prj1$date <- as.Date(rdata_prj1$Date, "%d/%m/%Y") 

#Subset dataset to show only Feb 01-02 data
subset_data <- subset(rdata_prj1, rdata_prj1$date>="2007-02-01" & rdata_prj1$date<="2007-02-02")

#Combine Date field with Time Field
combine_date_time <- paste(subset_data$Date, subset_data$Time)

#Convert Date Time combo to R format for date and time using POSIXct function
#This is done to be able to plot date on graph
date_n_time <- as.POSIXct(strptime(combine_date_time, "%d/%m/%Y %H:%M:%S"))

#retrieve day of week from date column
wkday <- weekdays(as.Date(subset_data$Date, "%d/%m/%Y"),abbreviate=TRUE)

#Create new dataset/table with only rows and columns of interest
newdata <- data.frame(
                        day=wkday, 
                        date_n_time, 
                        gac=as.numeric(as.character(subset_data$Global_active_power)),
                        grac=as.numeric(as.character(subset_data$Global_reactive_power)),
                        vol=as.numeric(as.character(subset_data$Voltage)),
                        gint=as.numeric(as.character(subset_data$Global_intensity)),
                        sub1=as.numeric(as.character(subset_data$Sub_metering_1)),
                        sub2=as.numeric(as.character(subset_data$Sub_metering_2)),
                        sub3=as.numeric(as.character(subset_data$Sub_metering_3))
                      )

#TEST NEWDATA
#nrow(newdata)  #should be 2880
#ncol(newdata)  #should be 9
#head(newdata)  #check 1st 6 rows
#tail(newdata)  #check last 6 rows

##REMOVE WHAT WE NO LONGER NEED
unlink("./class_ExplData/*txt")
unlink("./class_ExplData/*zip")
rm(prj1_url)
rm(rdata_prj1)
rm(subset_data)
rm(combine_date_time)
rm(date_n_time)
rm(wkday)


print("Your R data set is named: newdata")



######################
### CREATE PLOT 1  ###
######################


##Create png file in new directory "class_ExplData"
png("./class_ExplData/plot4.png", width = 480, height = 480)


##Create graph 

#parameters for graphs
par(mfrow=c(2,2))                           #2 graphs per row and col

#par(mfrow=c(2,2), 
#    mar=c(3.1,4.1,2.1,2.1), 
#    oma=c(0,0,2,0))

with(newdata, {
  
##### plot - top left #####

plot(
  y=newdata$gac,                            #y-axis data
  x=newdata$date_n_time,                    #x-axis data
  type="l",
  ylab="Global Active Power",   #y-axis label
  xlab=""                                   #x-axis label is null
)


##### plot - top right #####
plot(
  y=newdata$vol,                            #y-axis data
  x=newdata$date_n_time,                    #x-axis data
  type="l",
  ylab="Voltage",                           #y-axis label
  xlab="datetime"                           #x-axis label 
)

##### plot - bottom left #####


plot(
  x=newdata$date_n_time,                    #x-axis data
  y=newdata$sub1,                           #y-axis data
  type="l",
  ylab="Energy sub metering",               #y-axis label
  xlab=""                                   #x-axis label is null
)

##Add 2 lines to graph
lines(x=newdata$date_n_time,y=newdata$sub2,col="red")
lines(x=newdata$date_n_time,y=newdata$sub3,col="blue")

##Add legend to graph
legend("topright",                                                    #position of legend
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  #legend labels
       col=c("black","red","blue"),                                   #labels color codes
       lty=1,                                                         #denotes the single continuous line
       lwd=2                                                          #line width
)



##### plot - bottom right #####
plot(
  y=newdata$grac,                           #y-axis data
  x=newdata$date_n_time,                    #x-axis data
  type="l",
  ylab="Global_reactive_power",             #y-axis label
  xlab="datetime"                           #x-axis label 
)

##### close "with"  #####

     }     
)         #end of plots

dev.off()


###################################
#########  MY NOTES   #############
###################################
#--------------------------------------------------------
#Calculate approx memory size
#--------------------------------------------------------

#numcols <- 9
#numrows <- 2075259 
#memory_required <- numcols * numrows * 8 #8 bytes/numeric
#"Memory required"
#memory_required


#--------------------------------------------------------
#VERIFY DATA WAS DOWNLOADED AND UNZIPPED PROPERLY
#--------------------------------------------------------

# names(rdata_prj1)
#[1] "Date"                  "Time"                  "Global_active_power"  
#[4] "Global_reactive_power" "Voltage"               "Global_intensity"     
#[7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"       
# ncol(rdata_prj1)
#[1] 9
# nrow(rdata_prj1)
#[1] 2075259


#--------------------------------------------------------
#VIEW DATA
#--------------------------------------------------------

# View(rdata_prj1)



#--------------------------------------------------------
#SUBSETTING DATA#
#--------------------------------------------------------

#The subset( ) function is the easiest way to select variables and observations. In the following example, we select all rows that have a value of age greater than or equal to 20 or age less then 10. We keep the ID and Weight columns.
# using subset function 

#newdata <- subset(mydata, age >= 20 | age < 10, 
#                  select=c(ID, Weight))

#--------------------------------------------------------
#CONVERT CHARACTER TO DATE#
#--------------------------------------------------------

#strDates <- c("1/2/2007", "2/2/2007")
#strDates <- UNIQUE(c(rdata_prj1$Date))
#c_date <- as.Date(strDates,"%d/%m/%Y")