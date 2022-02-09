library(dplyr)
library(tidyr)

# read data
folder <- getwd()
df <- read.delim(paste0(folder,"/data/household_power_consumption.txt"), header = TRUE, sep = ";", dec = ".")

head(df)
# convert Date column in Date class
df$Date <- as.Date(df$Date,"%d/%m/%Y")

# Creating a subset with the two days of interest
subset <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")

# Replacing ? values with NA
na_if(subset[,2:7],"?")

