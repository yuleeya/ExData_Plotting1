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

#plotting scatterplot 
plot (data$DateTime, data$Global_active_power, ylab ="Global Active Power (kilowatts)", xlab ="", typ="l")

#saving plot to the png file
dev.copy(png, file = "plot2.png",  width=480, height=480)
dev.off()