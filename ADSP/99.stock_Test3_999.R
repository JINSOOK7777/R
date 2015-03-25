# 상한가 예측 

# install.packages("sqldf")
library(sqldf)
# install.packages("reshape")
library(reshape)
# install.packages("tcltk")
library(tcltk)


setwd("D:/R_files/RWorkspace/R/R/ADSP")
stock <- read.csv("stock1.csv")
head(stock)
colnames(stock)
#[1] "X"      "date"   "Open"   "High"   "Low"   
#[6] "Close"  "Volume" "code"   "name" 


stock$gap_high <- stock$High - stock$Open
stock$gap_low <- stock$Open - stock$Low
# ind <- which(stock$gap_d/stock$Open > 0.1)
ind_high <- which(stock$gap_high/stock$Open > 0.10)
ind_low <- which(stock$gap_low/stock$Open > 0.10)
*#stock,[ind_high, "H_Count"]
  
stock$target_high <- 0
stock[ind_high, "target_high"] <- 1
stock$target_low <- 0
stock[ind_low, "target_low"] <- 1
head(ind)

# stock$target_d <- factor(stock$target_d)
prop.table(table(stock$target_high))
prop.table(table(stock$target_low))
str(stock)

# train mart data ??????
stock_1M <- sqldf("select name, code, avg(High) as High_1M, avg(Low) as Low_1M, avg(Open) as Open_1M, avg(Close) as Close_1M, sum(target_high) as t_h_1M, sum(target_low) as t_l_1M from stock where date <= '2014-08-31' and date >= '2014-08-01' group by code, name")
stock_mart1 <- sqldf("select stock.* from stock where date = '2014-09-01'")
stock_3M <- sqldf("select name, code, avg(High) as High_3M, avg(Low) as Low_3M, avg(Open) as Open_3M, avg(Close) as Close_3M, sum(target_high) as t_h_3M, sum(target_low) as t_l_3M from stock where date <= '2014-08-31' and date >= '2014-06-02' group by code, name")
stock_5M <- sqldf("select name, code, avg(High) as High_5M, avg(Low) as Low_5M, avg(Open) as Open_5M, avg(Close) as Close_5M, sum(target_high) as t_h_5M, sum(target_low) as t_l_5M from stock where date <= '2014-08-31' and date >= '2014-04-01' group by code, name")
test <- sqldf('select stock_3M.*,stock_1M.High_1M, stock_1M.Low_1M, stock_1M.Open_1M, stock_1M.Close_1M, stock_1M.t_h_1M, stock_1M.t_l_1M from stock_3M , stock_1M where stock_1M.name = stock_3M.name')
test2 <- sqldf('select test.*, stock_5M.High_5M, stock_5M.Low_5M, stock_5M.Open_5M, stock_5M.Close_5M, stock_5M.t_h_5M, stock_5M.t_l_5M from test, stock_5M where test.name = stock_5M.name')
test3 <- sqldf('select test2.*, stock_mart1.target_high, stock_mart1.volume from test2, stock_mart1 where test2.name = stock_mart1.name')
test3$target_high <- factor(test3$target_high)
str(test3)

# omit() 결측치 제거 함수 
test4 <- na.omit(test3)

#### test data ??????
stock_1M <- sqldf("select name, code, avg(High) as High_1M, avg(Low) as Low_1M, avg(Open) as Open_1M, avg(Close) as Close_1M, sum(target_high) as t_h_1M, sum(target_low) as t_l_1M from stock where date <= '2014-09-01' and date >= '2014-08-02' group by code,name")
stock_mart2 <- sqldf("select stock.* from stock where date = '2014-09-02'")
stock_3M <- sqldf("select name, code, avg(High) as High_3M, avg(Low) as Low_3M, avg(Open) as Open_3M, avg(Close) as Close_3M, sum(target_high) as t_h_3M, sum(target_low) as t_l_3M from stock where date <= '2014-09-01' and date >= '2014-06-03' group by code, name")
stock_5M <- sqldf("select name, code, avg(High) as High_5M, avg(Low) as Low_5M, avg(Open) as Open_5M, avg(Close) as Close_5M, sum(target_high) as t_h_5M, sum(target_low) as t_l_5M from stock where date <= '2014-09-01' and date >= '2014-04-02' group by code, name")
ts <- sqldf('select stock_3M.*,stock_1M.High_1M, stock_1M.Low_1M, stock_1M.Open_1M, stock_1M.Close_1M, stock_1M.t_h_1M, stock_1M.t_l_1M from stock_3M , stock_1M where stock_1M.name = stock_3M.name')
ts2 <- sqldf('select ts.*, stock_5M.High_5M, stock_5M.Low_5M, stock_5M.Open_5M, stock_5M.Close_5M, stock_5M.t_h_5M, stock_5M.t_l_5M from ts, stock_5M where ts.name = stock_5M.name')
head(stock_mart2)

