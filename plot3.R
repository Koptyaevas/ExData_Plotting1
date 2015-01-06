##Here you can see my scripts for the first plot figure 
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
gap$Sub_metering_1 = as.numeric(as.character(gap$Sub_metering_1))
gap$Sub_metering_2 = as.numeric(as.character(gap$Sub_metering_2))
gap$Sub_metering_3 = as.numeric(as.character(gap$Sub_metering_3))
#The task is to save file in PNG forrmat 
png("plot3.png", width = 480, height = 480)
#After that I create the first plot for sub_1
plot(gap$Sub_metering_1 ~ gap$datetime, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
#Then I add lines for the sub_2, the color of lines is red
lines(gap$Sub_metering_2 ~ gap$datetime, col = "Red")
#Then I add lines for the sub_3, the color of lines is blue
lines(gap$Sub_metering_3 ~ gap$datetime, col = "Blue")
#Finally, I add a legend and close the connection 
legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()
