# Check for if Zip has been Downloaded,else to download.
if(!file.exists("EPA_national_emissions.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","EPA_national_emissions.zip")
}
# Check for if Zip has been Unzipped,else to unzip.
if(!file.exists("EPA_national_emissions")){
  unzip("EPA_national_emissions.zip")
}

# Reading and storing the given datasets into R.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

# Subsetting the NEI dataset to get dataset having only ON-ROAD (Motor Vehicle Sources) from Baltimore City.
required_subset <- subset(NEI,NEI$type == "ON-ROAD" & NEI$fips== 24510)

# Bar Plot for Total Emissions from motor vehicle sources in Baltimore City from 1999-2008.
ggplot(data = required_subset,aes(year,Emissions,fill= year)) + geom_bar(stat = "identity") + labs(title = "Total Emissions from motor vehicle sources in Baltimore City from 1999-2008")

# Saving Bar plot to a PNG format
png(filename = "Plot5.png",height = 720,width = 1280)
ggplot(data = required_subset,aes(year,Emissions,fill= year)) + geom_bar(stat = "identity") + labs(title = "Total Emissions from motor vehicle sources in Baltimore City from 1999-2008")
dev.off()

# Box plot for Emissions from motor vehicle sources in Baltimore City from 1999-2008.
ggplot(data = required_subset,aes(year,Emissions)) + geom_boxplot(aes(as.character(year),log10(Emissions),color = year)) + labs(title = "Emissions from motor vehicle sources in Baltimore City from 1999-2008",x="Year",y="log10(Emissions")

# Saving Box plot to a PNG format
png(filename = "Plot5_Boxplot.png",height = 720,width = 1280)
ggplot(data = required_subset,aes(year,Emissions)) + geom_boxplot(aes(as.character(year),log10(Emissions),color = year)) + labs(title = "Emissions from motor vehicle sources in Baltimore City from 1999-2008",x="Year",y="log10(Emissions")
dev.off()