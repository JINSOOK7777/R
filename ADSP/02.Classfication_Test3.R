install.packages("caret", dependencies=TRUE)
library(caret)


data(iris)

set.seed(1234)  #랜덤에 의해 값이 돌릴 때마다 달라질 수 있으므로 시드 넘버를 줘서 동일한 결과를 출력함.

mymodel1 <- train(Species~., data=iris, method="rf")
plot(mymodel1)
predict(mymodel1)

myVarImp <- varImp(mymodel1)  #변수의 중요도 출력
plot(myVarImp)
  