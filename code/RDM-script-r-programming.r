## ----author info, include=F----------------------------------------------
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    7 December 2018

## ----vector, out.height=".9\\textheight"---------------------------------
## integer vector
x <- 1:10
print(x)
## numeric vector, generated randomly from a uniform distribution
y <- runif(5)
y
## character vector
(z <- c("abc", "d", "ef", "g"))

## ----matrix, out.height=".9\\textheight"---------------------------------
## create a matrix with 4 rows, from a vector of 1:20
m <- matrix(1:20, nrow=4, byrow=T)
m
## matrix subtraction
m - diag(nrow=4, ncol=5)

## ----dataframe, out.height=".9\\textheight"------------------------------
library(magrittr)
age <- c(45, 22, 61, 14, 37)
gender <- c("Female", "Male", "Male", "Female", "Male")
height <- c(1.68, 1.85, 1.80, 1.66, 1.72)
married <- c(T, F, T, F, F)
df <- data.frame(age, gender, height, married) %>% print()
str(df)

## ----list, out.height=".9\\textheight"-----------------------------------
x <- 1:10
y <- c("abc", "d", "ef", "g")
ls <- list(x, y) %>% print()
## retrieve an element in a list
ls[[2]]
ls[[2]][1]

## ----if------------------------------------------------------------------
score <- 4
if(score>=3) {
  print("pass") 
} else {
  print("fail")
}

## ----ifelse--------------------------------------------------------------
score <- 1:5
ifelse(score>=3, "pass", "fail")

## ----for loop------------------------------------------------------------
for (i in 1:5) {
  print(i ^ 2)
}

## ----loop and lapply, out.height=".9\\textheight"------------------------
## for loop
x <- 1:10
y <- rep(NA, 10)
for(i in 1:length(x)) {
  y[i] <- log(x[i])
}
y
## apply a function (log) to every element of x
tmp <- lapply(x, log)
y <- do.call("c", tmp) %>% print()

## ----parallel computing, eval=F, out.height=".9\\textheight", tidy=FALSE----
## ## on Linux or Mac machines
## library(parallel)
## n.cores <- detectCores() - 1 %>% print()
## tmp <- mclapply(x, log, mc.cores=n.cores)
## y <- do.call("c", tmp)
## 
## ## on Windows machines
## library(parallel)
## ## set up cluster
## cluster <- makeCluster(n.cores)
## ## run jobs in parallel
## tmp <- parLapply(cluster, x, log)
## ## stop cluster
## stopCluster(cluster)
## # collect results
## y <- do.call("c", tmp)

## ----parallel on Windows, eval=F, out.height=".9\\textheight", tidy=FALSE----
## ## on Windows machines
## library(parallel)
## ## set up cluster
## cluster <- makeCluster(n.cores)
## ## load required libraries, if any, on all nodes
## tmp <- clusterEvalQ(cluster, library(igraph))
## ## export required variables, if any, to all nodes
## clusterExport(cluster, "myvar")
## ## run jobs in parallel
## tmp <- parLapply(cluster, x, myfunc)
## ## stop cluster
## stopCluster(cluster)
## # collect results
## y <- do.call("c", tmp)

## ----function------------------------------------------------------------
average <- function(x) {
  y <- sum(x)
  n <- length(x)
  z <- y / n
  return(z)
}

## calcuate the average of 1:10
average(1:10)

## ----R native format-----------------------------------------------------
a <- 1:10
save(a, file="./data/dumData.Rdata")
rm(a)
a
load("./data/dumData.Rdata")
a

## ----CSV-----------------------------------------------------------------
# create a data frame
var1 <- 1:5
var2 <- (1:5) / 10
var3 <- c("R", "and", "Data Mining", "Examples", "Case Studies")
df1 <- data.frame(var1, var2, var3)
names(df1) <- c("VarInt", "VarReal", "VarChar")
# save to a csv file
write.csv(df1, "./data/dummmyData.csv", row.names = FALSE)
# read from a csv file
df2 <- read.csv("./data/dummmyData.csv")
print(df2)

## ----Excel---------------------------------------------------------------
library(openxlsx) 
xlsx.file <- "./data/dummmyData.xlsx"
write.xlsx(df2, xlsx.file, sheetName='sheet1', row.names=F)
df3 <- read.xlsx(xlsx.file, sheet='sheet1')
df3

## ----database, eval=F, tidy=F--------------------------------------------
## library(RODBC)
## db <- odbcConnect(dsn = "servername", uid = "userid",
##                   pwd = "******")
## sql <- "SELECT * FROM lib.table WHERE ..."
## # or read query from file
## sql <- readChar("myQuery.sql", nchars=99999)
## myData <- sqlQuery(db, sql, errors=TRUE)
## odbcClose(db)

## ----SAS dataset, eval=F, tidy=F-----------------------------------------
## library(foreign) # for importing SAS data
## # the path of SAS on your computer
## sashome <- "C:/Program Files/SAS/SASFoundation/9.4"
## filepath <- "./data"
## # filename should be no more than 8 characters, without extension
## fileName <- "dumData"
## # read data from a SAS dataset
## a <- read.ssd(file.path(filepath), fileName,
##               sascmd=file.path(sashome, "sas.exe"))

