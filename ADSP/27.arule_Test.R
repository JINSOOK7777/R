library(arules)
library(arulesViz)

setwd("D:/R_files/RWorkspace/R/R/ADSP")
# read single format data
read.csv("arules sample single format data.csv")
txn = read.transactions(file="arules sample single format data.csv", rm.duplicates= FALSE, format="single",sep=",",cols =c(1,2))
txn
inspect(txn)
# sup와 conf는 업무적으로 유의미한 수치이어야 분석이 의미가 있음에 주의 
basket_rules <- apriori(txn,parameter = list(sup = 0.4, conf = 0.3,target="rules"))
inspect(basket_rules);
inspect(basket_rules[1]);
itemFrequencyPlot(txn);
inspect(txn);
