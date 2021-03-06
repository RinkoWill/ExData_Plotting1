##Check to see if directory exists. Creates directory if not, then 
##uses that as working directory
if(!file.exists("4plotproject")) {dir.create("4plotproject")
}
setwd("./4plotproject")

##Download zipfile and unzip into working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./powerconsumption.zip")
unzip("./powerconsumption.zip")

##Read data from text file; keep original classes
bigpowdata <- read.table("household_power_consumption.txt", header=TRUE, 
        sep=";", as.is=TRUE)

##Subset to Feb 1 and 2, 2007
powdata <- bigpowdata[(which(bigpowdata$Date > "2007-01-31" & 
        bigpowdata$Date < "2007-02-03")),]

##Change variable classes as needed
powdata$Sub_metering_1 <- as.numeric(powdata$Sub_metering_1)
powdata$Sub_metering_2 <- as.numeric(powdata$Sub_metering_2)

##Create png. Set up empty plot and add points separately
##Add legend. Close graphics device
png("plot3.png")

plot(powdata$datetime, powdata$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
points(powdata$datetime, powdata$Sub_metering_1, type = "l", col = "black")
points(powdata$datetime, powdata$Sub_metering_2, type = "l", col = "red")
points(powdata$datetime, powdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd=1, lty=c(1,1,1,1))

dev.off()