ts3 <- sqldf('select ts2.*, stock_mart2.target_high, stock_mart2.volume from ts2, stock_mart2 where ts2.name = stock_mart2.name')
ts3$target_high <- factor(ts3$target_high)
str(ts3)

### 9/3
stock_1M <- sqldf("select name, code, avg(High) as High_1M, avg(Low) as Low_1M, avg(Open) as Open_1M, avg(Close) as Close_1M, sum(target_high) as t_h_1M, sum(target_low) as t_l_1M from stock where date <= '2014-09-02' and date >= '2014-08-03' group by code,name")
stock_mart3 <- sqldf("select stock.* from stock where date = '2014-09-03'")
stock_3M <- sqldf("select name, code, avg(High) as High_3M, avg(Low) as Low_3M, avg(Open) as Open_3M, avg(Close) as Close_3M, sum(target_high) as t_h_3M, sum(target_low) as t_l_3M from stock where date <= '2014-09-02' and date >= '2014-06-04' group by code, name")
stock_5M <- sqldf("select name, code, avg(High) as High_5M, avg(Low) as Low_5M, avg(Open) as Open_5M, avg(Close) as Close_5M, sum(target_high) as t_h_5M, sum(target_low) as t_l_5M from stock where date <= '2014-09-02' and date >= '2014-04-03' group by code, name")
ts_1 <- sqldf('select stock_3M.*,stock_1M.High_1M, stock_1M.Low_1M, stock_1M.Open_1M, stock_1M.Close_1M, stock_1M.t_h_1M, stock_1M.t_l_1M from stock_3M , stock_1M where stock_1M.name = stock_3M.name')
ts_2 <- sqldf('select ts_1.*, stock_5M.High_5M, stock_5M.Low_5M, stock_5M.Open_5M, stock_5M.Close_5M, stock_5M.t_h_5M, stock_5M.t_l_5M from ts_1, stock_5M where ts_1.name = stock_5M.name')
head(stock_mart2)
ts_3 <- sqldf('select ts_2.*, stock_mart3.target_high, stock_mart3.volume from ts_2, stock_mart3 where ts_2.name = stock_mart3.name')
ts_3$target_high <- factor(ts_3$target_high)

library(party)
stock.ctree1 <- ctree(target_high ~., data=test4[,-c(1:2)])
table(predict(stock.ctree1),test4$target_high)
plot(stock.ctree1)
table(predict(stock.ctree1),test4$target_high)
table(predict(stock.ctree1,newdata=ts3),ts3$target_high)

library(rpart)
library(partykit)

#stock.rpart <- rpart(target_high ~., data=ts3[,-c(1:2)])
#stock1p <- as.party(stock.rpart)
#plot(stock1p)
#table(predict(stock1p, ts3[,-c(1:2)]),ts3$target_high)
#table(predict(stock1p, newdata=ts_3[,-c(1:2)]),ts_3$target_high)

# 위 소스를 아래처럼 강사 수정 
stock.rpart <- rpart(target_high~., data=test4, parms=list(prior=c(0.9,0.1)),cp=0.001)
table(predict(stock.rpart,newdata=test4,type="class"),test4$target_high)

stock.rpart <- rpart(target_high~., data=test4, parms=list(prior=c(0.8,0.2)),cp=0.001)
table(predict(stock.rpart,newdata=test4,type="class"),test4$target_high)

indp <- which(predict(stock1p, newdata=ts_3[,-c(1:2)]) == 1)
ts_3[indp,]
str(indp)
str(table(ts3$name))
str(table(stock$code))
*#table,(predict(model1,type="class"),mart2$target)
#table(predict(model1,type="class",newdata=dmart2),dmart2$target)
  
library(ggplot2)
library(caret)
# install.packages("doParallel")
library(doParallel)
registerDoParallel(7)   #멀티코어 사용  
m1 <- train(target_high~.,data=test4[,-c(1:2)],method="rf")
plot(varImp(m1))

