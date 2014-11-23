#Course Project 2
#Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

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
SCCsum <- tbl_df(SCC)

#filter to just motor vehicles (assume onroad)
SCCfil <- filter(SCCsum, grepl("Onroad",Data.Category))

#merge the NEI and SCC datasets
AllMotor <- inner_join(NEIsum,SCCfil)

#subset the data to Baltimore City
AllMotor <- filter(AllMotor, fips == "24510" | fips == "06037")

#subset the data to All Coal sources
AllMotor <- group_by(AllMotor,year,fips)

#summarizes by the data required
AllMotor <- summarize(AllMotor,sumperyear=sum(Emissions))

#sets the output file requirements
png(file="plot6.png",width=480,height=480,units="px")

#plots the data
p <- qplot(year,sumperyear,data=AllMotor, color=fips, geom="line") +
  ggtitle("Emissions from Motor Vehicles by Year") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions") +
  scale_color_discrete(name="Cities",labels=c("Los Angeles County","Baltimore City"))

print(p)

#closes the file
dev.off()