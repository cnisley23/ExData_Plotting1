
# EDA Course Assignment Week 1 
# Plot 2 

# import and observe data ----
df <- read.delim(file = "./data/household_power_consumption.txt", sep = ";")

# observe data 
head(df)
str(df)

# tidy Date Field for filtering 
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# tidy and filter target subset ---- 
plotdf <- subset(df, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
plotdf$Global_active_power <- as.numeric(plotdf$Global_active_power)
plotdf$DateTime <- as.POSIXct(paste(plotdf$Date, plotdf$Time), 
                          format = "%Y-%m-%d %H:%M:%S")

# create and save plot ----
png(filename = "plot2.png", 
    width = 480, 
    height = 480)

with(plotdf, 
     plot(x = DateTime, 
          y = Global_active_power, 
          xlab = NA, 
          ylab = "Global Active Power (kilowatts)", 
          type = "l")
     )

dev.off()
