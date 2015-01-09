
library(sqldf)
library(datasets)
fileUrl <-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip" 
download.file (fileUrl, destfile = "data.zip")
unzip("data.zip")
data <- read.csv.sql('household_power_consumption.txt',"select * from file where Date in ('1/2/2007','2/2/2007')", sep = ';', header = T)


data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S") 

par(mfrow = c(1,1))

plot (data$DateTime, data$Global_active_power, ylab ="Global Active Power (kilowatts)", xlab ="", typ="l", cex=0.8)


dev.copy(png, file = "plot2.png",  width=480, height=480)
dev.off()