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

# Creating the required subset,in this case only data from Baltimore City.
required_subset <- subset(NEI,fips==24510)

# Box plot of Range Emissions from certain types of Sources over the years in Baltimore City.
ggplot(data = required_subset,aes(year,Emissions,fill=type)) + geom_bar(stat = "identity") + facet_grid(. ~ type) + labs(title = "Emissions from certain types of Sources over the years (1999-2008) in Baltimore City.")

# Saving Bar plot to a PNG format
png(filename = "Plot3.png",height = 720,width = 1280)
ggplot(data = required_subset,aes(year,Emissions,fill=type)) + geom_bar(stat = "identity") + facet_grid(. ~ type) + labs(title = "Emissions from certain types of Sources over the years (1999-2008) in Baltimore City.")
dev.off()

# Box plot of Range Emissions from certain types of Sources over the years in Baltimore City.
ggplot(data = required_subset,aes(year,log10(Emissions))) + geom_boxplot(aes(as.character(year),log10(Emissions),color = type)) + labs(title = "Emissions from Certain Sources over the Years (1999-2008) in Baltimore City", x = "Year")

# Saving Box plot to a PNG format
png(filename = "Plot3_BoxPlot.png",height = 720,width = 1280)
ggplot(data = required_subset,aes(year,log10(Emissions))) + geom_boxplot(aes(as.character(year),log10(Emissions),color = type)) + labs(title = "Emissions from Certain Sources over the Years (1999-2008) in Baltimore City", x = "Year")
dev.off()

# From the Above graph we can see the Median (50th Percentile),the 25th and 75th Percentile all are decreasing from 1999 to 2008,across all types
# In the case of NON-ROAD, NONPOINT and ON-ROAD The change from 1999 to 2002 is more drastic than from 2002 to 2008.
# In the case of POINT The change is pretty gradual across all years,but is more drastic from 2005 to 2008.
# We also notice the spread (Whiskers) are wider in the years following 1999.
# The Outliners in years from 2002 onward show a greater range.
# All of this can be validated by running a summary on each of these.