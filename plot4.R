# Martin Bontrager
# Exploratory Data Analysis
# Project 1 - plot4

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

# Generate multiple plots summarizing the power usage data
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(DT2, plot(datetime, Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power"))
with(DT2, plot(datetime, Voltage, type = "l"))
plot(DT2$datetime, DT2$Sub_metering_1, type = "l", xlab = "", 
               ylab = "Energy sub metering")
lines(DT2$datetime, DT2$Sub_metering_2, col = "red")
lines(DT2$datetime, DT2$Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "blue", "red"), 
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(DT2, (plot(datetime, Global_reactive_power, type = "l")))
dev.off()
