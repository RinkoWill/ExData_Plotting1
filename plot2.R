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

##Merge the date and time variables into a new variable, convert it date class, then
##add it to dataset
dttm <- paste(bigpowdata$Date,bigpowdata$Time)
datetime <- strptime(dttm, "%d/%m/%Y %H:%M:%S")
bigpowdata <- cbind(bigpowdata, datetime)
bigpowdata$Date <- as.Date(bigpowdata$Date, format="%d/%m/%Y")

##Subset to Feb 1 and 2, 2007
powdata <- bigpowdata[(which(bigpowdata$Date > "2007-01-31" & bigpowdata$Date < "2007-02-03")),]

##Change Global power class
powdata$Global_active_power <- as.numeric(powdata$Global_active_power)

##Create png, set up line graph, close graphics device
png("plot2.png")

plot(powdata$datetime, powdata$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()