*#install,.packages("sqldf")
#install.packages("party")
#install.packages("rpart")
library(sqldf)
drama<-read.csv("drama(sbs26).csv")
str(drama)
drama_avg<-sqldf("SELECT Program_name, AVG(Average) ave FROM drama GROUP BY Program_name")
summary(drama_avg)
# Q3보다 큰 드라마가 성공했다고 보자. 0.17321
sqldf("SELECT Program_name, ave FROM drama_avg WHERE ave>=0.17321")
drama_avg2<-sqldf(
  "
  SELECT A.Program_name, CASE WHEN A.ave>=0.17321 THEN 1 ELSE 0 END SF, A.ave ave_t, B.ave ave_1, C.ave ave_1_2, D.ave ave_1_3, E.ave ave_1_4
  FROM drama_avg AS A
  INNER JOIN (SELECT Program_name, AVG(Average) ave FROM drama WHERE No=1 GROUP BY Program_name) AS B ON A.Program_name=B.Program_name
  INNER JOIN (SELECT Program_name, AVG(Average) ave FROM drama WHERE No IN (1,2) GROUP BY Program_name) AS C ON A.Program_name=C.Program_name
  INNER JOIN (SELECT Program_name, AVG(Average) ave FROM drama WHERE No BETWEEN 1 AND 3 GROUP BY Program_name) AS D ON A.Program_name=D.Program_name
  INNER JOIN (SELECT Program_name, AVG(Average) ave FROM drama WHERE No<=4 GROUP BY Program_name) AS E ON A.Program_name=E.Program_name"
)
drama_avg2$SF <- as.factor(drama_avg2$SF)
str(drama_avg2)
View(drama_avg2)
drama_ind <- sample(2,nrow(drama_avg2),replace=TRUE, prob=c(0.8,0.2))
drama_train <- drama_avg2[drama_ind==1,]
drama_test <- drama_avg2[drama_ind==2,]
library(party)
drama_ctree <- ctree (SF ~ ave_1+ ave_1_2+ ave_1_3+ ave_1_4, data=drama_train)
print(drama_ctree)
plot(drama_ctree)
table(predict(drama_ctree),drama_train$SF)
drama_testPred <- predict(drama_ctree,newdata=drama_test)
table(drama_testPred, drama_test$SF)