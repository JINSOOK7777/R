data(iris)
newiris <- iris
newiris$Species <- NULL   #newiris[,-5]와 동일
str(newiris)
colnames(newiris)

#여기서는 스케일조정의 의미가 없으나 실전에서는 scale()을 해줘야 함.

set.seed(1234)

kc <- kmeans(newiris,3) #집단을 3개로 만듦, 여기서도 랜덤값이므로 결과를 고정으로 할 경우 시드넘버를 넣어준다.
kc$cluster
kc$centers
kc

wss<-0
for(i in 1:15) wss[i] <- kmeans(newiris,centers=i)$tot.withins
plot(1:15,wss,type="b")
