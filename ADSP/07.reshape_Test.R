install.packages("reshape")
library(reshape)
? reshape

data(airquality)
head(airquality)
head(airquality,10)
names(airquality)

names(airquality) <- tolower(names(airquality))
names(airquality)

aqm <- melt(airquality, id=c("month","day"), na.rm=TRUE)
aqm

a <- cast(aqm, day ~ month ~ variable)
a

b <- cast(aqm, month ~ variable, mean)
b


c <- cast(aqm, month ~. |variable, mean)
c

d <- cast(aqm, month~variable, mean, margins=c("grand_row", "grand_col"))
d

e <- cast(aqm, day~month, mean, subset=variable=="ozone")
e

f <- cast(aqm, month~variable, range)
f


