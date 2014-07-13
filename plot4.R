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
consumption_data2$Sub_metering_1 <- as.numeric(consumption_data2$Sub_metering_1)
consumption_data2$Sub_metering_2 <- as.numeric(consumption_data2$Sub_metering_2)
consumption_data2$Sub_metering_3 <- as.numeric(consumption_data2$Sub_metering_3)
# transform time
temp <- within(consumption_data2,{new_time <- paste(Date,Time,sep=" ")})
temp3 <- within(temp,{time2 = as.POSIXct(new_time, format ="%Y-%m-%d %H:%M:%S")})
data <- temp3
# producing the second plot
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(data$time2,data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
with(data,plot(time2,Voltage, type = "l", xlab = "datetime"))
plot(data$time2,data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = data$time2, y = data$Sub_metering_2, col = "red")
lines(x = data$time2, y = data$Sub_metering_3, col = "blue")
with(data,plot(time2,Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()
