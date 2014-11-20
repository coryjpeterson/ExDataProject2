#Course Project 2
#Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#downloads the data file from UC Irvine
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","pc.zip")

#unzips the file
unzip("pc.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#sets the output file requirements
png(file="plot2.png",width=480,height=480,units="px")

#subset the data
totalP25byBalt <- subset(NEI,NEI$fips == "24510")

#extract data
totalP25 <- tapply(totalP25byBalt$Emissions,totalP25byBalt$year, sum)

#plots the data
plot(names(totalP25),totalP25,type="l",main="Total PM2.5 emissions in Baltimore City",ylab="Total Emissions",xlab="Year")

#closes the file
dev.off()