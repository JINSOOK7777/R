#==================================
# 1.변수 
#==================================
a<-1

#==================================
# 2.백터 
#==================================
x<-c("fee", "fie","foe","fum")

c("Everyone","loves","stats.")
c(1,1,2,3,5,8,13,21)
c(1*pi, 2*pi, 3*pi, 4*pi)
c(TRUE, TRUE, FALSE&T, TRUE|F)  #불린도 연산가능

# 백터 값은 같은 type이어야 함.
c("Everyone","loves",1)     #1은 "1"  
c(1,1,2,3,5,8,13,21,T)      #T는 1

v1<-c(1,2,3)
v2<-c(4,5,6)
v3<-c(v1,v2)


# 백터연산
# [1] 5 7 9    ,v1학생의 국어성적 1, 영어성적 2, 수학성적 3이고 v2학생의 각각 성적이 더해지는 형태로 이해하도록. (같은 컬럼끼리 연산)
# 컬럼수가 다를 경우에는 긴 컬럼에 맞춰 보여주고 warning 문구가 출력되므로 이를 참조할 것.
# 백터의 컬럼에 무엇이 있느냐에 따라 세상이 보일 것이다~~~~

v1+v2     
v1*v2
v1^2


#==================================
# 3.수열
#==================================
1:5
b<-2:10
b

10:19

9:-1
e<-10:2
e

#seq(from=시작점, to=끝점, by=간격 )

seq(from=0, to=20, by=2)
seq(from=0, to=20, length.out=5)
seq(from=1.0,to=2.0,length.out=5)
seq(0,10,length=20)
(x<-seq(0,10,length=21))

n<-0
1:n

#req(반복할 내용, 반복수 )

rep(1,times=5)    #time은 앞의 값을 반복
rep(1:2,each=2)   #each는 앞의 값을 각각 반복([1] 1 1 2 2)

c<-1:5
c
rep(c,5)
rep(c,each=5)

? rep
args(rep)


#==================================
# 4.데이터 유형과 객체 
#==================================

#Numeric
a<-3
a

#Character
b<-"Charcter"
b

#paste("붙일 내용","붙일 내용", sep="")
#문자열 붙일 내용을 separator를 사이에 두고 붙이는 함수
A<-c("a","b","c")
A

paste("a","b",sep="")
paste(A,c("d","e")) 
# 길이가 달라서 "a d" "b e" "c d"로 "c d"가 한번 더 출력되는 것에 주의(warning)

f<-paste(A,10)
f

paste(A,10,sep="")

paste(A,1:10,sep="")
paste("Everybody","loves","cats.")

paste("Everybody","loves","cats.", sep="-")

#substr(문자열, 시작, 끝)
substr("BigDataAnalysis",2,4)

ss<-c("Moe","Larry","Curly")
substr(ss,1,3)


# 논리값
c<-TRUE
c

d<-T
d

e<-False
e

f<-F
F

a<-3
a==pi
a!=pi
a<pi
a>pi
a<=pi
a>=pi


# Matrix

theData<-c(1.1,1.2,2.1,2.2,3.1,3.2)
mat<-matrix(theData,2,3)
mat

dim(mat)
mat

t(mat)
mat%*%t(mat)

diag(mat)
mat

colnames(mat)<-c("IBM","MSFT","GOOG")
rownames(mat)<-c("IMB","MSFT")
mat

mat[1,] # 행
mat[,3] # 열
mat

A<-matrix(0,4,5)
A

A<-matrix(1:20,4,5)
A

A[C(1,4),C(2,3)]
A[C(1,4),C(2,3)]<-1
A

A+1


#list
lst<-list(3.14,"Moe",c(1,1,2,3),mean)
lst


a<- 1:10
b<-matrix(1:10,2,5)
c<-c("name1","names")

alst<-list(A=a,B=b,C=c)
alst
blst<-list(d=2:10*10)
alst$a
alst[[1]]
alst[[1]][[2]]
alst[[2]]

ablst<-c(alst,blst)
ablst

score1<-list(10,20,30,40,50)
score2<-list(c("a","b"))
score1[score1 > 40]
score12<-list(score1,score2)
score12

score12[1]
score12[[2]]
score[[2]][1]
score12[[1]][1]
score12[[1]][2]

unlist(scroe1)      #unlist는 vactor로 바꿔줌. 만약 타입이 혼용되면 문자로 바뀜
unlist(score2)
unlist(score12)


#data.frame

a=c(1,2,4,5,3,4)
b=c(6,4,2,4,3.2,4)
c=c(7,6,4,2,5,6)
d=c(2,4,3,1,5,6)
e=data.frame(a,b,c,d)
e



# 조회

e[1,2]
e[,"a"] #a라는 컬럼에서 가져와라
e$a
e[e$a==2,]  #a가 2인 컬럼 값을 가져와라  e["a"==2,]로 하면 안됨.


# rbind, cbind

data(iris)
head(iris)    # 처음 6개 observation 조회
?iris
summary(iris)
str(iris)
new_R<-data.frame(Sepal.Length=3.0, Sepal.Width=3.2, Petal.Length=1.6, Petal.Width=0.3, Species="newsetosa")
new_R

