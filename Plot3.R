# check & set Working Directory
if(getwd() != "C:/Users/DELL/OneDrive/Documents/RWD") setwd("~/RWD")

# Download file
if(!file.exists("exdata_data_NEI_data.zip"))
{
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  "exdata_data_NEI_data.zip")
}

#unzip rar file
if(!file.exists("exdata_data_NEI_data")) unzip("exdata_data_NEI_data.zip")

# update Working Directory
if(getwd() != "C:/Users/DELL/OneDrive/Documents/RWD/exdata_data_NEI_data") setwd("~/RWD/exdata_data_NEI_data")

# read data
if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

# plot 3
png("plot3.png", width=480, height=480)
library(ggplot2)
d <- aggregate(Emissions ~ year + type, NEI_B, sum)
g <- ggplot(data = d, aes(year, Emissions, color= type))
g + geom_line() + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')
dev.off()