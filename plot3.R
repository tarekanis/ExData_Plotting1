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
# producing the second plot
png("plot3.png", width = 480, height = 480)
with(temp3,plot(time2,Sub_metering_1,type="l",col="BLACK",ylab="Energy sub metering",xlab=""))
with(temp3,lines(time2,Sub_metering_2,col="RED"))
with(temp3,lines(time2,Sub_metering_3,col="BLUE"))
## Add Legend
legend("topright",c("Sub_metering_1 ","Sub_metering_2","Sub_metering_3"),cex=0.8, lty = c(1,1,1), col = c("black","red","blue"),bty = "o")
dev.off()
