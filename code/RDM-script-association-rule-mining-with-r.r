## ----author info, include=F----------------------------------------------
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    9 December 2018

## ----download data, eval=F, tidy=F, warning=F----------------------------
## ## download data
## download.file(url="http://www.rdatamining.com/data/titanic.raw.rdata",
##               destfile="./data/titanic.raw.rdata")

## ----load data-----------------------------------------------------------
library(magrittr) ## for pipe operations
## load data, and the name of the R object is titanic.raw
load("./data/titanic.raw.rdata")
## dimensionality
titanic.raw %>% dim()
## structure of data
titanic.raw %>% str()

## ----check data----------------------------------------------------------
## draw a random sample of 5 records
idx <- 1:nrow(titanic.raw) %>% sample(5)
titanic.raw[idx, ]
## a summary of the dataset
titanic.raw %>% summary()

## ----mine association rules----------------------------------------------
library(arules) ## load required library
rules.all <- titanic.raw %>% apriori() ## run the APRIORI algorithm

## ----have a look at rules------------------------------------------------
rules.all %>% length() ## number of rules discovered
rules.all %>% inspect() ## print all rules

## ----mine rules with constraints, tidy=F---------------------------------
## run APRIORI again to find rules with rhs containing "Survived" only
rules.surv <- titanic.raw %>% apriori(
             control = list(verbose=F),
             parameter = list(minlen=2, supp=0.005, conf=0.8),
             appearance = list(rhs=c("Survived=No",
                                     "Survived=Yes"),
                               default="lhs"))
## keep three decimal places
quality(rules.surv) <- rules.surv %>% quality() %>% round(digits=3)
## sort rules by lift
rules.surv.sorted <- rules.surv %>% sort(by="lift")

## ----inspect rules-------------------------------------------------------
rules.surv.sorted %>% inspect() ## print rules

## ----redundant rules-----------------------------------------------------
rules.surv.sorted[1:2] %>% inspect()

## ----find redundant rules------------------------------------------------
## find redundant rules
subset.matrix <- is.subset(rules.surv.sorted, rules.surv.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- F
redundant <- colSums(subset.matrix) >= 1

## ----remove redundant rules----------------------------------------------
## which rules are redundant
redundant %>% which()

## remove redundant rules
rules.surv.pruned <- rules.surv.sorted[!redundant]

## ----inspect pruned rules - 1--------------------------------------------
rules.surv.pruned %>% inspect() ## print rules

## ----inspect pruned rules - 2--------------------------------------------
rules.surv.pruned[1] %>% inspect() ## print rules

## ----mine rules about class and age group, tidy=F------------------------
rules.age <- titanic.raw %>% apriori(control = list(verbose=F),
     parameter = list(minlen=3, supp=0.002, conf=0.2),
     appearance = list(default="none", rhs=c("Survived=Yes"),
                       lhs=c("Class=1st", "Class=2nd", "Class=3rd",
                             "Age=Child", "Age=Adult")))
rules.age <- sort(rules.age, by="confidence")

## ----inspect age group related rules-------------------------------------
rules.age %>% inspect() ## print rules
## average survival rate
titanic.raw$Survived %>% table() %>% prop.table() 

## ----scatter plot, out.height=".8\\textheight", out.width=".8\\textwidth"----
library(arulesViz)
rules.all %>% plot()

## ----grouped rules, out.height=".9\\textheight"--------------------------
rules.surv %>% plot(method="grouped")

## ----graph - 1, tidy=F, out.height=".9\\textheight"----------------------
rules.surv %>% plot(method="graph", 
                    control=list(layout=igraph::with_fr()))

## ----graph - 2, tidy=F, out.height=".9\\textheight"----------------------
rules.surv %>% plot(method="graph", 
                    control=list(layout=igraph::in_circle()))

## ----parallel coordinates, out.height=".8\\textheight", tidy=F-----------
rules.surv %>% plot(method="paracoord", 
                    control=list(reorder=T))

## ----interactive plot, eval=F, tidy=F------------------------------------
## rules.all %>% plot(interactive = T)

## ----reorder rules, eval=F-----------------------------------------------
## rules.surv %>% plot(method="paracoord", control=list(reorder=T))

