options(repos=c(Rstudio='http://rstudio.org/_packages', getOption('repos')))
install.packages('shiny')
library(shiny)

runExample("01_hello")
runExample("02_text")

# 6-9. Mosaic Plot
install.packages("vcd")
library(vcd)
library(datasets)

data(Titanic)

str(Titanic)

mosaic(Titanic)
mosaic(Titanic, shade=TRUE, legend=TRUE)
mosaic(HairEyeColor, shade=TRUE, legend=TRUE)

# ex) banking transaction data mining

strucplot(Titanic, pop=FALSE)
?grid.edit
str(Titanic)
grid.edit("rect:Class=1st,Sex=Male,Age=Adult,Survived=Yes", gp=gpar(fill = "red"))

