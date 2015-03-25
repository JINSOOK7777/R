library(arules)
library(arulesViz)

setwd("D:/R_files/RWorkspace/R/R/ADSP")
# read single format data
read.csv("arules sample single format data.csv")
txn = read.transactions(file="arules sample single format data.csv", rm.duplicates= FALSE, format="single",sep=",",cols =c(1,2))
txn
inspect(txn)
basket_rules <- apriori(txn,parameter = list(sup = 0.5, conf = 0.9,target="rules"))
inspect(basket_rules);
inspect(basket_rules[1]);
itemFrequencyPlot(txn);
inspect(txn);
