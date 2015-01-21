install.packages("lpSolve")
library(lpSolve)

costs <- matrix(10000, 8, 5); costs[4,1] <- costs[-4,5] <-0
costs[1,2]<-costs[2,3]<-costs[3,4]<-7;costs[1,3]<-costs[2,4]<-7.7
costs[5,1]<-costs[7,3]<-8;costs[1,4]<-8.4;costs[6,2]<-9
costs[8,4]<-10;costs[4,2:4]<-c(.7,1.4,2.1)
costs

row.signs<-rep("<",8)
row.rhs<-c(200,300,350,200,100,50,100,150)
col.signs<-rep(">",5)
col.rhs<-c(250,100,400,500,200)

lp.transport(costs,"min",row.signs,row.rhs, col.signs, col.rhs)
lp.transport(costs,"min",row.signs,row.rhs,col.signs,col.rhs)$solution
$solution