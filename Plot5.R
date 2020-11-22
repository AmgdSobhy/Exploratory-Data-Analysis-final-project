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

# plot 5
png("plot5.png", width=480, height=480)
NEI_BO <- subset(NEI, fips == "24510" & type == "ON-ROAD")
barplot(tapply(NEI_BO$Emissions, as.factor(NEI_BO$year), sum), xlab="years", ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City by vechiles at various years'), ylim = c(0,400))
dev.off()