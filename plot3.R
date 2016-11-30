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

## Load png graphics device to write plot to file
png(filename="plot3.png")

## Create an empty plot with the data to be used
plot(power_subset$datetime, power_subset$Sub_metering_1, type="n", xlab="", 
      ylab="Energy Sub Metering")

## Individually add the sub metering data with appropriate color coding
lines(power_subset$Sub_metering_1 ~ power_subset$datetime)
lines(power_subset$Sub_metering_2 ~ power_subset$datetime, col="red")
lines(power_subset$Sub_metering_3 ~ power_subset$datetime, col="blue")

## Add legend to plot
legend("topright", lty=c(1,1,1), col = c("black","red","blue"), 
      c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Close dev to save data to file
dev.off()