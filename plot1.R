##Check to see if directory exists. Creates directory if not, then uses that as working directory
if(!file.exists("4plotproject")) {dir.create("4plotproject")
}
setwd("./4plotproject")

##Download zipfile and unzip into working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./powerconsumption.zip")
unzip("./powerconsumption.zip")

##Read data from text file; keep original classes
bigpowdata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", as.is=TRUE)

##Change variable classes as needed
bigpowdata$Date <- as.Date(bigpowdata$Date, format="%d/%m/%Y")
bigpowdata$Time <- strptime(bigpowdata$Time, format="%H:%M:%S")
bigpowdata$Global_active_power <- as.numeric(bigpowdata$Global_active_power)


##Subset to Feb 1 and 2, 2007
powdata <- bigpowdata[(which(bigpowdata$Date > "2007-01-31" & bigpowdata$Date < "2007-02-03")),]

##Create png, set up histogram, close graphics device
png("plot1.png")
hist(powdata$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",
              main = "Global Active Power")
dev.off()
