### Programming Assignment 1 - Exploratory Data Analysis
### Plot 2 - Simple plot of global active power over time.

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

## Plot variation of power usage over a few days (time).
plot(sub_dat$Global_active_power ~ sub_dat$Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png")
dev.off()