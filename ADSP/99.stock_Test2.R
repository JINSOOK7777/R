setwd("D:/R_files/RWorkspace/R/R/ADSP")
stockfile <- read.csv("stock1.csv", encoding="UTF-8")
View(stockfile)
head(stockfile) 

install.packages("sqldf")
library(sqldf)
sqldf("select count(*) from stockfile")
sqldf("select date, date-1, sum(Volume) from stockfile group by date order by date") 

stockfile$date <- as.Date(stockfile$date) 

stockfile.bak <- stockfile
install.packages("reshape")
library(reshape) 

stockfile2 <- cbind(stockfile$date-1, stockfile)
View(stockfile2) 

stockmelt <- melt(stockfile, id=c("date","name"), na.rm=T); stockmelt
tail(stockmelt)
stockcast <- cast(stockmelt, date~name, sum, subset=variable=="Volume")
tail(stockcast)
View(stockcast) 

m <- cbind(1, 1:7); m
m <- cbind(m, 8:14); m 



stockfile2 <- cbind("D-1"=stockfile$date-1, stockfile)
View(stockfile2) 


stockmelt <- melt(stockfile2, id=c("D-1","date","name"), na.rm=T); stockmelt
stockcast <- cast(stockmelt, D-1~name, sum, subset=variable=="Volume")
View(stockcast)