install.packages("twitteR")
install.packages("RColorBrewer")
install.packages("ROAuth")

library(twitteR) 
library(RColorBrewer)
library(ROAuth)
url_rqst<-"https://api.twitter.com/oauth/request_token"
url_acc<-"https://api.twitter.com/oauth/access_token"
url_auth<-"https://api.twitter.com/oauth/authorize"

API_key<-"iRUbMJ5wlVxnzSEoRr3oEewPy"
API_secret<-"YMMOpCGc7Y3Bb03fltHdyGjRYm0PnJi0kveTK1dwv81nkxbHT1"
Acc_token <-"2983482030-sy6RErVdXBYoNgs76uhyQ6RGIt6OeilTfzrpuwn"
Acc_secret <-"XmqJD3c34OFZLg7vZ9NblFtrkCE5n23fpWXMtcMmmgBs2"
#===============
setup_twitter_oauth(consumer_key=API_key, consumer_secret=API_secret, access_token=Acc_token,  access_secret=Acc_secret)  
  
# 한글 입수는 윈도우에서 안됨. 리눅스는 가능
# 한글은 파이썬등으로 입수하는 것은 추후 제공 예정, 긍정, 부정 사전 한글 버전도 존재 

apple_tweets<-searchTwitter("@apple",n=500)
head(apple_tweets)
length(apple_tweets)

ibm_tweets<-searchTwitter("@ibm",n=500)
head(ibm_tweets)
length(ibm_tweets)

ms_tweets<-searchTwitter("@microsoft",n=500)
head(ms_tweets)
length(ms_tweets)

library(plyr)
apple_text<-laply(apple_tweets,function(t)t$getText())
str(apple_text)
head(apple_text,3)

pos.word=scan("positive-words.txt",what="character",comment.char=";")
neg.word=scan("negative-words.txt",what="character",comment.char=";")

pos.words<-c(pos.word,"ripper","speed")
neg.words<-c(neg.word,"small","narrow")


# 감성점수 산정을 위한 사용자 함수 (긍정 단어수 _ 부정 단어수 = 감성점수)
# 보통 부정, 일반, 긍정 3가지로 분석 표기함.
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array ("a") of scores back, so we use
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence) # for english
    
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

head(apple_text,5)
Encoding(apple_text)[1:10]

apple_text<-apple_text[!Encoding(apple_text)=="UTF-8"]
head(apple_text,4)
apple_text[[10]]
apple_scores=score.sentiment(apple_text,pos.words,neg.words,.progress='text')
hist(apple_scores$score)

sample=c("You're awesome and Iloveyou","I hate and hate and hate. So angry. Die!","Impressedandamazed:youarepeerlessinyourachievementofunparalleledmediocrity.","I love you")
result<-score.sentiment(sample,pos.words,neg.words)
result$score

? tolower

