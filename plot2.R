# Download the Electric power consumption file from
# the link in the assignment - I would include the link here,
# or even automate the process of getting and unzipping the data,
# but I'm not sure if that's allowed / welcome.
#
# Unzip the data to a file called household_power_consumption.txt

library(dplyr)
library(data.table)
library(lubridate)

hpc <- fread("household_power_consumption.txt", 
             sep = ";",
             na.strings = "?", 
             header = TRUE) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Datetime = parse_date_time(paste(Date, Time, sep = " "), "d/m/Y H!:M!:S!"),
         Global_active_power = as.numeric(Global_active_power),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Voltage = as.numeric(Voltage),
         Global_intensity = as.numeric(Global_intensity),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3))

png(filename = "plot2.png", width = 480, height = 480, bg = "white")

plot(hpc$Datetime, 
     hpc$Global_active_power, 
     type = "l", 
     xlab = "", 
     main = "", 
     ylab = "Global Active Power (kilowatts)")

dev.off()