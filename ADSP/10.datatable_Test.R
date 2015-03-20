install.packages("data.table")
library(data.table)

DT = data.table(x=c("b","b","b","a","a"), v=rnorm(5))
DT

data(cars)
head(cars)

CARS <- data.table(cars)
head(CARS)

tables()
sapply(CARS,class)
DT

DT[2,]
DT[DT$x=="b"]
cat(try(DT["b",],silent=TRUE))
setkey(DT,x)
DT

tables()
DT["b",]
DT["b",mult="first"]
DT["b",mult="last"]
DT["b"]

grpsize <- celling(le7/26^2)
tt <- system.time(DF <- data.frame(x=rep(LETTERS, each=26*grpsize),y=rep(letters,each=grpsize),v=runif(grpsize*26^2),stringAsFactors=FALSE))
tt
head(DF,3)
tail(DF,3)
dim(DF)
10000068/3.323
tt <- system.time(ans1 <- DF[DF$x=="R" & DF$y=="h",])
tt
head(ans1,3)
dim(ans1)
DT <- data.table(DF)
setkey(DT,x,y)
ss <- system.time(ans2<-DT[J("R","h")])
head(ans2,3)
dim(ans2)
indentical(ans1$v,ans2$v)
ss
system.time(ans2<-DF[DF$x=="R" & DF$y=="h",])

#실행 못함, 교재 p500~ 코딩 필요

  
    