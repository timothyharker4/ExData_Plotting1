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


## Plot graph of Global Active Power over time
plot(power_subset$datetime, power_subset$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")

## Copy plot to png file
dev.copy(png, file="plot2.png")
dev.off()