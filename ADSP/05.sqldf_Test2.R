install.packages("sqldf")
library(sqldf)

data(iris)
sqldf("select * from iris")
sqldf("select * from iris limit 10")
