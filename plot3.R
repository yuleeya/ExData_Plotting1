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
par(mfrow = c(1,1), cex=0.9)

#initializing the plot and then adding scatterplots for each of the 3 variables
plot (data$DateTime, data$Sub_metering_1,  type="n", ann=FALSE)
title (ylab ="Energy sub metering", xlab ="")
lines(data$DateTime, data$Sub_metering_1, col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")

#adding legent
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

#saving plot to the png file
dev.copy(png, file = "plot3.png",  width=480, height=480)
dev.off()