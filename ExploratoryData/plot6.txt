##Exploratory Data Analysis
##Project 2 : The overall goal of this assignment is to explore the 
##            National Emissions Inventory database and see what it say 
##            about fine particulate matter pollution in the US over 
##            the 10-year period 1999-2008. 

##PLOT 6: Compare emissions from motor vehicle sources in Baltimore City 
##        with emissions from motor vehicle sources in Los Angeles County, California 
##        (fips == "06037"). Which city has seen greater changes over time in 
##        motor vehicle emissions?

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

##Baltimore City
bcity <- subset(NEI, ((fips == "24510" ) & type == 'ON-ROAD'))
bcity$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
bcitysum <- aggregate(bcity[, 'Emissions'], by=list(bcity$year), sum)
colnames(bcitysum) <- c('year', 'Emissions')
bcitysum$City <- paste(rep('MD', 4))

##Los Angeles
LA <- subset(NEI, fips == '06037' & type == 'ON-ROAD')
LA$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
LAsum <- aggregate(LA[, 'Emissions'], by=list(LA$year), sum)
colnames(LAsum) <- c('year', 'Emissions')
LAsum$City <- paste(rep('CA', 4))

rbind_df <- as.data.frame(rbind(bcitysum, LAsum))

######################
### CREATE PLOT 1  ###
######################

##Create png file in new directory "ExplData"
png("./plot6b.png", width = 450, height = 450)


##Create graph

ggplot(data=rbind_df, aes(x=year, y=Emissions, group=1)) + 
  geom_bar(aes(fill=year) , stat = "identity", alpha = .5) + 
  guides(fill=FALSE) + 
  ggtitle('Baltimore City vs LA Emissions (Motor Vehicle)') + 
  ylab(expression('Emissions PM2.5')) +
  xlab('Year') +
  facet_grid(. ~ City) +
  geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))

  
dev.off()

#################################
##REMOVE WHAT WE NO LONGER NEED##
#################################

unlink("./ExplData/*rds")
unlink("./ExplData/*zip")
rm(prj2_url)

