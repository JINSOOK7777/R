install.packages("googleVis")
library(googleVis)

data(Fruits)
M1 <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(M1)
