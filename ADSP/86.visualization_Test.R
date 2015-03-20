#####################
### Visulaization ###
#####################

install.packages("tabplot")
library(tabplot)
data(diamonds)
tableplot(diamonds,cex=1.8)


install.packages("googleVis")
library(googleVis)
data(Fruits)
MI<-gvisMotionChart()

#qplot

#ggplot
# install.packages("ggplot2")
library(ggplot2)
data(ChickWeight)
head(ChickWeight)
?ChickWeight

#6.1 X-Y Graph
ggplot(ChickWeight,aes(x=Time,y=weight,colour=Diet,group=Chick))+geom_line()
ggplot(ChickWeight,aes(x=Time,y=weight,colour=Diet))+geom_point(alpha=.3)+geom_smooth(alpha=.2,size=1) #신뢰구간에 맞춰 중간값으로 표기
ggplot(ChickWeight,aes(x=Time,y=weight,colour=Diet))+geom_smooth(alpha=.4,size=3)

#========================
#6.2 Histogram
ggplot(subset(ChickWeight,Time==21),aes(x=weight,colour=Diet))+geom_density()
ggplot(subset(ChickWeight,Time==21),aes(x=weight,fill=Diet))+geom_histogram(colour="black",binwidth=50)+facet_grid(Diet~.)
ggplot(subset(ChickWeight,Diet==4),aes(x=weight,fill=Time))+geom_histogram(colour="black",binwidth=50)+facet_grid(Time~.)

#========================
#6.3 Point Graph
head(mtcars)
?mtcars
p<-qplot(wt,mpg,colour=hp,data=mtcars)
p+coord_cartesian(ylim=c(0,40))
p+scale_colour_continuous(breaks=c(100,300))+coord_cartesian(ylim=c(0,40))
p+guides(colour="colourbar")
m<-mtcars[1:5,]
m
p%+%m # 무엇을 그릴 것인가에 subset을 넣는 방법 


#========================
#6.4 Bar Graph
head(mtcars)
c<-ggplot(mtcars,aes(factor(cyl)))
c+geom_bar()
c+geom_bar(fill='red')
c+geom_bar(fill='red',colour='blue')

k<-ggplot(mtcars,aes(factor(cyl),fill=factor(carb)))
k+geom_bar()

#Histgram
head(movies)
m<-ggplot(movies,aes(x=rating))
m+geom_histogram()
m+geom_histogram(aes(fill=..count..))

#========================
#6.5 Line Graph
head(economics)
b<-ggplot(economics,aes(x=date,y=unemploy))
b+geom_line()
b+geom_line(colour='red')
b+geom_point()
b+geom_point(colour='red')

#========================
#6.6 Effect
df<-data.frame(x=rnorm(5000),y=rnorm(5000))
h<-ggplot(df,aes(x,y))
h+geom_point()
h+geom_point(alpha=.5)
h+geom_point(alpha=1/10)

p<-ggplot(mtcars,aes(wt,mpg))
p+geom_point(size=4)
p+geom_point(aes(colour=factor(cyl)),size=4)

##################################################################################
# 꼭 아래 부분은 이해하고 넘어갈 것 
##################################################################################
install.packages("reshape2")
install.packages("plyr")

library(reshape2) #for melt
library(plyr) #for colwise

data(economics) # in ggplot2 package

rescale01<-function(x)(x-min(x))/diff(range(x))
ec_scaled<-data.frame(date=economics$date,colwise(rescale01)(economics[,-(1:2)]))
? colwise
# head(economics)
# head(economics[,-(1:2)])
head(ec_scaled)
ecm<-melt(ec_scaled,id="date")
head(ecm)
f<-ggplot(ecm,aes(date,value))
f+geom_line(aes(linetype=variable))

head(diamonds)
k<-ggplot(diamonds,aes(carat,..density..))+geom_histogram(binwidth=0.2)
k+facet_grid(.~cut)

w<-ggplot(diamonds,aes(clarity,fill=cut))
w+geom_bar()
w+geom_bar(aes(order=desc(cut)))

df<-data.frame(x=1:10,y=1:10)
f<-ggplot(df,aes(x=x,y=y))
f+geom_line(linetype=2)
f+geom_line(linetype='dotdash')

head(mtcars)
p<-ggplot(mtcars,aes(wt,mpg))
p+geom_point(size=4)
p+geom_point(aes(size=qsec))
p+geom_point(size=2.5)+geom_hline(yintercept=25,size=3.5)+geom_vline(xintercept=3,size=3.5)

p+geom_point()
p+geom_point(shape=5)
p+geom_point(shape="k",size=3)
p+geom_point(shape=".")
p+geom_point(shape=NA)

