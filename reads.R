library(XML)
library(RCurl)
library(dplyr)
Sys.time()
tStart <- Sys.time()
rbind.all.columns <- function(x, y) {
  
  x.diff <- setdiff(colnames(x), colnames(y))
  y.diff <- setdiff(colnames(y), colnames(x))
  
  x[, c(as.character(y.diff))] <- NA
  
  y[, c(as.character(x.diff))] <- NA
  
  return(rbind(x, y))
}
for(i in 0:360){
  
  fileURL <- "https://api.tomtom.com/traffic/services/4/incidentDetails/s3/-6.259674,106.573391,-6.202251,106.696815/13/-1/xml?projection=EPSG4326&key=1J58CxRlEU2Moz8qwGxuaMqYoVpKZ7iD"
  xData <- getURL(fileURL)
  doc <- xmlParse(xData)
  xmldataframe <- xmlToDataFrame(doc)
  if(i==0){
    
    filterData1 <-filter(xmldataframe, !is.na(d))
    filterData1$date<-format(Sys.time(),"%H-%M-%S")
    write.csv(filterData, "xmldataa.csv", row.names = FALSE)
    print(filterData1)
    print(i)
  }
  if(i>0){
    temp<-filterData1
    filterData1 <-filter(xmldataframe, !is.na(d))
    filterData1$date<-format(Sys.time(),"%H-%M-%s")
    filterData1<- rbind.all.columns(temp,filterData1)
    print(filterData1)
    write.csv(filterData1, "xmldataa.csv", row.names = FALSE)
    print(i)
    
  }
  Sys.sleep(120.0)
}
filterData$r<-c()
filterData <- filterData %>%separate(p, c("latitude", "longitude"), "-")
filterData$longitude<-paste0("-", filterData$longitude) 
filterData$dl<-as.numeric(filterData$dl)
filterData$longitude<-as.numeric(filterData$longitude)
filterData$latitude<-as.numeric(filterData$latitude)
filterData$FromTo<-paste(filterData$f,filterData$t,sep = "-")
filterData$f<-c()
filterData$t<-c()

Sys.time()
Sys.time() - tStart
