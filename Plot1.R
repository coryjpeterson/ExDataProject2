#Course Project 2
#Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#downloads the data file from UC Irvine
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","pc.zip")

#unzips the file
unzip("pc.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#sets the output file requirements
png(file="plot1.png",width=480,height=480,units="px")

#extract data
totalP25 <- tapply(NEI$Emissions,NEI$year, sum)

#plots the data
plot(names(totalP25),totalP25,type="l",main="Total PM2.5 emissions from all sources",ylab="Total Emissions",xlab="Year")

#closes the file
dev.off()