#rbind할 데이터 프레임은 컬럼은 같아야 하고 순서는 상관없다.

tail(iris,2)      # 마지막 2개 observation 조회
nR_iris<-rbind(iris,new_R)
tail(nR_iris,2)
dim(nR_iris)


new_C<-1:151
nRC_iris<-cbind(nR_iris,new_R)
head(nR_iris,2) # 처음 2개 observation 조회
str(nRC_iris)


# subset(dataframe, select=열 이름, subset=조건)
# 데이터세트에서 조건에 맞는 내용을 조회

subset(iris, select=Species, subset=(Petal.Length>5.0))
subset(iris,subset=c(Sepal.Width==3.0&Petal.Width==0.2), select=c(Sepal.Length, Petal.Length, Species))
iris[iris$Sepal.Width==3.0&iris$Petal.Width==0.2,]

# merge(df1, df2, by="df1와 df1의 공통된 열의 이름")
mrg_iris_org<-cbind(no=1:30,iris[c(1:10,51:60,101:110),])
head(mrg_iris_org,2)
tail(mrg_iris_org,2)
mrg_iris_1<-mrg_iris_org[,c(1,2,3)]
head(mrg_iris_1,2)
mrg_iris_2<-mrg_iris_org[,c(1,4,5,6)]
head(mrg_iris_2,2)

mrg_iris_12<-merge(mrg_iris_1,mrg_iris_2,by="no") #by는 inner join,  outer join은 by.y 
head(mrg_iris_12,2)
head(mrg_iris_org,2)

?merge

mrg_iris_12==mrg_iris_org
table(mrg_iris_12==mrg_iris_org)

# grep(조회할 문자패턴, data)
install.packages("ggplot2")
data(movies,package="ggplot2") # ggplot2 패키지에서 movies data를 가져오라는 명령어
head(movies,2)
head(movies[grep("main",movies$title, ignore.case=F),"title"]) #movies$title에서 main이라는 문자를 조회하고 ignore.case=F이므로 대소문자 구분없이 찾아라
grep("main",movies$title)
head(movies[grep("Main ",movies$title, ignore.case=F),"title"])


#====================================
# vector, display subset
#====================================
fib<-c(0,1,1,2,3,5,8,13,21,34)
fib[-1]
fib[-c(1:3)]  #1:3을 빼고 가져옴
fib
fib%%2==0
fib%%2==1
fib[fib%%2==0]
fib[fib%%2==1]

## e) 자료형, 데이터 구조 변환하기

a<-"2.78"
a
class(a)
as.numeric(a)

as.numeric("a")

# 문자를 숫자로 변환하려 시도하였으나 불가하여 NA로 돌려줌.


b<-2.78
b
class(b)
as.character(b)

as.numeric(TRUE)
as.numeric(F)


### 날짜로 변환(as.Date)

c<-"2020-01-01"
c
class(c)
c1<-as.Date(c)
c1
class(c1)

d<-"01/31/2020"
d1<-as.Date(d,format="%m/%d/%Y")
d1

# format(날짜,포맷)
# as.character()

as.Date("31/01/2020",format="%d/%m/%Y")
format(Sys.Date(),format="%d/%m/%Y")
format(Sys.Date(),'%a')
format(Sys.Date(),'%b')
format(Sys.Date(),'%B')
format(Sys.Date(),'%d')
format(Sys.Date(),'%m')
format(Sys.Date(),'%y')
format(Sys.Date(),'%Y')
?strptime

## f) Missing data

a<-0/0
a
is.nan(a) #숫자가 아닌지 확인, 숫자일 때 비었는지 확인
is.na(a)  #비었는지 확

b<-log(0)
b
is.finite(b)
is.nan(b)
is.na(b)

c<-NA
is.na(c)
is.nan(c)

d<-c(1:3,NA)
d
is.na(d)


## g) 벡터의 기본 연산

v1<-c(1,3,5,7,9,11,20)
v1*v1

(v2<-v1+v1^2)
(v3<-1+v1+v1^3)

mean(v1)
median(v1)
sd(v1)
var(v1)
sum((v1-mean(v1))^2)/(length(v1)-1)

cor(v1,v2)
cor(v1,v3)


## h) 파일 읽기 등

v4<-as.data.frame(v1)

# write.csv(변수이름, “지정할 파일이름.csv”)
# read.csv("저장된 파일이름.csv")
write.csv(v4,"v4.csv")
v5<-read.csv("v4.csv")
v5

?read.table

v6<-as.vector(v4)
v7<-as.vector(v5$v1)

v6==v7

# save(변수이름, file="지정할 데이터 파일이름.Rdata")
# load("저장된 파일이름.Rdata")
save(v4,v5,file="v.rdata")
load("v.rdata")

(v8<-as.list(v4))
(v9<-as.list(v5))
v8$v1==v9$v1
v8[[1]]==v9[[2]]

# rm(object 명)
rm(v4,v5)
rm(list=ls()) # 모두 지우기

# summary
data(iris)
summary(iris) # 열별 data 요약

# install.packages("package명"): package설치
install.packages("party")

# library(package명): package를 memory에 load
library(party)

# vignette(“알고싶은 package이름”): party에 대한 tutorial pdf파일
vignette("party")

# q(): R 종료

vignette("party")
