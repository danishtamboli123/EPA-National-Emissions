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

