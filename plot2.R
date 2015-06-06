# Martin Bontrager
# Exploratory Data Analysis
# Project 1 - plot2

library(data.table)

# Read power consumption data and subset to only two days: 1-2 Feb 2007
f <- "data/household_power_consumption.txt"
DT <- fread(f, sep = ";", na.strings = "?", stringsAsFactors = FALSE, 
            header = TRUE)
DT$Date <- as.Date(DT$Date,format =  "%d/%m/%Y")
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
DT2 <- subset(DT, subset = (DT$Date >= date1 & DT$Date <= date2))
DT2$datetime <- as.POSIXct(paste(DT2$Date, DT2$Time), 
                           format = "%Y-%m-%d %H:%M:%S")

# Generate a line graph of global active power over time.
png(filename = "plot2.png", width = 480, height = 480)
DT2$Global_active_power <- as.numeric(DT2$Global_active_power)
plot(x = DT2$datetime, y=DT2$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
