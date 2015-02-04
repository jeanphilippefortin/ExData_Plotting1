#### This assume you have downloaded the file, otherwise, you would have done 
## fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
#### This one could change if you are not using Windows, might need method="curl"
## download.file(fileUrl, destFile="household_power_consumption.zip")
#### then unzip
## unzip("household_power_consumption.zip")


## set the filename and import data
fileName <- "household_power_consumption.txt"
rawData <- read.table(fileName, header=TRUE, sep=";", dec=".", na.string="?", colClasses = c(rep("character",2), rep("numeric", 7)))

## Convert Date
rawData[, 1] <- as.Date(rawData[, 1], "%d/%m/%Y")

## set a date filter and subset data
dateFilter = as.Date(c("2007-02-01", "2007-02-02"))
data <- subset(rawData, Date %in% dateFilter)

## release full object
rm(rawData)

## store user language and switch locale to english
userLang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

## Open png device and plot to device
png(file="plot4.png", width=480, height=480, units="px")
par(mfrow = c(2,2))
with(data, 
{
        plot(as.POSIXct(strptime(paste(Date, Time, sep= " "), "%Y-%m-%d %H:%M:%S")), Global_active_power, type="s", ylab="Global Active Power", xlab="")
        plot(as.POSIXct(strptime(paste(Date, Time, sep= " "), "%Y-%m-%d %H:%M:%S")), Voltage, type="s", ylab="Voltage", xlab="datetime")
        {
                plot( as.POSIXct(strptime(paste(Date, Time, sep= " "), "%Y-%m-%d %H:%M:%S")), Sub_metering_1, col="black", type="s", ylab="Energy sub metering", xlab="")
                lines(as.POSIXct(strptime(paste(Date, Time, sep= " "), "%Y-%m-%d %H:%M:%S")), Sub_metering_2, col="red")
                lines(as.POSIXct(strptime(paste(Date, Time, sep= " "), "%Y-%m-%d %H:%M:%S")), Sub_metering_3, col="blue")
                legendText <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
                legendCol <- c("black", "red", "blue")
                legend("topright", legendText, col=legendCol, lty=1, bty="n", cex=0.95)
        }
        plot(as.POSIXct(strptime(paste(Date, Time, sep= " "), "%Y-%m-%d %H:%M:%S")), Global_reactive_power, type="s", xlab="datetime")
})
dev.off()

#restore language
Sys.setlocale("LC_TIME", userLang)
