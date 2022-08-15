
# course notes for Exploratory Data Analysis on Coursera ----


################################################
################ WEEK 1 ########################
################################################


# Principles of Analytic Graphs ----

#' Principle 1: Show Comparisons 
#' * Evidence for a hypothesis is always relative to another competing hypothesis
#' * Always ask "Compared to What?" 
#' 
#' Principle 2: Show Causality, mechanism, explanation, systematic structure 
#' * what is your causal framework for thinking about a question? 
#' 
#' Principle 3: Show multivariate date 
#' * multivariate = more than 2 variables 
#' * the real world is multivariate 
#' * need to "escape flatland"
#' 
#' Principle 4: Integration of evidence 
#' * completely integrate words, numbers, images, diagrams 
#' * data graphics should make use of many modes of data presentation 
#' * don't let the tool drive the analysis
#' 
#' Principle 5: 
#' * a graphic should tell a complete story that is credible
#' 
#' Principle 6: Content is King 
#' * analytic presentations ultimately stand or fall depending on the quality, 
#'   relevance, and integrity of the content 



# Exploratory Graphs (part 1) ----

#' Why do we use graphs in data analysis
#' * to understand data properties 
#' * to find patterns in data
#' * to suggest modeling strategies 
#' * to debug analyses 
#' * to communicate results (later lecture)

#' Characteristics of exploratory graphs 
#' * made quickly 
#' * large number are made
#' * goal is for personal understanding 
#' * axes/legends are generally cleaned up (later)
#' * color/size are primarily used for information 


# Plotting data ---- 

#' Base Plotting System 
#' * artists pallete model 
#' * start with blank canvas and build up from there 
#' * start with plot function (or similar)
#' * use annotation functions to add/modify (text, lines, points, etc...)

#' * convenient, mirrors how we think about building plots and analyzing data 
#' * can't go back once plot has started (ie to adjust margins); need to plan in advance 
#' * difficult to "translate" to others ...


# base plot 
data(mtcars)
with(cars, plot(speed, dist))


#' The Lattice System 
#' * Plots are created with single functino call (xyplot, bwplot, etc.)
#' * most useful for conditioning types of plots: looking at how y changes with x across levels of z 
#' * things like margins/ spacing set automatcially bc entire plot is specified at once 
#' * good for putting many, many plots on a screen 
#' 
#' * sometimes awkward to specify an entire plot in a single function call 
#' * annotation in plot is not especially intuitive 
#' * use of pa.... 

# lattice plot 
library(lattice)
state <- data.frame(state.x77, region = state.region)
# ...


#' ggplot2 system 
#' * splits the difference between base and lattice in a number of ways 
#' * automatically deals with spacing, text, lines but also allows you to ... 

# ggplot2 plot 
library(ggplot2)
data(mpg)
qplot(displ, hwy, data=mpg)



#' The Base Plotting System in R (pt 1)

library(datasets)
hist(airquality$Ozone)

with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month=factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone")


#' Some important Base Graphics Parameters 
#' 
#' * pch: the plotting symbol (default is open circle)
#' * lty: the line type (default is solid line), can be dashed, dotted, etc...
#' * lwd: the line width, specified in integer value 
#' * col: the plotting color, specified as number, string, or hex code: the colors() function ggives you 
#'        a vector of colors by name 
#' * xlab: x label 
#' * ylab: y label 
#' 
#' the par() function is used to specify global graphics parameters that affect all plots in an R session. 
#' these parameters can be overridden when specified as args to specific plotting functions 
#' 
#' * las: the orientation of the axis lables on the plot 
#' * bg: the background color 
#' * mar: the margin size 
#' * oma: the outer margin size (default is 0 for all sides)
#' * mfrow: number of plots per row, column (plots are filled row-wise)
#' * mfcol: bynber if plots per row, column (plots are filled in column-wise)

# default values for global parameters 
par("lty")
par("col")
par("mar")
par("mfrow")



# Base Plotting Functions ---- 

#' Base Plotting functions 
#' * plot() makes a scatterplot, or other type of plot depending on the class of object being plotted 
#' * lines() add lines to a plot, this function just connects the dots 
#' * points() add points to a plot 
#' * text() add text labels to plot using specified x,y coordinates
#' * title() add annotations to x,y, axis labels, title, etc... 
#' * mtext() add arbitrary text to the margins (inner or outer) of plot 
#' * axis() adding axis ticks/labels

library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind from NYC")

#  pplot with title 
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col="blue"))

# plot with annotation
  # type = "n" makes you start with empty plot! 
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC", 
                      type="n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col="red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Not May"))

# base plot with regression line 
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC", 
                      pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)


# Multiple base plots 
par(mfrow = c(1,2))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})


par(mfrow = c(1,3), mar=c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "ozone and Temp")
  mtext("Ozone and Weather in NYC", outer = TRUE)
})


# Base Plotting Demonstration ----

par(mfrow = c(1,1))
x = rnorm(100)
hist(x)

y <- rnorm(100)
plot(x,y)
z <- rnorm(100)
plot(x,z)
plot(x,y)

# adjust margins 
par(mar  = c(2,2,2,2))
plot(x,y)
par(mar  = c(4,4,2,2))
plot(x,y)

# chnage plot symbol
plot(x,y, pch = 20)
plot(x,y, pch = 19)
plot(x,y, pch = 2)
plot(x,y, pch = 3)
plot(x,y, pch = 4)

plot(x,y, pch =20)
title("Scatterplot")
text(-2, -2, "label")
legend("topright", legend = "Data", pch = 20)

fit <- lm(y ~x)
abline(fit, col = "blue", lwd = 3)

plot(x,y, ,xlab = "weight", ylab = "height", main = "scatterplot", pch = 20)
legend("topright", legend = "Data", pch = 20)
abline(fit, lwd = 2, col = "red")

z <- rpois(100, lambda = 2)
par(mfrow=c(2,1))

plot(x,y, pch = 20)
plot(x,z, pch = 19)

par(mar = c(2,2,1,1))
plot(x,y, pch = 20)
plot(x,z, pch = 19)

par(mfrow = c(1,1))

# Male vs Female Example 
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50, labels = c("Male", "Female"))
str(g)

plot(x,y)
plot(x,y, type= "n") # creates empty plot without data 
points(x[g == "Male"], y[g == "Male"], col = "green")
points(x[g == "Female"], y[g == "Female"], col = "blue")


# Graphics Device ----


library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Eruptions")


# Graphics File Devices ---- 

# there are 2 basic types of file devices: vector and bitmap devices 

#' Vector Formats: 
#' * pdf: useful for line-type graphics, resizes well, usually portable, not efficient 
#'        if the plot has many objects/points
#' * svg: XML-based scalable vector graphics; supports animation and interactivity, 
#'        potentially useful for web-based plots
#' * win.metafile: 
#' * postscript: 

#' Bitmap Formats: 
#' * png: bitmapped format, good for line drawings or images with solid colors, 
#'        uses lossless comporession.  most web browsers can read, 
#'        good for plotting many many many points, does not resize well
#' * jpeg: good for photographs or natural scenes, uses lossy compression, 
#'         good for plotting many many points, doesn't resize well, 
#'         not great for line drawings
#' * tiff: 
#' * bmp: a native Windows bitmapped format


# Multiple Open Graphics Devices 
  # it's possible to open multiple graphics devices 
  # plotting can only occur on one graphics device at a time 
  

# copying plots 
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Eruptions")
dev.copy(png, file = "geyserplot.png")
dev.off()
