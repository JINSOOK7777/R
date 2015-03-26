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


# 자르기, 묶음 등등 
# 값을 받고 싶으면 Value를 리턴 받아 출력하여 분석해도 좋을 듯함.

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


?spec
# 아래 plots를 넓힌 후 실행해야 오류가 안남. 
data(tico)
# spectrum of the whole signal, in absolute or dB amplitude,
# horizontaly or vertically
op<-par(mfrow=c(2,2))
spec(tico,f=22050)
spec(tico,f=22050,col="red",plot=2)
spec(tico,f=22050,dB="max0",col="blue")
spec(tico,f=22050,dB="max0",col="green",plot=2)
par(op)
# an indirect way to compare spectra 
a<-spec(tico,f=22050,wl=512,at=0.2,plot=FALSE)
b<-spec(tico,f=22050,wl=512,at=0.7,plot=FALSE)
c<-spec(tico,f=22050,wl=512,at=1.1,plot=FALSE)
d<-spec(tico,f=22050,wl=512,at=1.6,plot=FALSE)
all<-cbind(a[,2],b[,2],c[,2],d[,2])
matplot(x=a[,1],y=all,yaxt="n",
        xlab="Frequency (kHz)",ylab="Amplitude",xaxs="i",type="l")
legend(8,0.8,c("Note A","Note B", "Note C", "Note D"),bty="o",
       lty=c(1:4),col=c(1:4))
# spectrum from a particular position to another one
op<-par(mfrow=c(2,1))
oscillo(tico,f=22050)
abline(v=c(0.5,0.9),col="red",lty=2)
spec(tico,f=22050,wl=512,from=0.5,to=0.9,col="red")
title("Spectrum of the note B")
par(op)
# spectrum and spectrogram
data(orni)
orni1<-cutw(orni,f=22050,from=0.32,to=0.39)
layout(matrix(c(1,2),nc=2),widths=c(3,1))
par(mar=c(5,4,3,0.5))
spectro(orni1,f=22050,wl=128,zp=8,ovlp=85,scale=FALSE)
par(mar=c(5,1,3,0.5))
spec(orni1,f=22050,col="red",plot=2,flab="",yaxt="n")


