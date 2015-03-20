install.packages("KoNLP")
install.packages("RColorBrewer")
install.packages("wordcloud")
library(KoNLP)
library(RColorBrewer)
library(wordcloud)

a <- '나는 너를 사랑한다 정말일까?'
extractNoun(a)  #명사만 뽑음. 주로 명사만 뽑아 쓰는 게 작업이 필요함.

setwd("D:/R_files/RWorkspace/R/R/ADSP")
f <- file("광장_최인훈.txt", blocking=F)
txtLines <- readLines(f)
nouns <- sapply(txtLines, extractNoun, USE.NAMES=F)
close(f)

wordcount <- table(unlist(nouns))
pal <- brewer.pal(12,"Set3")
pal <- pal[-c(1:2)]
wordcloud(names(wordcount),freq=wordcount,scale=c(6,0.3),min.freq=25,
          random.order=T,rot.per=.1,colors=pal)
