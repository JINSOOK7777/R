install.packages("sqldf")
install.packages("party")
library(sqldf)
library(party)

setwd("D:/R_files/RWorkspace/R/R/ADSP")
drama <- read.csv("drama(sbs26).csv")
View(drama)
head(drama) 

#년도:Year, 프로그래명: Program_name, 회차:No, 방영일:Running time, TNmS 전국 시청률:TNmS_Nationwide, TNmS 서울 시청률: TNmS_Seoul, AGB 전국시청률:AGB_Nationwide, AGB 서울 시청률:AGB_Seoul, 평균시청률:Average, 전체 편성수:No. of episodes


##### 작업 하다 멈춤. drama_Test2_999 참조

# 타켓변수 분석 
drama_avg<-sqldf("SELECT Program_name, AVG(Average) ave FROM drama GROUP BY Program_name")
summary(drama_avg)


# 타겟변수 정의 
# Q3보다 큰 드라마가 성공했다고 보자. 0.17321
SF <- sqldf("SELECT Program_name, 1 As SF FROM drama_avg WHERE ave>=0.17321")




# 변수 설정
tmp0 <- sqldf("select Program_name,avg(Average) tot_avg from drama group by Program_name")
tmp1 <- cbind(SF,tmp0)
tmp2 <- sqldf("select Program_name,avg(Average) avg_14 from drama where no < 5 group by Program_name")
tmp3 <- cbind(tmp1,tmp2)
tmp4 <- sqldf("select Program_name,avg(Average) avg_1 from drama where no=1 group by Program_name")
tmp5 <- cbind(tmp3,tmp4)
colnames(tmp5)
View(tmp5)




tmp5$SF <- as.factor(tmp5$SF) 
# tmp5로 저장될 경우에는 numeric이므로 factor로 type 변경(이렇게 해야 결과가 1 또는 0으로 떨어짐 )

ind <- sample(2,nrow(tmp5),replace=TRUE, prob=c(0.8,0.2)) #데이터가 적어 8:2로 함 
tr <- drama[ind==1,]   #행 ind값이 1인 것만  tr로 저장
ts <- drama[ind==2,]   #행 ind값이 2인 것만  ts로 저장출
head(tr)

system.time(mymodel <- ctree(No~.,data=tr))  #tr데이터를 (Year~.는 전체를 의미) tree형태로 mymodel에 저장 후 실행시간 출
plot(mymodel)
print(mymodel)
table(predict(mymodel),tr$SF)  
table(predict(mymodel,newdata=ts),ts$SF)












