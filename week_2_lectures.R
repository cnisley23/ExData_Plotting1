
# Lattice Plotting System (pt 1) ----

library(lattice)

#' * lattice: contains code for producing Trellis graphics, which are independent 
#'           of the 'base' graphics system; functions like xyplot(), bwplot(), levelplot()
#' * grid: implements a fdifferent graphing system indepenent of base system; 
#'         the lattice builds on top of lattice


#' Lattice Functions 
#' * xyplot: scatterplots
#' * bwplot: box aand whiskers ("boxplots")
#' * histogram:
#' * stripplot: like boxplots but with actual points
#' * dotplot: plot dots on "violin strings"
#' * splom: scatterplot matrix, like pairs() in base plot system 
#' * levelplot, contourplot: for plotting "image" data    

# xyplot() ----
# xyplot( y ~ x | f* g, data) 
# use formula notation, hence the ~. 
# y-axis is left of the ~, on the right is the x-axis
# f and g are conditioning variables, they are optional
  ### the * indicates an interaction between the 2
# second argument is data (list or df)

library(lattice)
library(datasets)

# simple plot 
xyplot(Ozone ~ Wind, data = airquality)

# create a multi-dimensional panel based on Month
# convert month to factor 
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# lattice functions behave differently than base graphics functions in 1 critical way: 
#' * base graphics functions plot data directly to graphics device (ie screen, pdf file, etc...)
#' * lattice graphs functions return an object of class "trellis" 
#' * yadda yadda yadda

# lattice behavior cont'd
p <- xyplot(Ozone ~ Wind, data = airquality)  # nothing happens
print(p)
xyplot(Ozone ~ Wind, data = airquality)  # auto printing


# lattice functions have a "panel function" which controls what happens inside each panel of the plot 
# the lattice packagge comes with default panel functions, but you can supply your own if you 
      # want to customize what happens in each panel 
# panel functions recieve the x/y coordinates of the data points in their panel (along with any optional args)


# customize panel functions ----

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f *x + rnorm(100, sd=0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2,1)) # plot with 2 panels

# customize panel function 
xyplot(y ~x | f, panel= function(x, y, ...) {
  panel.xyplot(x, y, ...) ## first call of the default panel function for 'xyplot'
  panel.abline(h = median(y), lty = 2) # add horizontal line at median
})


# customize panel function 
xyplot(y ~x | f, panel= function(x, y, ...) {
  panel.xyplot(x, y, ...) ## first call of the default panel function for 'xyplot'
  panel.lmline(x, y, col=2) # add regression line to plots
})



# ggplot2 package ---- 

# an implementation of the "Grammar of Graphics" by Leland Wilkinson
# Written by Hadley Wickham (while a grad student at Iowa State)
# 3rd graphics system (along with base and lattice)

# what is ggplot2? 
#; grammar of graphics represents and abstraction of graphics ideas/... 


# the basics: qplot()
#' works much like plot() in base
#' looks for data in a data.frmae, similar to lattice, or in parent environment 
#' plots are made up of aesthitics (size, shape, color) and geoms(points, lines)
#' * factors are important bc they indicate subsets of data; they should be labeled
#' the qplot() hides what goes on underneath, which is okay for most operations
#' ggplot() is the core function and very flexible for doing things qplot() cannot do


library(ggplot2)
str(mpg)

qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

# make hist 
qplot(hwy, data = mpg, fill = drv)

# facets 
  # notice that variables on right of ~ determine columns and left determines rows
qplot(displ, hwy, data = mpg, facets = .~drv)
qplot(hwy, data = mpg, facets = drv~., binwidth = 2)


# ggplot2 plotting system - part 2 ---- 

#' COMPONENTS OF GGPLOT2
#' * data.frame
#' * aesthetic mappings: how data are mapped to color/size
#' * geoms: geometric objects like points, likes, shapes 
#' * facets: for conditional plots 
#' * stats: stat transformations like binning, quantiles, smoothing, etc...
#' * scales: what scale an aesthetic map uses (example: male = red, female = blue)
#' * coordinate system 

# plots are built in layers
  # plot data 
  # overlay a summary 
  # metadata and annotation


# base vs ggplot - AXIS LIMITS 
testdf <- data.frame(x = 1:100, y = rnorm(100))
testdf[50,2] <- 100 ## adding an outlier! 

plot(testdf$x, testdf$y, type = "l", ylim = c(-3,3))
g <- ggplot(testdf, aes(x, y))
g + geom_line()

# axis limits cause different subsets of data!!! 
g + geom_line() + ylim(-3,3)  ## creates a subset of data within this range!!!
g + geom_line() + coord_cartesian(ylim = c(-3,3))  ## includes outlier!!! 

# use *coord_cartesian()* to include values outside of axis limits defined!!


# Making Tertiles (cutting data) ----

# calculate the deciles of the data 
cutpoints <- quantile(maacs$logno2_new, seq(0,1, length= 4), na.rm=T)

# cut the data at the deciles and create a new factor variable 
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)

# see the levels of the newly created factor variable 
levels(maacs$no2dec)



