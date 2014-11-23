#Course Project 2
#Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

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

#filter to just Coal based sectors
SCCfil <- filter(SCCsum, grepl("Coal",EI.Sector))

#merge the NEI and SCC datasets
AllCoal <- inner_join(NEIsum,SCCfil)

#subset the data to All Coal sources
AllCoal <- group_by(AllCoal,year)

#summarizes by the data required
AllCoal <- summarize(AllCoal,sumperyear=sum(Emissions))

#sets the output file requirements
png(file="plot4.png",width=480,height=480,units="px")

#plots the data
p <- qplot(year,sumperyear,data=AllCoal, geom="line") +
  ggtitle("Emissions from Coal by Year") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions")

print(p)

#closes the file
dev.off()