p+geom_point(aes(shape=factor(cyl)))
df2<-data.frame(x=1:5,y=1:25,z=1:25)
s<-ggplot(df2,aes(x=x,y=y))
s+geom_point(aes(shape=z-1),size=4)+scale_shape_identity()
? scale_shape_identity()

? lm
head(diamonds)
dmod<-lm(price~cut,data=diamonds)
cuts<-data.frame(cut=unique(diamonds$cut),predict(dmod,data.frame(cut=unique(diamonds$cut)),se=TRUE)[c('fit','se.fit')])
se<-ggplot(cuts,aes(x=cut,y=fit,ymin=fit-se.fit,ymax=fit+se.fit,colour=cut))
se+geom_pointrange()

p<-ggplot(mtcars,aes(wt,mpg))+geom_point()
p+annotate("rect",xmin=2,xmax=3.5,ymin=2,ymax=25,fill="dark grey",alpha=.5)  #alpha 투명도를 안주거나 1로 주면 뒤의 것이 안보이므로 꼭 표기토록


p<-qplot(disp,wt,data=mtcars)+geom_smooth()
p+scale_x_continuous(limits=c(150,350))
p+scale_y_continuous(limits=c(2,7))

d<-ggplot(diamonds,aes(carat,price)) + stat_bin2d(bins=25,colour="grey50")
d

d+scale_x_continuous(limits=c(0,2))
d+scale_y_continuous(limits=c(0,15000))
d+scale_x_continuous(limits=c(0,2))+scale_y_continuous(limits=c(0,15000))

qplot(cut,price,data=diamonds,geom='boxplot')
last_plot()+coord_flip()

qplot(cut,data=diamonds, geom="bar")
last_plot()+coord_flip()

h<-qplot(carat,data=diamonds,geom="histogram")
h
h+coord_flip()
h+coord_flip()+scale_x_reverse()

#========================
#6.7 Mutiple Axis

time<-seq(7000,3400,-200)
pop<-c(200,400,450,500,300,100,400,700,830,1200,400,350,200,700,370,800,200,100,120)
grp<-c(2,5,8,3,2,2,4,7,9,4,4,2,2,7,5,12,5,4,4)
med<-c(1.2,1.3,1.2,0.9,2.1,1.4,2.9,3.4,2.1,1.1,1.2,1.5,1.2,0.9,0.5,3.3,2.2,1.1,1.2)
par(mar=c(5,12,4,4)+0.1) #margin을 아래,왼쪽,위,오른쪽 값을 각각 5,12,4,4로 준 것 
par(mar=c(4,4,2,2))

plot(time,pop,axes=F,ylim=c(0,max(pop)),xlab="",ylab="",type="l",col="black",main="",xlim=c(7000,3400))
points(time,pop,pch=20,col="black",lwd=2)
axis(2,ylim=c(0,max(pop)),col="black",lwd=2)
mtext(2,text="Population",line=2)


########################
### Spatial Analysis ###
########################
install.packages("googleVis")
library(googleVis)
data(Fruits)
head(Fruits)
M1 <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(M1)

# googleVis
data(Exports)
head(Exports)

#Global
G1 <- gvisGeoChart(Exports, locationvar = 'Country', colorvar='Profit')
plot(G1)

#Plot only Europe
G2 <- gvisGeoChart(Exports, "Country", "Profit", options=list(region="150"))
plot(G2)
# https://developers.google.com/chart/interactive/docs/gallery/geochart?csw=1#Configuration_Options

#Example showing US data by state
library(datasets)
states <- data.frame(state.name, state.x77)
G3 <- gvisGeoChart(states, "state.name", "Illiteracy", options=list(region="US", displayMode="regions", resolution = "provinces", width=600, height=400))
head(states)
plot(G3)

G4 <- gvisGeoChart(CityPopularity, locationvar='City', colorvar='Popularity', options = list(region='US', height=350, displayMode = 'markers', colorAxis="{values:[200,400,600,800], colors:[\'red', \'pink\', \'orange', \'green']}"))
head(CityPopularity)
plot(G4)

G5 <- gvisGeoChart(Andrew, "LatLong", colorvar = 'Speed_kt', options=list(region="US"))
head(Andrew)
plot(G5)

G6 <- gvisGeoChart(Andrew, "LatLong", sizevar = 'Speed_kt', colorvar = "Pressure_mb", options=list(region="US"))
plot(G6)

require(stats)
data(quakes)
head(quakes)
quakes$latlong <- paste(quakes$lat, quakes$long, sep=":")

