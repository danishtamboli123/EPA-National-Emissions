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

library(dplyr)
library(ggplot2)

NEI_1999 <- subset(NEI,year==1999)
NEI_2002 <- subset(NEI,year==2002)
NEI_2005 <- subset(NEI,year==2005)
NEI_2008 <- subset(NEI,year==2008)

total_emissions_by_year <- summarise(group_by(NEI, year), Emissions=sum(Emissions))

# Bar plot for Total Emissions year wise from 1999-2008
barplot(height = total_emissions_by_year$Emissions/1000,names.arg = total_emissions_by_year$year,col = as.character(total_emissions_by_year$year),ylim = c(0,8000),ylab = "Total Emissions in a year(per 1000 tons)",xlab = "Years",main = "Total Emissions year wise from 1999-2008")

#From the above Bar plot we can conclude that the is a drastic decrease in the Total Emissions over the years.

# Saving Bar Plot to a PNG format
png(filename = "Plot1.png",height = 720,width = 1280)
barplot(height = total_emissions_by_year$Emissions/1000,names.arg = total_emissions_by_year$year,col = as.character(total_emissions_by_year$year),ylim = c(0,8000),ylab = "Total Emissions in a year(per 1000 tons)",xlab = "Years",main = "Total Emissions year wise from 1999-2008")
dev.off()

# Not using this directly as the scale would be huge.
# boxplot(NEI_1999$Emissions,NEI_2002$Emissions,NEI_2005$Emissions,NEI_2008$Emissions)

# Box Plot to see Range of emissions of PM2.5 over the Years 1999-2008
boxplot(log10(NEI_1999$Emissions),log10(NEI_2002$Emissions),log10(NEI_2005$Emissions),log10(NEI_2008$Emissions),xlab= "Year",ylab = "Log10(Emission)",main = "Emissions from PM2.5 1999-2008",names = c("1999","2002","2005","2008"))

# Saving Box Plot to a PNG format
png(filename = "Plot1_Boxplot.png",height = 720,width = 1280)
boxplot(log10(NEI_1999$Emissions),log10(NEI_2002$Emissions),log10(NEI_2005$Emissions),log10(NEI_2008$Emissions),xlab= "Year",ylab = "Log10(Emission)",main = "Emissions from PM2.5 1999-2008",names = c("1999","2002","2005","2008"))
dev.off()

# From the Above graph we can see the Median (50th Percentile),the 25th and 75th Percentile all are decreasing from 1999 to 2008.
# The change from 1999 to 2002 is more drastic than from 2002 to 2008.
# We also notice the spread (Whiskers) are wider in the Later Years.
# Even the Outliners in years from 2002 onward show a greater range.
# All of this can be validated by running a summary on each of these.

# Running summary() on Emissions of Each year. (Log10 used to ensure proper scaling for easier analysis)
summary(log10(NEI_1999$Emissions))
summary(log10(NEI_2002$Emissions))
summary(log10(NEI_2005$Emissions))
summary(log10(NEI_2008$Emissions))

NEI_1999_24510 <- subset(NEI,year==1999 & fips ==24510)
NEI_2002_24510 <- subset(NEI,year==2002 & fips ==24510)
NEI_2005_24510 <- subset(NEI,year==2005 & fips ==24510)
NEI_2008_24510 <- subset(NEI,year==2008 & fips ==24510)

total_emissions_by_year <- summarise(group_by(NEI, year,fips), Emissions=sum(Emissions))

# Creating the required subset,in this case only data from Baltimore City.
required_subset <- subset(total_emissions_by_year,fips == 24510)

# Bar plot for Total Emissions year wise from 1999-2008 in Baltimore City,Maryland
barplot(height = required_subset$Emissions,names.arg = required_subset$year,col = as.character(required_subset$year),ylim = c(0,4000),ylab = "Total Emissions in a year(per ton)",xlab = "Years",main = "Total Emissions year wise from 1999-2008 in Baltimore City,Maryland")

#From the above Bar plot we can conclude that the is a drastic decrease in the Total Emissions over the years.

# Saving Bar plot to a PNG format
png(filename = "Plot2.png",height = 720,width = 1280)
barplot(height = required_subset$Emissions,names.arg = required_subset$year,col = as.character(required_subset$year),ylim = c(0,4000),ylab = "Total Emissions in a year(per ton)",xlab = "Years",main = "Total Emissions year wise from 1999-2008 in Baltimore City,Maryland")
dev.off()

# Not using this directly as the scale would be huge.
# box plot(NEI_1999$Emissions,NEI_2002$Emissions,NEI_2005$Emissions,NEI_2008$Emissions)

# Box Plot to see Range of emissions of PM2.5 over the Years 1999-2008
boxplot(log10(NEI_1999_24510$Emissions),log10(NEI_2002_24510$Emissions),log10(NEI_2005_24510$Emissions),log10(NEI_2008_24510$Emissions),xlab= "Year",ylab = "Log10(Emission)",main = "Emissions from PM2.5 1999-2008 in Baltimore City,Maryland",names = c("1999","2002","2005","2008"))

# Saving Box Plot to a PNG format
png(filename = "Plot2_Boxplot.png",height = 720,width = 1280)
boxplot(log10(NEI_1999_24510$Emissions),log10(NEI_2002_24510$Emissions),log10(NEI_2005_24510$Emissions),log10(NEI_2008_24510$Emissions),xlab= "Year",ylab = "Log10(Emission)",main = "Emissions from PM2.5 1999-2008 in Baltimore City,Maryland",names = c("1999","2002","2005","2008"))
dev.off()

# From the Above graph we can see the Median (50th Percentile),the 25th and 75th Percentile all are decreasing from 1999 to 2008.
# The change from 1999 to 2002 is more drastic than from 2002 to 2008.
# We also notice the spread (Whiskers) are wider in the Later Years.
# Even the Outliners in years from 2002 onward show a greater range.
# All of this can be validated by running a summary on each of these.

# Running summary() on Emissions of Each year. (Log10 used to ensure proper scaling for easier analysis)
summary(log10(NEI_1999_24510$Emissions))
summary(log10(NEI_2002_24510$Emissions))
summary(log10(NEI_2005_24510$Emissions))
summary(log10(NEI_2008_24510$Emissions))

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

# Subsetting the NEI dataset to get dataset having only ON-ROAD (Motor Vehicle Sources) from Baltimore City.
required_subset <- subset(NEI,NEI$type == "ON-ROAD" & (NEI$fips == "24510" | NEI$fips == "06037"))

# Adding County Field (Column) to Subset for Easier Identification as opposed to fips number.
required_subset$county <-ifelse(required_subset$fips == 24510,"Baltimore City","Los Angeles")

# Bar plot for Comparison of Total Emissions from Motor Vehicle Sources in Baltimore and Los Angeles.
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
