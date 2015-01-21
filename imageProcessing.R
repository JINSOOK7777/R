source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("EBImage")
install.packages("brew")
install.packages("tiff",type="source")
library(EBImage)

Image<-readImage("coffee.PNG")
display(Image)  # Error in setwd(tempDir) : cannot change working directory 발생 중.

imageData(object)[1:5,1:6,1];

Image1 <- Image+0.2
Image2 <- Image-0.2
display(Image1); display(Image2) 
