install.packages("sqldf")
library(sqldf)

data(iris)


colnames(iris) <- tolower(colnames(iris)) #무조건 컬럼명을 소문자로 변경함

colnames(iris) <- c("sl", "sw", "pl", "pw", "species")
colnames(iris)

sqldf("select * from iris")
tmp1 <- sqldf("select sl,sw from iris")
View(tmp1)

tmp2 <- sqldf("select species, count(*) cnt from iris group by species")
View(tmp2)
summary(iris)
sqldf("select count(*) bigcnt from iris where pw > 1.5")
sqldf("select species, count(*) bigcnt from iris where pw > 1.5 and pw < 2 group by species order by bigcnt desc")
