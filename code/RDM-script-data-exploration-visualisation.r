## ----author info, include=F----------------------------------------------
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    7 December 2018

## ------------------------------------------------------------------------
# number of rows
nrow(iris)
# number of columns
ncol(iris)
# dimensionality
dim(iris)
# column names
names(iris)

## ------------------------------------------------------------------------
str(iris)

## ------------------------------------------------------------------------
attributes(iris)

## ------------------------------------------------------------------------
iris[1:3,]
head(iris, 3)
tail(iris, 3)

## ------------------------------------------------------------------------
iris[1:10, "Sepal.Length"]
iris$Sepal.Length[1:10]

## ------------------------------------------------------------------------
summary(iris)

## ------------------------------------------------------------------------
library(Hmisc)
# describe(iris) # check all columns
describe(iris[, c(1,5)]) # check columns 1 and 5

## ------------------------------------------------------------------------
range(iris$Sepal.Length)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, c(.1, .3, .65))

## ----out.width=".6\\textwidth", out.height="0.6\\textwidth"--------------
var(iris$Sepal.Length)
hist(iris$Sepal.Length)

## ----out.width=".7\\textwidth", out.height="0.7\\textwidth"--------------
library(magrittr) ## for pipe operations
iris$Sepal.Length %>% density() %>% plot(main='Density of Sepal.Length')

## ----out.width=".4\\textwidth", crop=T-----------------------------------
library(dplyr)
set.seed(123)
iris2 <- iris %>% sample_n(20)
iris2$Species %>% table() %>% pie()
# add percentages
tab <- iris2$Species %>% table()
precentages <- tab %>% prop.table() %>% round(3) * 100
txt <- paste0(names(tab), '\n', precentages, '%')
pie(tab, labels=txt)

## ----out.width=".49\\textwidth"------------------------------------------
iris2$Species %>% table() %>% barplot()
# add colors and percentages
bb <- iris2$Species %>% table() %>% 
      barplot(axisnames=F, main='Species', ylab='Frequency',
              col=c('pink', 'lightblue', 'lightgreen'))
text(bb, tab/2, labels=txt, cex=1.5)

## ------------------------------------------------------------------------
cov(iris$Sepal.Length, iris$Petal.Length)
cor(iris$Sepal.Length, iris$Petal.Length)
cov(iris[,1:4])
# cor(iris[,1:4])

## ------------------------------------------------------------------------
aggregate(Sepal.Length ~ Species, summary, data=iris)

## ----out.width=".56\\textwidth", crop=T----------------------------------
boxplot(Sepal.Length ~ Species, data=iris)

## ----tidy=F, out.width=".7\\textwidth", out.height="0.7\\textwidth"------
with(iris, plot(Sepal.Length, Sepal.Width, col = Species, 
                pch = as.numeric(Species)))

## ----out.width=".7\\textwidth", out.height="0.7\\textwidth"--------------
with(iris, plot(jitter(Sepal.Length), jitter(Sepal.Width), col=Species, 
                pch=as.numeric(Species)))

## ----out.width=".7\\textwidth", out.height="0.7\\textwidth"--------------
pairs(iris)

## ----out.width=".7\\textwidth", out.height="0.7\\textwidth"--------------
library(scatterplot3d)
scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)

## ----eval=F, out.width=".9\\textwidth", out.height="0.9\\textwidth"------
## library(rgl)
## plot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)

## ----out.width=".65\\textwidth", out.height="0.65\\textwidth"------------
dist.matrix <- as.matrix(dist(iris[,1:4]))
heatmap(dist.matrix)

## ----out.width=".55\\textwidth"------------------------------------------
library(lattice)
levelplot(Petal.Width ~ Sepal.Length * Sepal.Width, 
          data=iris, cuts=8)

## ----out.width=".75\\textwidth"------------------------------------------
filled.contour(volcano, color=terrain.colors, asp=1, 
               plot.axes=contour(volcano, add=T))

## ----out.width="\\textwidth"---------------------------------------------
persp(volcano, theta=25, phi=30, expand=0.5, col="lightblue")    

## ----out.width=".85\\textwidth"------------------------------------------
library(MASS)
parcoord(iris[1:4], col=iris$Species)

## ----out.width=".7\\textwidth", out.height="0.7\\textwidth"--------------
library(lattice)
parallelplot(~iris[1:4] | Species, data=iris)

## ----out.width=".6\\textwidth"-------------------------------------------
library(ggplot2)
qplot(Sepal.Length, Sepal.Width, data=iris, facets=Species ~.)

## ----eval=FALSE----------------------------------------------------------
## # save as a PDF file
## pdf("myPlot.pdf")
## x <- 1:50
## plot(x, log(x))
## graphics.off()
## #
## # Save as a postscript file
## postscript("myPlot2.ps")
## x <- -20:20
## plot(x, x^2)
## graphics.off()

## ----eval=FALSE----------------------------------------------------------
## ggsave('myPlot3.png')
## ggsave('myPlot4.pdf')
## ggsave('myPlot5.jpg')
## ggsave('myPlot6.bmp')
## ggsave('myPlot7.ps')
## ggsave('myPlot8.eps')

