
# hierarchical clustering ----

# clustering organizes things that are "close" into groups 
  # how do we define close? 
  # how do we group things? 
  # how do we visualize the grouping? 
  # how do we interpret the grouping? 

# hierarchical clustering is hugely important


#### Hierarchical clustering 

#' An agglomerative approach 
#' * find closest two things 
#' * put them together 
#' * find next closest

#' Requires: 
#' * a defined distance
#' * a merging approach 

#' Produces: 
#' * a tree showing how close things are to each other  


## How do we define close? ##

# Most important step: 
  # garbage in/garbage out 

# Distance or similarity 
  # continuous - euclidean distance 
  # continuous - correlation similarity 
  # Binary - manhattan distance 

# Pick a distance/similarity that makes sense for your problem 


# Example Distances - Euclidean 

  # 2 dimensional euc distance: sqrt((X1 - X2)^2 + (Y1 - Y2)^2)
  # in general: = sqrt((A1-A2)^2 + (B1 - B2)^2 + ... + (Z1 -Z2)^2)


# Example Distances - Manhattan 

  # distance on a grid system
  # in general: abs(A1 - A2) + abs(B1 - B2) + ... + abs(Z1 - Z2)



# Hierarchical Clustering - Example ----

set.seed(1234)

x <- rnorm(12, mean = rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)

plot(x, y, col = "blue", pch = 19, cex = 2)
text(x +0.05, y + 0.05, labels = as.character(1:12))

# dist() : generates distance matrix providing all pairwise distances 
df <- data.frame(x =x , y = y) 
dist(df)
distxy = dist(df) 

# run hierarchical clustering and create dendogram
hClustering <- hclust(distxy)
plot(hClustering)


# Prettier dendograms 

myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)))

  
  
# heatmap() ----

set.seed(143)
df_matrix <- as.matrix(df)[sample(1:12), ]
heatmap(df_matrix)



#### K-Means Clustering ---- 

  # hwo do we define close? 
  # how do we group things? 
  # how do we visualize the grouping? 
  # how do we interpret the grouping? 

# How do we define close? 

    # most important step 
  # Distance or Similarity
    # continuous - euclidean distance 
    # continuous - correlation similarity 
    # binary - manhattan distance 
  # pick a distance/similarity that makes sense for your problem 


# K-means clustering 
#' A partioning approach 
#'  * fix a number of clusters 
#'  * get "centroids" of each cluster 
#'  * assign things closest to centroid 
#'  * recalculatte centroids 

#' Requires 
#'  * a defined distance metric 
#'  * a number of clusters 
#'  * an initial guess as to cluster centroids 

#' Produces 
#'  * final estimate of cluster centroids 
#'  * an assignment of each point to clusters 


# kmeans example 
set.seed(1234)

x <- rnorm(12, mean = rep(1:3, each = 4), sd =0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd =0.2)

plot(x,y, col="blue", pch=19, cex = 2)
text(x + 0.05, y +0.05, labels = as.character(1:12))

# kmeans clustering - assign to closest centroid 
# kmeans clustering - recalculate centroid 
# kmeans clustering - reassign values 

# kmeans()

# important parameters: x, centers, iter.max, nstart

df <- data.frame(x,y)
kmeans_df <- kmeans(df, centers=3)
names(kmeans_df)

kmeans_df$cluster

plot(x,y, col = kmeans_df$cluster, pch=19, cex=2)
points(kmeans_df$centers, col = 1:3, pch = 3, cex = 3, lwd=3)

# visualizing using heatmaps 
set.seed(1234)

df_matrix = as.matrix(df)[sample(1:12), ]
kmeans_df2 = kmeans(df_matrix, centers = 3)

par(mfrow = c(1,2))
image(t(df_matrix)[, nrow(df_matrix):1], yaxt = "n")
image(t(df_matrix)[, order(kmeans_df2$cluster)], yaxt = "n")




# Dimension Reduction ----



  #' PRINCICPLE COMPONENT ANALYSIS 
  #' SINGULAR VALUE DECOMPOSITION 
  
# matrix data 
set.seed(12345)
df_matrix = matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(df_matrix)[, nrow(df_matrix):1])

# run hierarchical cluster of data 
heatmap(df_matrix)

# what if we add a pattern?? 
set.seed(678910)
for (i in 1:40) {
  
  #flip a coin 
  coinFlip = rbinom(1, size = 1, prob = 0.5)
  
  # if coin is heads add a common pattern to that row 
  if(coinFlip) {
    df_matrix[i, ] = df_matrix[i, ] + rep(c(0,3), each = 5)
  }
  
}

image(1:10, 1:40, t(df_matrix)[, nrow(df_matrix):1])
heatmap(df_matrix)


