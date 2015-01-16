library(RCurl)
library(d3Network)

ericOpenHtml <- function(filename){
  
  #print(Sys.info()["sysname"])
  
  if(Sys.info()["sysname"] == "Windows"){
    shell.exec(filename)      
  }else{
    system(paste("oepn",filename)) # mac case
  }  
}

# d3SimpleNetwork 사용 

Source <- c("A", "A", "A","A","B","B","C","C","D")
Target <- c("B", "C", "D","J","E","F","G","H","I")
NetworkData <- data.frame(Source, Target)

d3SimpleNetwork(NetworkData, width=400, height=250, file="test1.html")
ericOpenHtml("test1.html")


d3SimpleNetwork(NetworkData, width=400, height=250, fontsize=15, file="test2.html")
ericOpenHtml("test2.html")

d3SimpleNetwork(NetworkData, width=400, height=250, textColour="#D95FOE", linkColour="#FEC44F", nodeColour="#D95F0E", opacity=0.9, charge=-50, fontsize=15, file="test3.html")
ericOpenHtml("test3.html")


# d3ForceNetwork 사용
URL <- "https://raw.githubusercontent.com/christophergandrud/d3Network/master/JSONdata/miserables.json"
MisJson <- getURL(URL, ssl.verifypeer = FALSE)
MisLinks <- JSONtoDF(jsonStr=MisJson, array="links")
MisNodes <- JSONtoDF(jsonStr=MisJson, array="nodes")

head(MisLinks)
head(MisNodes)


d3ForceNetwork(Links=MisLinks, Nodes=MisNodes, Source="source", Target="target", 
               Value="value", NodeID="name", Group="group", width=1200, height=800, 
               opacity=0.9, zoom=TRUE, file="test4.html")
ericOpenHtml("test4.html")



#d3Tree 사용
library(RCurl)
URL <- "https://raw.githubusercontent.com/christophergandrud/d3Network/master/JSONdata/flare.json"
Flare <- getURL(URL, ssl.verifypeer = FALSE)
Flare <- rjson::fromJSON(Flare)
d3Tree(List=Flare, fontsize=8, diameter=1200, zoom=TRUE, file="test5.html")
ericOpenHtml("test5.html")


#d3Tree 사용2
CanadaPC <- list(name="Canada", children=list(list(name="NewFoundland", children= list(list(name="St. John's"))),
                                              list(name="PEI", children= list(list(name="Charlottetown"))),
                                              list(name="Nova Scotia", children= list(list(name="Halifax"))),
                                              list(name="New Brunswick", children= list(list(name="Fredericton"))),
                                              list(name="Quebec", children= list(list(name="Montreal"), list(name="Quebec City"))),
                                              list(name="Ontario", children= list(list(name="Toronto"), list(name="Ottawa"))),
                                              list(name="Manitoba", children= list(list(name="Winnipeg")))
                                              )
)
d3Tree(List=CanadaPC, fontsize=10, diameter=1200, textColour="#D95F0E", linkColour="#FEC44F", nodeColour="#D95F0E", 
       zoom=TRUE, file="test6.html")
ericOpenHtml("test6.html")


#d3Sankey 사용
URL <- "https://raw.githubusercontent.com/christophergandrud/d3Network/sankey/JSONdata/energy.json"
Energy <- getURL(URL, ssl.verifypeer = FALSE)

EngLinks <- JSONtoDF(jsonStr=Energy, array="links")
EngNodes <- JSONtoDF(jsonStr=Energy, array="nodes") 

d3Sankey(Links=EngLinks, Nodes=EngNodes,Source="source",Target="target",Value="value", NodeID="name",  fontsize=12,
       nodeWidth=30, file="test7.html")
ericOpenHtml("test7.html")



