library(arules)
library(FSelector)

thrunum <- data.frame(pd[c(1,10:21)])
thrunum <- thrunum[c(1:7,10:13)]
thrunum <- na.omit(thrunum)

thrunumout <- thrunum[thrunum$TCP.Downlink.Throughput.Mbps. <= 10,c(1,7:11)]
thrunumout <

thrucats <- data.frame(pd[c(34,3:9,22:33)])
thrucats <- na.omit(thrucats)

retnum <- data.frame(pd[c(2,10:21)]) 
retnum <- retnum[,c(1,3:7,10:13)]
retnum <- na.omit(retnum)

retcats <- data.frame(pd[c(35,3:9,22:33)])
retcats <- na.omit(retcats)

library(plyr)

igthru <- information.gain(TCP.Downlink.Throughput.Mbps._cat~., thrucats)
#igthru <- arrange(igthru, -attr_importance)
igwpret <- information.gain(Web.Page.Retainability_cat~., retcats)
#igwpret <- arrange(igwpret, -attr_importance)

suthru <- symmetrical.uncertainty(TCP.Downlink.Throughput.Mbps._cat~., thrucats)
#suthru <- arrange(suthru, -attr_importance)
suwpret <- symmetrical.uncertainty(Web.Page.Retainability_cat~., retcats)
#suwpret <- arrange(suwpret, -attr_importance)
