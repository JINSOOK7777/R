# Data Collection

##########
# Quandl #
##########
# cmd_gold
install.packages("Quandl")
library(Quandl)
Quandl.auth("__________")

cmd_gold<-Quandl("LBMA/GOLD", trim_start="2009-07-01", trim_end="2014-06-30")
str(cmd_gold)
cmd_gold<-cmd_gold[,-c(2,4:7)]
names(cmd_gold)[2]<-"c_gold"
cmd_gold<-cmd_gold[order(cmd_gold$Date),]
head(cmd_gold,3);tail(cmd_gold,3)

# yield_jp
yield_jp<-Quandl("YIELDCURVE/JPN", trim_start="2009-07-01", trim_end="2014-06-30")
str(yield_jp)
yield_jp<-yield_jp[,c(1,2,4,6,11)]
names(yield_jp)[2:5]<-c("y_jp_1yr","y_jp_3yr","y_jp_5yr","y_jp_10yr")
yield_jp<-yield_jp[order(yield_jp$Date),]
head(yield_jp,3);tail(yield_jp,3)


#############
# KRX Index #
#############
install.packages("xlsx")
library(xlsx)
# stck_krx_100
getwd()
setwd("D:/R_files/RWorkspace/R/R/ADSP")
stck_krx_100_2010<-read.xlsx("011.krx/krx_100_2010.xls",1,colIndex=c(1:2),header=T)
stck_krx_100_2011<-read.xlsx("011.krx/krx_100_2011.xls",1,colIndex=c(1:2),header=T)
stck_krx_100_2012<-read.xlsx("011.krx/krx_100_2012.xls",1,colIndex=c(1:2),header=T)
stck_krx_100_2013<-read.xlsx("011.krx/krx_100_2013.xls",1,colIndex=c(1:2),header=T)
stck_krx_100_2014<-read.xlsx("011.krx/krx_100_2014.xls",1,colIndex=c(1:2),header=T)
stck_krx_100<-rbind(stck_krx_100_2010,stck_krx_100_2011,stck_krx_100_2012,stck_krx_100_2013,stck_krx_100_2014)
str(stck_krx_100)
names(stck_krx_100)<-c("Date","s_krx_100")
stck_krx_100$Date<-as.Date(stck_krx_100$Date)
stck_krx_100<-stck_krx_100[order(stck_krx_100$Date),]
head(stck_krx_100,3);tail(stck_krx_100,3)


#################
# file download #
#################
fileUrl<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(fileUrl,dest="repdata-data-activity.zip",method="curl")
unzip("repdata-data-activity.zip","activity.csv")

activity<-read.csv("activity.csv")
head(activity)

#################
# Daum Crawling #
#################
install.packages("XML")
library(XML)
# http://finance.daum.net/item/quote_yyyymmdd_sub.daum?page=1&code=016360&modify=0
# code="016360";name="삼성증권"

code <- c("016360")
name <- c("삼성증권")

for (i in 1:10){
    theurl<-paste("http://stock.daum.net/item/quote_yyyymmdd_sub.daum?page=",i,"&code=",code,"&modify=0",sep="")
    sise_html<-readHTMLTable(theurl)
    if(i==1) {sise_table_tmp<-sise_html[[1]][c(2:6,9:13,16:20,23:27,30:34,37:40),]
    }else sise_table_tmp<-sise_html[[1]][c(2:6,9:13,16:20,23:27,30:34,37:41),]
    # head(sise_table_tmp)
    names(sise_table_tmp)<-c("date","Open","High","Low","Close","p_diff","r_diff","Volume")
    sise_table_tmp$date<-paste("20",sise_table_tmp$date,sep="")
    sise_table_tmp[,2]<-as.numeric(gsub(",","",as.character(sise_table_tmp[,2])))
    sise_table_tmp[,3]<-as.numeric(gsub(",","",as.character(sise_table_tmp[,3])))
    sise_table_tmp[,4]<-as.numeric(gsub(",","",as.character(sise_table_tmp[,4])))
    sise_table_tmp[,5]<-as.numeric(gsub(",","",as.character(sise_table_tmp[,5])))
    sise_table_tmp[,6]<-gsub("▼","-",as.character(sise_table_tmp[,6]))
    sise_table_tmp[,6]<-gsub("↓","-",sise_table_tmp[,6])
    sise_table_tmp[,6]<-gsub("▲","",sise_table_tmp[,6])
    sise_table_tmp[,6]<-as.numeric(gsub(",","",sise_table_tmp[,6]))
    sise_table_tmp[,7]<-as.numeric(gsub("%","",as.character(sise_table_tmp[,7])))
    sise_table_tmp[,8]<-as.numeric(gsub(",","",as.character(sise_table_tmp[,8])))
    sise_table_tmp$code<-code
    sise_table_tmp$name<-name
    if (i==1) {
        sise_table<-sise_table_tmp
    } else {
        sise_table<-rbind(sise_table,sise_table_tmp)
    }
}

sise_table
rownames(sise_table)<-NULL
sise_table
