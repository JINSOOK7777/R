# library(audio)
# audio.drivers()
playsong <- function(song) {
  if(is(song, "songnotes")){
    song <- makesong(song)
  }
  out <- play(song)
  if(out == 0){
    return(invisible())
  }
  xdgmime <- Sys.which("xdg-mime")
  if(xdgmime != ""){
    prog <- system("xdg-mime query default audio/x-wav", intern = TRUE)
    prog <- gsub(".desktop", "", prog, fixed = TRUE)
    prog.path <- Sys.which(prog)
    setWavPlayer(prog.path)
    out <- play(song)
    # Success - exit the function
    if(out == 0){
      return(invisible())
    }
  }
  if(Sys.info()["sysname"] == "Darwin"){
    filename <- tempfile("tuneRtemp", fileext = ".wav")
    *#on,.exit(unlink(filename))
    writeWave(song, filename)
    system(paste("open -a iTunes", filename))
    return(invisible())
  }
  if(out != 0){
    warning("Wave player is not currently set and autodetection failed\n",
            "Please set the desired player for Wave fles using the setWavPlayer function")
  }
}
library(tuneR)
dog <- data.frame()
dogframe <- function(file, class) {
  dogsound <- channel(readWave(file),"left")
  plot(tail(dogsound,50000))
  wobj <- FF(periodogram(dogsound, width = 1024, overlap = 512))
  tmp <- as.data.frame(wobj)
  tmp$class <- class
  colnames(tmp)[1] <- 'sound'
  tmp$class <- factor(tmp$class)
  dog <<- rbind(dog, tmp) 
}
dogframe("hungrydog1.wav", "hungry")
dogframe("happydog1.wav", "happy")
library(caret)
ind <- createDataPartition(dog$class,p=0.7,list=F)
train <- dog[ind,]
test <- dog[-ind,]
model <- train(class~sound,metho='rpart',data=train)
print(model$finalModel)
library(rattle)
fancyRpartPlot(model$finalModel)
confusionMatrix(predict(model,newdata=test),test$class)
table(predict(model),train$class)
table(predict(model,newdata=test),test$class)
# end of program