# Patterns in Rows and Columns 
hh <- hclust(dist(df_matrix))
df_matrix_ordered <- df_matrix[hh$order, ]

par(mfrow = c(1,3))
image(t(df_matrix_ordered)[, nrow(df_matrix_ordered):1])
plot(rowMeans(df_matrix_ordered), 40:1, xlab="Row Mean", ylab = "Row", pch = 19)
plot(colMeans(df_matrix_ordered), xlab = "Column", ylab = "Column Mean", pch = 19)


# Related Solutions - PCA/SVD ----

# Single Value Decomposition (SVD)
  # if X is a matrix with each variable in a column and each observation in a row, 
    # then the SVD is a "matrix decomposition" 

  # X = UDV^T
  # where the columns of U are orthogonal (left singular vectors), 
    # and the columns of V are orthogonal (right singular vectors), 
    # and D is a diagonal matrix (singular values)

# Principal Component Analysis (PCA)
  # The principle components are equal to the right singular values if you first
    # scale (subtract the mean, divide by the standard deviation) the variables 


# Components of the SVD - u and v 

svd1 <- svd(scale(df_matrix_ordered))
par(mfrow = c(1,3))
image(t(df_matrix_ordered)[, nrow(df_matrix_ordered):1])
plot(svd1$u[, 1], 40:1, xlab = "Row", ylab = "First left singular vector", pch = 19)
plot(svd1$v[, 1], xlab = "Column", ylab = "First right singular vector", pch = 19)


# Components of the SVD - variance explained
par(mfrow = c(1,2))
plot(svd1$d, xlab = "Column", ylab = "Singular Value", pch = 19)
plot(svd1$d^2 / sum(svd1$d^2), xlab = "Column", ylab = "Prop of variance explained", pch = 19)


# relationship to principal components 
svd1 <- svd(scale(df_matrix_ordered))
pca1 <- prcomp(df_matrix_ordered, scale. = TRUE)
plot(pca1$rotation[, 1], svd1$v[, 1], pch = 19, 
     xlab = "Principal Component 1", 
     ylab = "Right Singular Vector 1")
abline(c(0,1))


# Components of the SVD - variance explained
constant_matrix = df_matrix_ordered + 0

for (i in 1:dim(df_matrix_ordered)[1]) {
  constant_matrix[i, ] <- rep(c(0,1), each=5)
}

svd1 <- svd(constant_matrix)
par(mfrow = c(1,3))
image(t(constant_matrix)[, nrow(constant_matrix):1])
plot(svd1$d, xlab="Column", ylab="Singular Value", pch=19)
plot(svd1$d^2 / sum(svd1$d^2), xlab = "Column", ylab = "Prop of variance explained", pch = 19)


# What if we add a second pattern? 

set.seed(678910)
for(i in 1:40) {
  
  # flip a coin 
  coinFlip1 = rbinom(1, size = 1, prob = 0.5)
  coinFlip2 = rbinom(1, size = 1, prob = 0.5)
  
  # if coin is heads add a common pattern to that row 
  if (coinFlip1) {
    df_matrix[i, ] <- df_matrix[i, ] + rep(c(0,5), each = 5)
  }
  
  if (coinFlip2) {
    df_matrix[i, ] <- df_matrix[i, ] + rep(c(0,5), 5)
  }
  
}

hh <- hclust(dist(df_matrix))
df_matrix_ordered <- df_matrix[hh$order, ]

# singular value decomposition - true patterns 
svd2 <- svd(scale(df_matrix_ordered))
par(mfrow = c(1,3))

image(t(df_matrix_ordered)[, nrow(df_matrix_ordered):1])
plot(rep(c(0,1), each = 5), pch = 19, xlab="Column", ylab="Pattern 1")
plot(rep(c(0,1), 5), pch = 19, xlab = "column", ylab="Pattern 2")


# v and patterns of variance in rows 
svd2 <- svd(scale(df_matrix_ordered))
par(mfrow = c(1,3))

image(t(df_matrix_ordered)[, nrow(df_matrix_ordered):1])
plot(svd2$v[, 1], xlab = "Column", ylab = "First right singular vector")
plot(svd2$v[, 2], pch = 19, xlab = "Column", ylab = "Second right singular vector")


# d and variance explained 
svd1 <- svd(scale(df_matrix_ordered))
par(mfrow = c(1,2))

plot(svd1$d, xlab = "Column", ylab = "Singular value", pch=19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Percent of Variance explained", 
     pch = 19)


# one problem with SVD and PCA is MISSING VALUES 

df_matrix_2 <- df_matrix_ordered

# randomly insert some missing data 
df_matrix_2[sample(1:100, size=40, replace=FALSE)] <- NA
svd1 <- svd(scale(df_matrix_2))


# Inputting {impute}



### Working with Color in R Plots (part 1) ---- 




