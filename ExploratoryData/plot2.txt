##Exploratory Data Analysis
##Project 2 : The overall goal of this assignment is to explore the 
##            National Emissions Inventory database and see what it say 
##            about fine particulate matter pollution in the US over 
##            the 10-year period 1999-2008. 

##PLOT 2: Have total emissions from PM2.5 decreased in the Baltimore City, MD
##        (fips == "24510") from 1999 to 2008? Use the base plotting system 
##        to make a plot answering this question.

##data url:  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

###########################
#Load Zipped File from url#
###########################

#Create directory for data if it doesn't exist already
if(!file.exists("ExplData")) {dir.create("ExplData")}

#Create a variable for the url
prj2_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

#download zipped file into new directory ad temp.zip
download.file(prj2_url, "./ExplData/temp.zip", mode="wb")     #wb for binary

#unzip temp.zip files into new directory "ExplData"
unzip("./ExplData/temp.zip", exdir="./ExplData")

#reset working directory
setwd("./ExplData")

#read unzipped RDS data files into R format
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Record date of download
dateDownloaded <- date()


#########################################
##Sum of emissions data grouped by year##
#########################################

#emissions is in column 4 of the dataset
#year is in column 6 of the dataset
#fips is in column 1 of the data set
#     Baltimore City, Maryland (fips == "24510")

data_emissions <- aggregate(NEI[,4], by = list(year=NEI[,6], fips=NEI[,1]), FUN = sum)
bcity <- subset(data_emissions, fips=="24510")

print("Your R data set is named: bcity")

######################
### CREATE PLOT 1  ###
######################
options(scipen=999)     #turn off scientific notation

##Create png file in new directory "ExplData"
png("./plot2.png", width = 520, height = 520)


##Create graph 
barplot(
        bcity$x, 
        names.arg = bcity$year, 
        main = 'Baltimore City Total Emissions From PM2.5', 
        xlab = 'Year', 
        ylab = 'Emissions'
        )


dev.off()

#################################
##REMOVE WHAT WE NO LONGER NEED##
#################################

unlink("./ExplData/*rds")
unlink("./ExplData/*zip")
rm(prj2_url)

