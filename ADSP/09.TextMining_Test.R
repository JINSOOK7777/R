install.packages("tm")
library(tm)

txt <-system.file("texts","txt",package="tm")
txt

ovid <- Corpus(DirSource(txt),readerControl=list(language="lat"))

ovid
ovid[[1]]
ovid[[2]]
ovid[[1:2]]
getReaders()

reut21578 <- system.file("texts", "crude", package = "tm")
install.packages("XML")
reuters <- Corpus(DirSource(reut21578), list(reader = readReut21578XML))
reuters
reuters[[1]]
reuters <- tm_map(reuters, stripWhitespace)

docs <- c("this is a text", "this another one", "my name is eric")
Corpus(VectorSource(docs))
docsCorpus<-Corpus(VectorSource(docs))
docsCorpus[[1]]

inspect(docsCorpus[1:3])

reuters <- tm_map


################ 이후 작업 필요

# 교재 p 628

                  
                  