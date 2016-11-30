## Load data.table library to improve file import speed
library("data.table")

## Load data into R
power <- fread("household_power_consumption.txt")

## Put variables in appropriate formats
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## Select subset of data to use for plotting
power_subset <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02"]

## Draw histogram for plot 1
hist(power_subset$Global_active_power, main = "Global Active Power", 
      xlab = "Global Active Power (kilowatts)", col = "red")

## Copy plot to png file
dev.copy(png, file="plot1.png")
dev.off()