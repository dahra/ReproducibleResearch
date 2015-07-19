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

options(scipen=999)         #turn off scientific notation
require(ggplot2)            #ggplot package
require(labeling)           #labeling package

#########################################
##Emissions data                       ##
#########################################

# Coal-related SCC
coalscc = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]


# Merge two data sets
emm_merge <- merge(x=NEI, y=coalscc, by='SCC')
emm_sum <- aggregate(emm_merge[, 'Emissions'], by=list(emm_merge$year), sum)
colnames(emm_sum) <- c('Year', 'Emissions')

######################
### CREATE PLOT 1  ###
######################

##Create png file in new directory "ExplData"
png("./plot4.png", width =450 , height = 450)


##Create graph

ggplot(data=emm_sum, aes(x=Year, y=Emissions/1000)) + 
    geom_line(aes(group=1, col=Emissions)) + 
    geom_point(aes(size=2, col=Emissions)) + 
    ggtitle(expression("US Total Emissions PM2.5")) + 
    ylab(expression("Emissions PM2.5")) + 
    theme(legend.position='none') 

dev.off()

#################################
##REMOVE WHAT WE NO LONGER NEED##
#################################

unlink("./ExplData/*rds")
unlink("./ExplData/*zip")
rm(prj2_url)

