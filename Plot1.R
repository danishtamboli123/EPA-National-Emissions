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