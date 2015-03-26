##########################################
#sound 관련 패키지 
##########################################
#tuneR < wav파일을 읽는 게(readWave) 큰 목적
#audio
#seewave < 가장 많이 사용됨 

#install.packages("tuneR")
library(tuneR)
?readWave
Wobj <- sine(440)
tdir <- getwd()
tfile <- file.path(tdir, "M1F1-Alaw-AFsp.wav")
writeWave(Wobj, filename = tfile)
list.files(tdir, pattern = "\\.wav$")
newWobj <- readWave(tfile)
newWobj
#file.remove(tfile)
#사전 해당 미디어 플레이어가 지정되어야 함.(해당 wav 파일을 클릭시 미디어 플레이어 선택 가능)
play(newWobj)


#install.packages("audio")
#install.packages("seewave")
library(audio)
library(seewave)
?timer
data(tico)
timer(tico,f=22050,threshold=5,msmooth=c(50,0))
# to compare with an oscillographic representation
# play(tico)
data(orni)
op<-par(mfrow=c(1,1))
timer(orni,f=22050,threshold=5,msmooth=c(40,0),tck=0.05,
      bty="l",colval="blue")
title(main="A cicada song made of five echemes",col="blue")
oscillo(orni,f=22050,k=1,j=1)
par(op)

