
# EDA Course Assignment Week 1 
# Plot 3 

# import and observe data ----
df <- read.delim(file = "./data/household_power_consumption.txt", sep = ";")

# observe data 
head(df)
str(df)

# tidy Date Field for filtering 
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# tidy and filter target subset ---- 
plotdf <- subset(df, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
plotdf$DateTime <- as.POSIXct(paste(plotdf$Date, plotdf$Time), 
                              format = "%Y-%m-%d %H:%M:%S")
plotdf[, 7:9] <- lapply(plotdf[, 7:9], function(x) {as.numeric(x)})


# create and save plot ----

# comparing multiple variables, choose largest value for plot (y-axis)
yaxis <- plotdf[, grep("^Sub_metering_", colnames(plotdf))]
yaxis <- yaxis[, which.max(c(max(yaxis$Sub_metering_1), 
                             max(yaxis$Sub_metering_2), 
                             max(yaxis$Sub_metering_3)))]

png(filename = "plot3.png", 
    width = 480, 
    height = 480)

with(plotdf, 
     plot(x = DateTime, 
          y = yaxis, 
          xlab = NA, 
          ylab = "Energy Sub Metering", 
          type = "n"
          )
     )

with(plotdf, 
     lines(x = DateTime, 
           y = Sub_metering_1, 
           col = "black")
)

with(plotdf, 
     lines(x = DateTime, 
           y = Sub_metering_2, 
           col = "red")
)

with(plotdf, 
     lines(x = DateTime, 
           y = Sub_metering_3, 
           col = "blue")
)

legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
