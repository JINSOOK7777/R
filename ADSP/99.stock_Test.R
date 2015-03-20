install.packages("sqldf")
library(sqldf)

setwd("D:/R_files/RWorkspace/R/R/ADSP")
stock_data<-read.csv("stock1.csv")
head(stock_data, 100)

names(stock_data) <- tolower(names(stock_data))

# 기준일 등록
base_date <- c("20130917")
base_date

# 총거래량 추출 
#sqldf("select * from stock_data where date="+base_date)
sqldf('select * from stock_data where date='+base_date+'')


# 쿼리 변수 사용(염정완님 제공)
txt <-c("select * from stock_data where code=20")
sqldf(txt)

Example=paste("select * from stock_data where date=",as.character(c("2013-09-16")),as.character(" AND CODE=20"))
sqldf(Example,verbose=TRUE)
