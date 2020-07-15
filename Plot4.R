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

# Regex filtering the SCC dataset to find Sources that contain Coal keyword.
Contains_keyword_coal <- grepl("Fuel Comb.*Coal",SCC$EI.Sector)

# Subsetting the SCC dataset to contain only Values which are related to Coal Combustion.
required_subset_SCC <- SCC[Contains_keyword_coal,]

# Subsetting the NEI dataset to have only Emission reading from Sources related to Coal Combustion.
required_subset_Containing_Coal <- subset(NEI,NEI$SCC %in% required_subset_SCC$SCC)

# Summarizing the Subsetted Data by Year and finding the Total Emission in particular year.
summarized_data <- summarise(group_by(required_subset_Containing_Coal,year),sum(Emissions))

# Bar Plot for Total Emissions (per 1000 tons) in the United States related to Coal Combustion.
ggplot(data = required_subset_Containing_Coal,aes(year,Emissions/1000,fill=year)) + geom_bar(stat = "identity") + labs(title = "Total Emissions (per 1000 tons) in the United States related to Coal Combustion")

# Saving Bar plot to a PNG format
png(filename = "Plot4.png",height = 720,width = 1280)
ggplot(data = required_subset_Containing_Coal,aes(year,Emissions/1000,fill=year)) + geom_bar(stat = "identity") + labs(title = "Total Emissions (per 1000 tons) in the United States related to Coal Combustion")
dev.off()

# Box plot of Emission Levels in the United States caused by Coal Combustion.
ggplot(data = required_subset_Containing_Coal,aes(year,log10(Emissions))) + geom_boxplot(aes(as.character(year),log10(Emissions),color=type)) + labs(title = "Emission Levels in the United States caused by Coal Combustion.",x="Year",y="log10(Emissions")

# Saving Bar plot to a PNG format
png(filename = "Plot4_boxplot.png",height = 720,width = 1280)
ggplot(data = required_subset_Containing_Coal,aes(year,log10(Emissions))) + geom_boxplot(aes(as.character(year),log10(Emissions),color=type)) + labs(title = "Emission Levels in the United States caused by Coal Combustion.",x="Year",y="log10(Emissions")
dev.off()
