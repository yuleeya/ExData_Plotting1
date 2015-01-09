library(sqldf)
library(datasets)

#reading file from URL and substructing ony data for 2 days using sql
fileUrl <-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip" 
download.file (fileUrl, destfile = "data.zip")
unzip("data.zip")
data <- read.csv.sql('household_power_consumption.txt',"select * from file where Date in ('1/2/2007','2/2/2007')", sep = ';', header = T)


#adding new column to the data DatreTime that combines date and time 
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S") 

#setting general parameters to have only one row and column for plot and smaller font size
par(mfrow = c(2,2), cex=0.8)

#plot number one
plot (data$DateTime, data$Global_active_power, ylab ="Global Active Power", xlab ="", typ="l")

#plot number two
plot (data$DateTime, data$Voltage, ylab ="Voltage", xlab ="datetime", typ="l")

#cplot number 3
plot (data$DateTime, data$Sub_metering_1,  type="n", ann=FALSE)
title (ylab ="Energy sub metering", xlab ="")
lines(data$DateTime, data$Sub_metering_1, col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), cex=0.7, bty = "n")

#plot number 4
plot (data$DateTime, data$Global_reactive_power, ylab ="Global_reactive_power", xlab ="datetime", typ="l")

#copy plot to png file
dev.copy(png, file = "plot4.png",  width=480, height=480)
dev.off()