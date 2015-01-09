#library(dplyr)
#library(data.table)
library(sqldf)
library(datasets)
fileUrl <-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip" 
download.file (fileUrl, destfile = "data.zip")
unzip("data.zip")
data <- read.csv.sql('household_power_consumption.txt',"select * from file where Date in ('1/2/2007','2/2/2007')", sep = ';', header = T)

#par(mfrow = c(1,1))

data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S") 
hist(data$Global_active_power, xlab ="Global Active Power (kilowatts)", col="red",main="Global Active Power", breaks=15)

dev.copy(png, file = "plot1.png",  width=480, height=480)
dev.off()