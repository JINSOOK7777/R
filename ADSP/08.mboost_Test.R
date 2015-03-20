install.packages("mboost")
library(mboost)

install.packages("TH.data")
data("bodyfat", package = "TH.data")
dim(bodyfat)
attributes(bodyfat)
bodyfat[1:5,]

install.packages("rpart")
library(rpart)

myFormula <- DEXfat~age+waistcirc+hipcirc+elbowbreadth+kneebreadth
bodyfat_rpart <- rpart(myFormula, data=bodyfat, control=rpart.control(minsplit=10))
attributes(bodyfat_rpart)
print(bodyfat_rpart)
plot(bodyfat_rpart)
text(bodyfat_rpart, use.n=TRUE)
