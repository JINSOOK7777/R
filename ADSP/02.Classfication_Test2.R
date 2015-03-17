install.packages("rpart")
library(rpart)

data(iris)

mymodel.rpart <- rpart(Species~.,data=iris)
plot(mymodel.rpart)
text(mymodel.rpart)

#rpart로 plot을 하면 이미지가 허접하므로 party처럼 보게 할 경우는 partykit 사용
install.packages("partykit")
library(partykit)

mymodel1 <- as.party(mymodel.rpart)
plot(mymodel1)
