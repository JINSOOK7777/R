install.packages("party")
library(party)

data(iris)
View(iris)

ind <- sample(2,nrow(iris),replace=TRUE, prob=c(0.7,0.3)) #7:3 비율로 샘플데이터 추출 
tr <- iris[ind==1,]   #행 ind값이 1인 것만  tr로 저장
ts <- iris[ind==2,]   #행 ind값이 2인 것만  ts로 저장출

system.time(mymodel <- ctree(Species~.,data=tr))  #tr데이터를 (Species~.는 전체를 의미) tree형태로 mymodel에 저장 후 실행시간 출
plot(mymodel)
table(predict(mymodel),tr$Species)  
table(predict(mymodel,newdata=ts),ts$Species)

deploy <- iris[,-5]  #열중 5번을 제외하고 deploy 저장
colnames(deploy)
result <- cbind(deploy,predicted=predict(mymodel,newdata=deploy))
View(result)
