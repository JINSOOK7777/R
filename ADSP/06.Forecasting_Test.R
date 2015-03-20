install.packages("forecast")
library(forecast)

retail <- read.csv("http://robjhyndman.com/data/ausretail.csv",header=FALSE)
retail <- ts(retail[,-1],f=12,s=1982+3/12)  #Time Series의 형태로 변환

ns <- ncol(retail)
h <- 24
fcast <- matrix(NA,nrow=h,ncol=ns)
for(i in 1:ns)
    fcast[,i] <- forecast(retail[,i],h=h)$mean

write(t(fcast),file="retailfcasts.csv",sep=",",ncol=ncol(fcast))
