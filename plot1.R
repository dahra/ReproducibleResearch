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
rdata_prj1 <- read.table("./class_ExplData/household_power_consumption.txt", header=T, sep=";")

#Record date of download
dateDownloaded <- date()

##SUBSET DATASET TO SHOW ONLY DATA FOR DATES 2007-02-01 and 2007-02-02
##RECALL COLUMN Date is in format dd/mm/yyyy

newdata <- subset(rdata_prj1, rdata_prj1$Date=="1/2/2007" | rdata_prj1$Date=="2/2/2007")

#TEST NEWDATA
#nrow(newdata)  #should be 2880
#ncol(newdata)  #should be 9
#head(newdata)  #check 1st 6 rows
#tail(newdata)  #check last 6 rows

##REMOVE LARGE FILES WE NO LONGER NEED FROM DIRECTORY
unlink("./class_ExplData/*txt")
unlink("./class_ExplData/*zip")


######################
### CREATE PLOT 1  ###
######################

##Convert Global_active_power data to numeric data. 
##Note:  Numeric Data only can be plotted on graphs.
convert_data <- as.numeric(as.character(newdata$Global_active_power))

##Create png file in new directory "class_ExplData"
png("./class_ExplData/plot1.png", width = 480, height = 480)


##Create histogram 
hist(
  x=convert_data,                           #x-axis values
  main="Global Active Power",               #Graph Title
  col = "red",                              #bar color = red
  xlab="Global Active Power (kilowatts)",   #x-axis label
  ylim=c(0,1200),                           #y-axis values
  breaks=12                                 #total number x-axis bars
)

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