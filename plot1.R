library("lubridate")
library("dplyr")

##Check to see if directory exists. Creates directory if not, then uses that as working directory
if(!file.exists("4plotproject")) {dir.create("4plotproject")
}
setwd("./4plotproject")

##Download zipfile and unzip into working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./powerconsumption.zip")
unzip("./powerconsumption.zip")

bigpowdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", as.is=TRUE)

bigpowdata$Date <- as.Date(bigpowdata$Date, format="%d/%m/%Y")
bigpowdata$Time <- strptime(bigpowdata$Time, format="%H:%M:%S")
bigpowdata$Global_active_power <- as.numeric(bigpowdata$Global_active_power)
bigpowdata$Global_reactive_power <- as.numeric(bigpowdata$Global_reactive_power)
bigpowdata$Voltage <- as.numeric(bigpowdata$Voltage)
bigpowdata$Global_intensity <- as.numeric(bigpowdata$Global_intensity)
bigpowdata$Sub_metering_1 <- as.numeric(bigpowdata$Sub_metering_1)
bigpowdata$Sub_metering_2 <- as.numeric(bigpowdata$Sub_metering_2)

powdata <- bigpowdata[(which(bigpowdata$Date > "2007-01-31" & bigpowdata$Date < "2007-02-03")),]

png(plot1.png)
hist(powdata$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",
              main = "Global Active Power")
dev.off()
