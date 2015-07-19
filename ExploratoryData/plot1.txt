##Exploratory Data Analysis
##Project 2 : The overall goal of this assignment is to explore the 
##            National Emissions Inventory database and see what it say 
##            about fine particulate matter pollution in the US over 
##            the 10-year period 1999-2008. 

##PLOT 1: Have total emissions from PM2.5 decreased in the United States 
#         from 1999 to 2008? Using the base plotting system, make a plot showing 
#         the total PM2.5 emission from all sources for each of the years 
#         1999, 2002, 2005, and 2008.

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

data_emissions <- aggregate(NEI[,4], by = list(year=NEI[,6]), FUN = sum)

print("Your R data set is named: data_emissions")

######################
### CREATE PLOT 1  ###
######################
options(scipen=999)     #turn off scientific notation

##Create png file in new directory "ExplData"
png("./ExplData/plot1.png", width = 520, height = 520)


##Create graph 
barplot(
        data_emissions$x, 
        names.arg = data_emissions$year, 
        main = 'Total Emissions From PM2.5', 
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

