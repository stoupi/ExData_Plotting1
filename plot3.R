library(dplyr)
library(tidyr)

# read data
folder <- getwd()
df <- read.delim(paste0(folder,"/data/household_power_consumption.txt"), header = TRUE, sep = ";", dec = ".")

# create a new column with both date and time
df$fullDate = paste(df$Date,df$Time)
df$fullDate <- strptime(df$fullDate, format = "%d/%m/%Y %H:%M:%S")

# convert Date column in Date class
df$Date <- as.Date(df$Date,"%d/%m/%Y")
df$Time <- strptime(df$Time, format = "%H:%M:%S")

# convert some columns in numerics
df[3:8] <- sapply(df[3:8],as.numeric)

# Creating a subset with the two days of interest
subset <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")

# Replacing ? values with NA
na_if(subset[,3:8],"?")

# Fig 3
png(file = "plot3.png", width = 480, height = 480)
plot(subset$fullDate, subset$Sub_metering_1, type = 'l', col = "black",
     main = "", xlab = "", ylab = "Energy Sub Metering")
lines(subset$fullDate, subset$Sub_metering_2, col = "red")
lines(subset$fullDate, subset$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd=1)
dev.off()





