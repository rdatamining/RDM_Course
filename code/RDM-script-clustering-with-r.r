## ----author info, include=F----------------------------------------------
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    9 December 2018

## ----load libraries, include=F, echo=F-----------------------------------
## load required packages
library(fpc) # for dbscan, pamk and kmeansruns
library(cluster) # for pam, diana and clara

## ------------------------------------------------------------------------
str(iris)

## ------------------------------------------------------------------------
summary(iris)

## ------------------------------------------------------------------------
## set a seed for random number generation to make the results reproducible
set.seed(8953) 
## make a copy of iris data
iris2 <- iris
## remove the class label, Species
iris2$Species <- NULL
## run kmeans clustering to find 3 clusters
kmeans.result <- kmeans(iris2, 3)

## ----eval=F--------------------------------------------------------------
## ## print the clusterng result
## kmeans.result

## ----echo=F--------------------------------------------------------------
kmeans.result

## ------------------------------------------------------------------------
table(iris$Species, kmeans.result$cluster)

## ----out.width=".8\\textwidth", out.height="0.8\\textheight", tidy=F, crop=T----
plot(iris2[, c("Sepal.Length", "Sepal.Width")], 
     col = kmeans.result$cluster)
points(kmeans.result$centers[, c("Sepal.Length", "Sepal.Width")], 
       col = 1:3, pch = 8, cex=2) # plot cluster centers

## ------------------------------------------------------------------------
library(fpc)
kmeansruns.result <- kmeansruns(iris2)
kmeansruns.result

## ------------------------------------------------------------------------
library(cluster)
# group into 3 clusters
pam.result <- pam(iris2, 3) 
# check against actual class label
table(pam.result$clustering, iris$Species) 

## ----eval=F--------------------------------------------------------------
## plot(pam.result)

## ----echo=F, fig.width=9, fig.height=4.5, out.width="\\textwidth", out.height="0.9\\textheight"----
layout(matrix(c(1,2),1,2)) # 2 graphs per page 
plot(pam.result)
layout(matrix(1)) # change back to one graph per page 

## ------------------------------------------------------------------------
library(fpc)
pamk.result <- pamk(iris2)
# number of clusters
pamk.result$nc
# check clustering against actual class label
table(pamk.result$pamobject$clustering, iris$Species)

## ----eval=F--------------------------------------------------------------
## plot(pamk.result)

## ----echo=F, fig.width=9, fig.height=6, out.width="\\textwidth", out.height="0.9\\textheight"----
layout(matrix(c(1,2),1,2)) # 2 graphs per page 
plot(pamk.result$pamobject)
layout(matrix(1)) # change back to one graph per page 

## ----fig.show='hide'-----------------------------------------------------
set.seed(2835)
# draw a sample of 40 records from the iris data, so that the clustering plot will not be over crowded
idx <- sample(1:dim(iris)[1], 40)
iris3 <- iris[idx,]
# remove class label
iris3$Species <- NULL
# hierarchical clustering
hc <- hclust(dist(iris3), method="ave")
# plot clusters
plot(hc, hang = -1, labels=iris$Species[idx])
# cut tree into 3 clusters
rect.hclust(hc, k=3)
# get cluster IDs
groups <- cutree(hc, k=3)

## ----echo=F, fig.width=8, fig.height=6, out.width="\\textwidth", out.height="\\textheight"----
plot(hc, hang = -1, labels=iris$Species[idx])
rect.hclust(hc, k=3) # cut tree into 3 clusters

## ------------------------------------------------------------------------
library(cluster)
diana.result <- diana(iris3)

## ----eval=F--------------------------------------------------------------
## plot(diana.result, which.plots=2, labels=iris$Species[idx])

## ----echo=F--------------------------------------------------------------
plot(diana.result, which.plots=2, labels=iris$Species[idx])

## ------------------------------------------------------------------------
library(fpc)
iris2 <- iris[-5] # remove class tags
ds <- dbscan(iris2, eps=0.42, MinPts=5)
ds

## ------------------------------------------------------------------------
# compare clusters with actual class labels
table(ds$cluster, iris$Species)

## ----out.width=".95\\textwidth", out.height=".95\\textheight"------------
plot(ds, iris2)

## ----out.width=".95\\textwidth", out.height=".95\\textheight"------------
plot(ds, iris2[, c(1,4)])

## ----out.width=".95\\textwidth", out.height=".95\\textheight"------------
plotcluster(iris2, ds$cluster)

## ----tidy=F--------------------------------------------------------------
# create a new dataset for labeling
set.seed(435) 
idx <- sample(1:nrow(iris), 10)
# remove class labels
new.data <- iris[idx,-5]
# add random noise
new.data <- new.data + matrix(runif(10*4, min=0, max=0.2), 
                              nrow=10, ncol=4)
# label new data
pred <- predict(ds, iris2, new.data) 

## ------------------------------------------------------------------------
table(pred, iris$Species[idx]) # check cluster labels

## ----out.width=".95\\textwidth", out.height=".95\\textheight"------------
plot(iris2[, c(1,4)], col=1+ds$cluster)
points(new.data[, c(1,4)], pch="+", col=1+pred, cex=3)

