#질적 자료 요약 기겁
install.pckages("MASS")법
library(MASS)
data(survey)

table(survey$Smoke) #도수분포표 

smoke<-table(survey$Smoke)
pie(smoke)  #원그래프

barplot(smoke)


table(survey$Sex, survey$Smoke) #크로스 테이블


#양적 자료 요약 기법 사례  
data(mtcars)


hist(mtcars$mpg)  #히스토그램


#stem and leaf
# 줄기와 나뭇잎으로 나뭇잎들이 어느 줄기에 포함되어 있는지의 관계도를 보여줌 
stem(mtcars$hp, scale=1)
table(round(mtcars$hp+1,-1))


#line graph
library(ggplot2)

ggplot(BOD, aes(x=BOD$Time, y=BOD$demand)) +geom_line()

