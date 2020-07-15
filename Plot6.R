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
required_subset <- subset(NEI,NEI$type == "ON-ROAD" & (NEI$fips == "24510" | NEI$fips == "06037"))

# Adding County Field (Column) to Subset for Easier Identification as opposed to fips number.
required_subset$county <-ifelse(required_subset$fips == 24510,"Baltimore City","Los Angeles")

# Bar plot for Comparison of Total Emissions from Motor Vehicle Sources in Baltimore and Los Angeles
ggplot(data = required_subset,aes(year,Emissions,fill=county)) + geom_bar(stat = "identity") + facet_grid(fips ~ .,scales = "free")+ labs(title = "Comparison of Total Emissions from Motor Vehicle Sources in Baltimore and Los Angeles",x= "Year",y= "Emissions")

# Saving Bar plot to a PNG format
png(filename = "Plot6.png",height = 720,width = 1280)
ggplot(data = required_subset,aes(year,Emissions,fill=county)) + geom_bar(stat = "identity") + facet_grid(fips ~ .,scales = "free")+ labs(title = "Comparison of Total Emissions from Motor Vehicle Sources in Baltimore and Los Angeles",x= "Year",y= "Emissions")
dev.off()

ggplot(data = required_subset,aes(year,Emissions)) + geom_boxplot(aes(year,log10(Emissions),color = county)) + labs(title = "Comparison of Emissions from Motor Vehicle Sources in Balitmore and Los Angeles",x= "Year",y= "log10(Emissions)")

# Saving Box plot to a PNG format
png(filename = "Plot6_Boxplot.png",height = 720,width = 1280)
ggplot(data = required_subset,aes(year,Emissions)) + geom_boxplot(aes(year,log10(Emissions),color = county)) + labs(title = "Comparison of Emissions from Motor Vehicle Sources in Balitmore and Los Angeles",x= "Year",y= "log10(Emissions)")
dev.off()

