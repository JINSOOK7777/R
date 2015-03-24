install.packages("foreign")
library(foreign)

setwd("D:/R_files/RWorkspace/R/R/BOKJI")
mydata = read.spss("가구용Koweps_h08_2013_beta2.sav", to.data.frame=TRUE, use.value.labels = FALSE)

# 데이터명을 제거하고 컬럼명만 사용하기 위한 함수, 뒤에 detach()를 해야 함.
attach(mydata)

# mydata에 y변수를 생성하고 해당 값 부여 (굳이 cbind하지 않아도 됨)
# 이혼인 사람은 y에 1, 나머지는 0 부여
mydata$y <- ifelse(h0801_11 ==3, "Divorce", "None")


# 변수 mode를 factor로 변경(vector를 factor로 변경하지 않으면 결과가 1,0으로 되지 않고 1과 0 사이의 소수로 표기됨)
mydata$y <- as.factor(mydata$y)


# 변수 빼기
# h0801_11  혼인상태
mydata <- mydata[ , names(mydata) != "h0801_11"]


# 무작위 7:3 배분, tring/test로 분류 
set.seed(1234) # 난수고정
ind<- sample(2, nrow(mydata), replace=TRUE, prob=c(0.7, 0.3))
tr <- mydata[ind==1,]
ts <- mydata[ind==2,]


# decision tree
library(party)

# tr 모델링
system.time(mymodel <- ctree(y~., data=tr))
plot(mymodel)
plot(mymodel, type = "simple")
table(predict(mymodel, newdata=tr), tr$y)

# ts에 적용
table(predict(mymodel, newdata=ts), ts$y)


detach(mydata)
