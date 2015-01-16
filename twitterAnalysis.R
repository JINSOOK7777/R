library(twitteR)
library(RColorBrewer)
library(KoNLP)

# 트위터 인증 
load("twitter_credentials")
registerTwitterOAuth(twitCred)


apple_tweets<-searchTwitter("@apple",n=500,cainfo="cacert.pem")
ibm_tweets<-searchTwitter("@ibm",n=500,cainfo="cacert.pem")
ms_tweets<-searchTwitter("@microsoft",n=500,cainfo="cacert.pem")

pos.word=scan("positive-words.txt",what="character",comment.char=";")
neg.word=scan("negative-words.txt",what="character",comment.char=";")


score.sentiment = function(sentences, pos.words, neg.words, .progress='none'){

  require(plyr)
  require(stringr)

  scores = laply(sentences, function(sentence, pos.words, neg.words){

    sentence = gsub('[[:punct:]]','',sentence)
    sentence = gsub('[[:cntrl:]]','',sentence)
    sentence = gsub('\\d+','',sentence)

    sentence = tolower(sentence)

    word.list = str_split(sentence, '\\s+')

    words=unlist(word.list)

    pos.matches=match(words, pos.words)
    neg.matches=match(words, neg.words)
    
    pos.matches=!is.na(pos.matches)
    neg.matches=!is.na(neg.matches)
    
    score=sum(pos.matches) - sum(neg.matches)
    return(score)
    
  }, pos.words, neg.words, .progress=.progress)

  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)

}

library(plyr)
apple_text<-laply(apple_tweets,function(t)t$getText())
str(apple_text)

head(apple_text,3)
Encoding(apple_text)[1:10]
apple_text<-apple_text[!Encoding(apple_text)=="UTF-8"]
head(apple_text,4)
apple_text[[10]]
apple_scores=score.sentiment(apple_text,pos.word,neg.word,.progress='text')
hist(apple_scores$score)

ibm_text<-laply(ibm_tweets,function(t)t$getText())
head(ibm_text,3)
ibm_text<-ibm_text[!Encoding(ibm_text)=="UTF-8"]
ibm_scores=score.sentiment(ibm_text,pos.word,neg.word,.progress='text')
hist(ibm_scores$score)

ms_text<-laply(ms_tweets,function(t)t$getText())
head(ms_text,3)
ms_text<-ms_text[!Encoding(ibm_text)=="UTF-8"]
ms_scores=score.sentiment(ms_text,pos.word,neg.word,.progress='text')
hist(ms_scores$score)



