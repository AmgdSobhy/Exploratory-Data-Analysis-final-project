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

# plot 4
png("plot4.png", width=480, height=480)
if(!exists("NEISCC")) NEISCC <- merge(NEI, SCC, by="SCC")
c <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
NEI_C <- NEISCC[c, ]
barplot(tapply(NEI_C$Emissions, as.factor(NEI_C$year), sum)/100000, xlab="years", ylab=expression('total PM'[2.5]*' emission x10'^5),
        main=expression('Total PM'[2.5]*' emissions from coal sources from 1999 to 2008'), ylim = c(0,6))
dev.off()