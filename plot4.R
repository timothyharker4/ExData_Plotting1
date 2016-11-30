## Load data.table library to improve file import speed
library("data.table")

## Load data into R
power <- fread("household_power_consumption.txt")

## Put variables in appropriate formats
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## Select subset of data to use for plotting
power_subset <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02"]


## Create a new datetime variable in subset data 
power_subset$datetime <- as.POSIXct(paste(power_subset$Date, power_subset$Time), 
                                    format="%Y-%m-%d %H:%M:%S")

## Adjust variable formats for additional data to be used
power_subset$Global_reactive_power <- as.numeric(power_subset$Global_reactive_power)
power_subset$Voltage <- as.numeric(power_subset$Voltage)

## Open png graphics device and create a blank file called plot4.png
png(filename="plot4.png")

## adjust global parameters to create a 2x2 multi plot
par(mfcol = c(2,2))

## Plot upper left graph
plot(power_subset$datetime, power_subset$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")

## Plot lower left graph
plot(power_subset$datetime, power_subset$Sub_metering_1, type="n", xlab="", 
     ylab="Energy Sub Metering")

lines(power_subset$Sub_metering_1 ~ power_subset$datetime)
lines(power_subset$Sub_metering_2 ~ power_subset$datetime, col="red")
lines(power_subset$Sub_metering_3 ~ power_subset$datetime, col="blue")
legend("topright", lty=c(1,1,1), col = c("black","red","blue"), 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")

## Plot upper right graph
plot(power_subset$datetime, power_subset$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

## Plot lower right graph
plot(power_subset$datetime, power_subset$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

## Save data to plot4.png file
dev.off()