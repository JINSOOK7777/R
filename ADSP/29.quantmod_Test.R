# 야후에서 주가 정보 
install.packages("quantmod")
library(quantmod)
library(Quandl)

?getSymbols
getSymbols("GOOG",src="yahoo")
plot(GOOG)

google <-data.frame(GOOG)
View(google)

getSymbols("005930.KS",src="yahoo")
plot(`005930.KS`)


?Quandl

?candleChart

## Not run: 
getSymbols("YHOO")
chartSeries(YHOO)
chartSeries(YHOO, subset='last 4 months')
chartSeries(YHOO, subset='2007::2008-01')
chartSeries(YHOO,theme=chartTheme('white'))
chartSeries(YHOO,TA=NULL)   #no volume
chartSeries(YHOO,TA=c(addVo(),addBBands()))  #add volume and Bollinger Bands from TTR

addMACD()   #  add MACD indicator to current chart

setTA()
chartSeries(YHOO)   #draws chart again, this time will all indicators present