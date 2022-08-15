
myfunction <- function(x) {
  
  x <- rnorm(100)
  mean(x)
  
}

# add a little random noise to a number 
second <- function(x) {
  
  x + rnorm(length(x))
}

second(4)
second(4:10)
