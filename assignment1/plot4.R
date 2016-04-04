### Programming Assignment 1 - Exploratory Data Analysis
### Plot 4 - 4 plots showing various metrics over time.

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

## Specify 2x2 grid of plots showing various metrics.
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(sub_dat, {
    plot(Global_active_power ~ Datetime, type = "l", ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
    legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ Datetime, type = "l", ylab = "Global_rective_power", xlab = "datetime")
})
dev.copy(png, file = "plot4.png")
dev.off()