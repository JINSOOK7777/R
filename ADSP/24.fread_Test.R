# 커다란 파일 나누어서 읽어들이는 방법
# fread로 읽을 것

# install.packages("data.table")
library(data.table)

setwd("D:/R_files/RWorkspace/R/R/ADSP")

# Real data example (Airline data)
# http://stat-computing.org/dataexpo/2009/the-data.html
download.file("http://stat-computing.org/dataexpo/2009/2008.csv.bz2",destfile="2008.csv.bz2")
# 109MB (compressed)
system("bunzip2 2008.csv.bz2") 
# 658MB (7,009,728 rows x 29 columns)
colClasses = sapply(read.csv("2008/2008.csv",nrows=100),class)
# 4 character, 24 integer, 1 logical. Incorrect.
colClasses = sapply(read.csv("2008/2008.csv",nrows=200),class)
# 5 character, 24 integer. Correct. Might have missed data only using 100 rows
# since read.table assumes colClasses is correct.


system.time(DF <- read.table("2008/2008.csv", header=TRUE, sep=",", quote="",stringsAsFactors=FALSE,comment.char="",nrows=7009730, colClasses=colClasses)) # 360 secs
system.time(DT <- fread("2008/2008.csv")) # 40 secs
head(DT)
system.time(DT1 <- fread("2008/2008.csv",nrows=1000000,skip=0)) # 1.6 secs
head(DT1)
head(DT[1000000:1000005,])
system.time(DT2 <- fread("2008/2008.csv",nrows=1000000,skip=1000000)) # 1.5 secs
head(DT2)

