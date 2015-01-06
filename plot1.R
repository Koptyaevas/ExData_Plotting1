##Here you can see my scripts for the first plot figure 
#At first, we need to read our file; here is my code for reading the data
#The data frame nam would be gap (short from Global Active Power)
gap <- read.table("household_power_consumption.txt", sep = ";", header=T)
#The next step is changing the date and time columns to one combined column as it was recommended
datetime <- paste(gap$Date, gap$Time)
datetime <- as.Date(strptime(datetime, "%d/%m/%Y %H:%M:%S"))
#Next step is changing the gap data frame for adding the datetime vector instead of the two date and time columns.
gap <- cbind(datetime, gap[,-(1:2)])
#If we need to work just with two days, then we choose only these days
gap <- subset(gap, datetime >= as.Date("2007-02-01") & datetime <= as.Date("2007-02-02"))
#After that we change the variables to numeric
gap$Global_active_power = as.numeric(as.character(gap$Global_active_power))
#The task is to save file in PNG forrmat 
png("plot1.png", width = 480, height = 480)
#Finally, I need to create a histogram
hist(gap$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")
dev.off()
