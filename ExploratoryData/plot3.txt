##Exploratory Data Analysis
##Project 2 : The overall goal of this assignment is to explore the 
##            National Emissions Inventory database and see what it say 
##            about fine particulate matter pollution in the US over 
##            the 10-year period 1999-2008. 

##PLOT 4: Across the United States, how have emissions from coal combustion-related 
##        sources changed from 1999-2008?

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

options(scipen=999)     #turn off scientific notation

require(ggplot2)            #ggplot package
require(labeling)           #labeling package

#########################################
##Emissions data                       ##
#########################################

bcity <- subset(NEI, fips == 24510)
bcity$year <- factor(bcity$year, levels = c('1999', '2002', '2005', '2008'))


######################
### CREATE PLOT 1  ###
######################

##Create png file in new directory "ExplData"
png("./plot3.png", width = 800, height = 800)


##Create graph

ggplot(data = bcity, aes(x = year, y = log(Emissions))) +
  facet_grid(. ~ type) +
  stat_boxplot(geom = 'errorbar') +
  ylab('Emissions PM2.5 (Log)') +
  xlab('Year') +
  ggtitle('Baltimore City Emissions/Type') +
  geom_boxplot(aes(fill = type)) +
  geom_jitter (alpha = .25, color=2)

dev.off()

#################################
##REMOVE WHAT WE NO LONGER NEED##
#################################

unlink("./ExplData/*rds")
unlink("./ExplData/*zip")
rm(prj2_url)

