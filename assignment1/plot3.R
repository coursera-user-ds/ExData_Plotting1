### Programming Assignment 1 - Exploratory Data Analysis
### Plot 3 - 3 line plot of global active power over time.

library(data.table)
library(datasets)

## Read in file "household_power_consumption.txt".
file_name <- "household_power_consumption.txt"
front <- read.table(file_name, header= TRUE, sep = ";", nrows = 5)
classes <- sapply(front, class)
dat <- fread(file_name, sep = ";", header = TRUE, colClasses = classes, na.strings="?")

## Subset by Date (between 2007-02-01 and 2007-02-02).
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
sub_dat <- subset(dat, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Format Time column into new Datetime column.
datetime <- paste(as.Date(sub_dat$Date), sub_dat$Time)
sub_dat$Datetime <- as.POSIXct(datetime)

## Plot variation of power usage over a few days (time), overlaying information on sub metering.
with(sub_dat, {
    plot(Sub_metering_1 ~ Datetime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
line_colors <- c("black", "red", "blue")
metering <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", col = line_colors, lty = 1, lwd = 2, legend = metering)
dev.copy(png, file = "plot3.png")
dev.off()