#http://kdd.ics.uci.edu/databases/kddcup99/kddcup99.html

library(data.table)
library(sqldf)
library(party)
library(caret)
library(doMC)     #doMC는 사용하지 말 것, doparallel을 사용하도록 할 것
registerDoMC(7)

setwd("D:/R_files/RWorkspace/R/R/ADSP")
system.time(mydata <- fread("kddcup.data.corrected"))
str(mydata)
colnames(mydata)
colnames(mydata) <- c("duration" ,"protocol_type" ,"service" ,"flag","src_bytes" ,"dst_bytes" ,"land" ,"wrong_fragment" ,"urgent" ,"hot" ,"num_failed_logins" ,"logged_in" ,"num_compromised" ,"root_shell" ,"su_attempted" ,"num_root" ,"num_file_creations" ,"num_shells" ,"num_access_files" ,"num_outbound_cmds" ,"is_host_login" ,"is_guest_login" ,"count" ,"srv_count","serror_rate" ,"srv_serror_rate","rerror_rate","srv_rerror_rate" ,"same_srv_rate" ,"diff_srv_rate" ,"srv_diff_host_rate","dst_host_count","dst_host_srv_count","dst_host_same_srv_rate","dst_host_diff_srv_rate","dst_host_same_src_port_rate","dst_host_srv_diff_host_rate","dst_host_serror_rate","dst_host_srv_serror_rate","dst_host_rerror_rate","dst_host_srv_rerror_rate","type")
table(mydata$type)
ind <- which(mydata$type=="normal.")
mydata$type1 <- '0'
mydata[-ind,"type1"] <- '1'
table(mydata$type1)
prop.table(table(mydata$type1))
mydata$type1 <- factor(mydata$type1)
mydata$protocol_type <- factor(mydata$protocol_type)
mydata$service <- factor(mydata$service)
mydata$flag <- factor(mydata$flag)
mydata$type <- factor(mydata$type)
mydata$land <- factor(mydata$land)
mydata$logged_in <- factor(mydata$logged_in)
mydata$root_shell <- factor(mydata$root_shell)
mydata$su_attempted <- factor(mydata$su_attempted)
mydata$is_host_login <- factor(mydata$is_host_login)
mydata$is_guest_login <- factor(mydata$is_guest_login)
prop.table(table(mydata$type1))
prop.table(table(mydata$protocol_type,mydata$type1))
(table(mydata$service,mydata$type1))
prop.table(table(mydata$flag,mydata$type1))
(table(mydata$type,mydata$type1))
(table(mydata$land,mydata$type1)) # meaningless
prop.table(table(mydata$logged_in,mydata$type1))
(table(mydata$root_shell,mydata$type1)) # meaningless
(table(mydata$su_attempted,mydata$type1)) # meaningless
(table(mydata$is_hot_login,mydata$type1)) # error why?
(table(mydata$is_guest_login,mydata$type1)) # meaningless
str(mydata)
ind <- sample(2,nrow(mydata),replace=TRUE,prob=c(0.1,0.9))
tr <- mydata[ind==1,]
ts <- mydata[ind==2,]
tr1 <- tr[,c(1,5:41,43),with=FALSE]
ts1 <- ts[,c(1,5:41,43),with=FALSE]
system.time(mymodel.party <- ctree(type1~.,data=tr1))
plot(mymodel.party)
table(predict(mymodel.party,newdata=tr1),tr1$type1)
(95360+392329)/(95360+392329+1695+105)
392329/(392329+1695)
table(predict(mymodel.party,newdata=ts1),ts1$type1)
system.time(mymodel.ctree <- train(type1~.,data=tr1,method="ctree"))
save.image("kdd99.rdata")
###### clustering
summary(mydata)
mydata_cluster <- tr[,c(1,5:6,9:10,13),with=FALSE]
system.time(mydata.kc <- kmeans(scale(mydata_cluster),centers=30))
mydata.kc