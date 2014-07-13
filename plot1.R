# read data
install.packages("data.table")
library("data.table")
consumption_data <- fread("household_power_consumption.txt",na.strings="?")
# change to date format
consumption_data$Date <-as.Date(consumption_data$Date,format = "%d/%m/%Y")
# subsetting the data to work only on the desired data
ndata <- consumption_data[consumption_data$Date == "2007-02-01",]
consumption_data2 <- rbind(ndata,consumption_data[consumption_data$Date == "2007-02-02",])
# change variables into numeric
consumption_data2$Global_active_power <- as.numeric(consumption_data2$Global_active_power)
consumption_data2$Global_reactive_power <-as.numeric(consumption_data2$Global_reactive_power)
consumption_data2$Voltage <- as.numeric(consumption_data2$Voltage)
consumption_data2$Global_intensity <- as.numeric(consumption_data2$Global_intensity)
# producing the first plot
png("plot1.png", width = 480, height = 480)
hist(consumption_data2$Global_active_power,col="Red",main="Global Active Power",xlab="Global Active Power (kilowatts")
dev.off()
