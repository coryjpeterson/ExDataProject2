#Course Project 2
#Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

#loads ggplot2
library(ggplot2)

#downloads the data file from UC Irvine
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","pc.zip")

#unzips the file
#unzip("pc.zip")

## This first line will likely take a few seconds. Be patient!
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#sets the output file requirements
#png(file="plot3.png",width=480,height=480,units="px")

#subset the data to Baltimore City
totalP25byBalt <- subset(NEI,NEI$fips == "24510")

#subsets the data by type
P25point <- subset(totalP25byBalt,totalP25byBalt$type == "POINT")
P25nonpoint <- subset(totalP25byBalt,totalP25byBalt$type == "NONPOINT")
P25onroad <- subset(totalP25byBalt,totalP25byBalt$type == "ON-ROAD")
P25nonroad <- subset(totalP25byBalt,totalP25byBalt$type == "NON-ROAD")

#extract data by type
totalP25point <- tapply(P25point$Emissions,P25point$year, sum)
totalP25nonpoint <- tapply(P25nonpoint$Emissions,P25nonpoint$year, sum)
totalP25onroad <- tapply(P25onroad$Emissions,P25onroad$year, sum)
totalP25nonroad <- tapply(P25nonroad$Emissions,P25nonroad$year, sum)

totalP25 <- rbind("POINT"=totalP25point,"NONPOINT"=totalP25nonpoint,"ON-ROAD"=totalP25onroad,"NON-ROAD"=totalP25nonroad)

#plots the data
qplot(names(totalP25),totalP25,color=type, geom="line")

#closes the file
#dev.off()