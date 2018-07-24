library(XML)
library(RCurl)
library(tidyr)
library(dplyr)
library(ggplot2)
# The predictor vector.
xy <-filter(filterData,FromTo=="Tangerang [18]-Karang Tengah [11]")
xy$l <- as.numeric(as.character(xy$l))
xy$dl <- as.numeric(as.character(xy$dl))
xy$ic <- as.numeric(as.character(xy$ic))
xy$ty <- as.numeric(as.character(xy$ty))
xy$Time <- as.POSIXct(xy$Time,format="%Y-%m-%d %H-%M-%S")
xy$FromTo <- as.factor(as.character(xy$FromTo))
xy$d<-as.factor(as.character(xy$d) )

column_class <- lapply(xy,class)
column_class <- column_class[column_class != "factor"]
factor_levels <- lapply(xy, nlevels)
factor_levels <- factor_levels[factor_levels > 1]
xy <- xy[,which(names(xy) %in% c(names(factor_levels), names(column_class)))]


a <- data.frame(xy[c(nrow(filterData)),])
a$dl<-c()
xy <- xy[-c(nrow(filterData)),]

# Apply the lm() function.
relation <- lm(dl~.,data = xy)

result <-  predict(relation,a)

a$dl <- result

xya <-filter(filterData,FromTo=="Tangerang [18]-Karang Tengah [11]")