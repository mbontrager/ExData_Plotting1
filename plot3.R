# Martin Bontrager
# Exploratory Data Analysis
# Project 1 - plot3

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

# Generate a line Energy sub metering over time.
png(filename = "plot3.png", width = 480, height = 480)
with(DT2, plot(datetime, Sub_metering_1, type = "l", xlab = "", 
               ylab = "Energy sub metering"))
with(DT2, lines(datetime, Sub_metering_2, col = "red"))
with(DT2, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
