### Programming Assignment 1 - Exploratory Data Analysis
### Plot 1 - Histogram of frequency of usage of power at various levels.

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

## Plot histogram of frequency of use.
hist(sub_dat$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()