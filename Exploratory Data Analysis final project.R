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

# plot 1
png("plot1.png", width=480, height=480)
barplot(tapply(NEI$Emissions, as.factor(NEI$year), sum)/1000000, xlab="years", ylab=expression('total PM'[2.5]*' emission in Millions'),
        main=expression('Total PM'[2.5]*' emissions at various years'), ylim = c(0,8))
dev.off()

# plot 2
png("plot2.png", width=480, height=480)
NEI_B <- subset(NEI, fips == "24510") 
barplot(tapply(NEI_B$Emissions, as.factor(NEI_B$year), sum), xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'), ylim = c(0,4000))
dev.off()

# plot 3
png("plot3.png", width=480, height=480)
library(ggplot2)
d <- aggregate(Emissions ~ year + type, NEI_B, sum)
g <- ggplot(data = d, aes(year, Emissions, color= type))
g + geom_line() + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')
dev.off()

# plot 4
png("plot4.png", width=480, height=480)
if(!exists("NEISCC")) NEISCC <- merge(NEI, SCC, by="SCC")
c <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
NEI_C <- NEISCC[c, ]
barplot(tapply(NEI_C$Emissions, as.factor(NEI_C$year), sum)/100000, xlab="years", ylab=expression('total PM'[2.5]*' emission x10'^5),
        main=expression('Total PM'[2.5]*' emissions from coal sources from 1999 to 2008'), ylim = c(0,6))
dev.off()

# plot 5
png("plot5.png", width=480, height=480)
NEI_BO <- subset(NEI, fips == "24510" & type == "ON-ROAD")
barplot(tapply(NEI_BO$Emissions, as.factor(NEI_BO$year), sum), xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City by vechiles at various years'), ylim = c(0,400))
dev.off()

# plot 6
png("plot6.png", width=480, height=480)
NEI_BO <- subset(NEI, fips == "24510" & type == "ON-ROAD")
NEI_LO <- subset(NEI, fips == "06037" & type == "ON-ROAD")
par(mfrow = c(2,1))
barplot(tapply(NEI_BO$Emissions, as.factor(NEI_BO$year), sum), xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City by vechiles at various years'), ylim = c(0,4000))
barplot(tapply(NEI_LO$Emissions, as.factor(NEI_LO$year), sum), xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Los Angeles County by vechiles at various years'), ylim = c(0,4000))
dev.off()