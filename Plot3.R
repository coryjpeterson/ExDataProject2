#Course Project 2
#Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

#loads ggplot2
library(ggplot2)

#loads dplyr
library(dplyr)

#downloads the data file from UC Irvine
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","pc.zip")

#unzips the file
unzip("pc.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIsum <- tbl_df(NEI)

#subset the data to Baltimore City
totalP25byBalt <- filter(NEIsum, fips == "24510")
totalP25byBalt <- group_by(totalP25byBalt,year,type)

#summarizes by the data required
summaryP25byBalt <- summarize(totalP25byBalt,sumperyear=sum(Emissions))

#sets the output file requirements
png(file="plot3.png",width=480,height=480,units="px")

#plots the data
p <- qplot(year,sumperyear,data=summaryP25byBalt,color=type, geom="line") +
  ggtitle("Emissions in Baltimore City by Source Type and Year") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions")

print(p)

#closes the file
dev.off()