
# EDA Course Assignment Week 1 
# Plot 1 

# import and observe data ----
df <- read.delim(file = "./data/household_power_consumption.txt", 
                 sep = ";")

# observe data 
head(df)
str(df)

# tidy Date Field for filtering 
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# tidy and filter target subset ---- 
plotdf <- subset(df, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
plotdf$Global_active_power[plotdf$Global_active_power == "?"] <- NA
plotdf$Global_active_power <- as.numeric(plotdf$Global_active_power)


# create and save plot ----
png(filename = "plot1.png", 
    width = 480, 
    height = 480)

hist(plotdf$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")

dev.off()
