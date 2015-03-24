install.packages("gdata")
library(gdata)
library(sqldf)
library(party)
library(rpart)
setwd("D:/R_files/RWorkspace/R/R/ADSP")
drama <- read.csv("drama_sbs26.csv") #,fileEncodeing="UTF8")

#데이터의 집계정보 출력
summary(drama)
colnames(drama) <- tolower(colnames(drama)) #컬럼명을 모두 소문자로 변경
colnames(drama)

#특수문자 관련 컬럼명 변경 
colnames(drama)[2] <- 'name'
colnames(drama)[4] <- 'date'
colnames(drama)

str(drama)

####### 성공요인의 기준(타겟변수)을 만들기 위한 분석 

sqldf("select avg(average) from drama")
# avg(average)
# 1     14.07646

sqldf("select count(*) from drama where average > 0.1407")
# count(*)
# 1      314
summary(drama$average)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.0405  0.1022  0.1285  0.1408  0.1754  0.2975 

sqldf("select count(*) from drama where average > 0.17")
# count(*)
# 1      133


####### 위 분석에서 성공은 0.17보다 큰 경우를 성공으로 본다

# 2자리 수자 시청율이면 성공? 어떤 기사에 언급됨. 일부는 40%를 언급하나 데이터에는 없음

# 타겟변수(결과변수) 설정 
tmp1 <- sqldf("select name, avg(average) avg_view,min(average) min_view, max(average) max_view,count(*) tot_eps from drama group by name")
tmp1$target <- 0    #target 변수를 만들고 0 추가
ind <- which(tmp1$avg_view > 0.17)  #조건에 맞는 인덱스 값을 추출
tmp1[ind,"target"] <- 1 #해당 target 변수에 해당 값 저장
tmp1$target <- factor(tmp1$target) #위에서는 vector로 저장되어 numeric이므로 factor로 type 변경(이렇게 해야 결과가 1 또는 0으로 떨어짐 )
colnames(tmp1)


# 타겟을 분류하는데 사용할 변수 정의(원인변수)
sqldf("select name,target from tmp1 where name in (select name from drama where average > 0.11 and no=2 and name in (select name from drama where average >  0.1 and no=1))")

start <- sqldf("select name,target from tmp1 where name in (select name from drama where average > 0.11 and no=2 and name in (select name from drama where average >  0.1 and no=1))")

tmp1$start <- 0
ind <- which(tmp1$name %in% start$name)
tmp1[ind,"start"] <- 1
tmp1$start <- factor(tmp1$start)


tmp2 <- sqldf("select name, avg(average) avg_view5,min(average) min_view5, max(average) max_view5,stdev(average) sd_view5 from drama where no < 5 group by name")
tmp3 <- cbind(tmp1,tmp2)

colnames(tmp3)
tmp4 <- tmp3[,-c(1:4,8)]
tmp5 <- sqldf("select name, avg(average) avg_view4,min(average) min_view4, max(average) max_view4,stdev(average) sd_view4 from drama where no < 4 group by name")

tmp6 <- cbind(tmp4,tmp5[,-1])
colnames(tmp6)

tmp6

prop.table(table(tmp1$target))

mymodel <- ctree(target~.,data=tmp6)
plot(mymodel)

#ctree로만 하여도 분석은 되나 rpart로도 동일한 결과인지 검증하기 위해 rpart로도 분석 
mymodel <- rpart(target~.,data=tmp6)
plot(mymodel)
text(mymodel)

#rpart와 party의 그래프는 1을 기준으로 하는 값 자체가 다르므로 그림이 다르게 표현될 수는 있음(rpart 50%로 자르고, party는 모집단의 %로 자르게 되므로... )
#그래서 rpart는 as.party하여 출력한다. 그러나 분석내용 자체가 바뀌는 건 아니다. 시각화 출력시만 다름

install.packages("partykit")
library(partykit)

mymodel1 <- as.party(mymodel)
plot(mymodel1)



ind <- sample(2,nrow(tmp6),replace=TRUE,prob=c(0.8,0.2))
tr<-tmp6[ind==1,]
ts<-tmp6[ind==2,]
colnames(tr)
mymodel <- ctree(target~.,data=tr)
plot(mymodel)
table(predict(mymodel),tr$target)
table(predict(mymodel,newdata=ts),ts$target)

# 추가 분석시 
# row가 더 필요하다
# 타방송사 데이터도 더 필요하다
# 장르구분, 작가등도 데이터를 추가하여 복합적으로 분석하는 게 필요하다.

