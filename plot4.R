##Here you can see my scripts for the fourth plot figure 
#At first, we need to read our file; here is my code for reading the data
#The data frame name would be gap (short from Global Active Power)
gap <- read.table("household_power_consumption.txt", sep = ";", header=T)
#The next step is changing the date and time columns to one combined column as it was recommended
datetime <- paste(gap$Date, gap$Time)
datetime <- as.POSIXct(strptime(datetime, "%d/%m/%Y %H:%M:%S"))
#Next step is changing the gap data frame for adding the datetime vector instead of the two date and time columns.
gap <- cbind(datetime, gap[,-(1:2)])
#If we need to work just with two days, then we choose only these days
gap <- subset(gap, datetime >= as.POSIXct("2007-02-01 00:00:00 PST") & datetime <= as.POSIXct("2007-02-02 23:59:59 PST"))
#After that we change the variables to numeric
gap$Global_active_power = as.numeric(as.character(gap$Global_active_power))
gap$Sub_metering_1 = as.numeric(as.character(gap$Sub_metering_1))
gap$Sub_metering_2 = as.numeric(as.character(gap$Sub_metering_2))
gap$Sub_metering_3 = as.numeric(as.character(gap$Sub_metering_3))
gap$Voltage = as.numeric(as.character(gap$Voltage))
gap$Global_reactive_power = as.numeric(as.character(gap$Global_reactive_power))
#The task is to save file in PNG forrmat 
png("plot4.png", width = 480, height = 480)
#After that we make a 2x2 plots
par(mfcol = c(2,2))
#Plot with change xlab
plot(gap$Global_active_power ~ gap$datetime, type = "l", ylab = "Global Active Power", xlab = "")
#Plot with changed legend
plot(gap$Sub_metering_1 ~ gap$datetime, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
lines(gap$Sub_metering_2 ~ gap$datetime, col = "Red")
lines(gap$Sub_metering_3 ~ gap$datetime, col = "Blue")
legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty ="n")
#Plot the line voltage&time
plot(gap$Voltage ~ gap$datetime, xlab = "datetime", ylab = "Voltage", type = "l")
#Plot the line reactive gap&time and close the connection
plot(gap$Global_reactive_power ~ gap$datetime, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()