G7 <- gvisGeoChart(quakes, "latlong", "depth", "mag", options = list(displayMode = "Markers", region="009", colorAxis ="{colors : ['red', 'grey']}", backgroundColor="lightblue"))
plot(G7)

install.packages("XML")
library(XML)
url <- "http://en.wikipedia.org/wiki/List_of_countries_by_credit_rating"
x <- readHTMLTable(readLines(url), which=3)
levels(x$Rating) <- substring(levels(x$Rating), 4, nchar(levels(x$Rating)))
head(levels(x$Rating))
x$Ranking <- x$Rating
levels(x$Ranking) <- nlevels(x$Rating) : 1
x$Ranking <- as.character(x$Ranking)
x$Rating <- paste(x$Country, x$Rating, sep=":")
# Create a geo chart
G8 <- gvisGeoChart(x, "Country", "Ranking", hovervar="Rating", options=list(gvis.editor="S&P", colorAxis="{colors:['#91BFDB', '#FC8D59']}"))
plot(G8)
? plot

#plot world wide earth quakes of the late 30 days with magnitude >= 4.0
eq <- read.csv("http://earthquake.usgs.gov/earthquakes/feed/v0.1/summary/2.5_week.csv")
summary(eq)
eq$loc = paste(eq$Latitude, eq$Longitude, sep=":")


G9 <- gvisGeoChart(eq, "loc", "Depth", "Magnitude", options=list(displayMode="Markers", colorAxis="{colors:['purple', 'red', 'orange', 'grey']}", backgroundColor="lightblue"), chartid="EQ")
plot(G9)



################################################
# 유용) 국내 특정 지역을 맵으로 표기 
################################################

install.packages("ggmap")
install.packages("lubridate")
install.packages("RJSONIO")
library(ggmap)
library(lubridate)
# Satellite Map
mapImageData1 <- get_map(location=c(lon=126.97947, lat=37.54893),color="color",source="google",maptype="satellite",zoom=10)
ggmap(mapImageData1,extent="device",ylab="Latitude",xlab="Longitude")

# Terrain Map
mapImageData1 <- get_map(location=c(lon=126.97947, lat=37.54893),color="color",source="google",maptype="terrain",zoom=10)
ggmap(mapImageData1,extent="device",ylab="Latitude",xlab="Longitude")

# Various Maps
ggmap(get_googlemap(center='korea',zoom=7,maptype='roadmap'),extent='device')
ggmap(get_googlemap(center='korea',zoom=7,maptype='hybrid'),extent='device')

# earthquake in korea
eq<-read.table("eq.txt",sep="\t",header=T,stringsAsFactors=F)
head(eq)
eq$latitude<-unlist(strsplit(eq$latitude," "))[seq(from=1,to=nrow(eq),by=2)]
eq$latitude<-as.double(eq$latitude)
eq$longitude<-unlist(strsplit(eq$longitude," "))[seq(from=1,to=nrow(eq),by=2)]
eq$longitude<-as.double(eq$longitude)
?ymd_hm
eq$date<-ymd_hm(eq$date)
eq$year<-substr(eq$date,1,4)
head(eq)
ggmap(get_googlemap(center='korea',zoom=7,maptype='terrain'),extent='device')+geom_point(aes(x=longitude,y=latitude,size=power),data=eq, alpha=0.7)

# map with address
getGeoCode <- function(gcStr){
  library("RJSONIO")
  gcStr<-gsub(' ','%20',gcStr) # Encode URL Parameters
  # Open Connection
  connectStr<-paste('http://maps.google.com/maps/api/geocode/json?sensor=false&address=',gcStr,sep="")
  con <- url(connectStr)
  data.json <- fromJSON(paste(readLines(con),collapse=""))
  close(con)
  # Flatten the received JSON
  data.json <- unlist(data.json)
  if (data.json["status"]=="OK") {
    lat <- data.json["results.geometry.location.lat"]
    lng <- data.json["results.geometry.location.lng"]
    gcodes <- c(lat,lng)
    names(gcodes) <- c("Lat","Lng")
    return(gcodes)
  }
}

geoCodes <- getGeoCode("Palo Alto, California")
geoCodes

geoCodes <- getGeoCode("Seoul, South Korea")
geoCodes

geoCodes <- getGeoCode("Jongro Tower, Seoul, South Korea")
geoCodes

geoCodes <- getGeoCode("Jeju, South Korea")
geoCodes

geoCodes <- getGeoCode("종로타워 종로2가 종로구 서울 대한민국")
geoCodes

geoCodes <- getGeoCode("종각역")
geoCodes
