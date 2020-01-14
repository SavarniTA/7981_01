dataf<-read.csv("D:/diamonds.csv")
library(dplyr)

# 11. Count the duplicate rows of diamonds DataFrame.
print(nrow(dataf)-nrow(unique(dataf)))

# 12. Drop rows in case of missing values in carat and cut columns. 
dfr<-dataf[complete.cases(dataf[ , 1:2]),]


# 13. Subset the dataframe with only numeric columns.
dfr1<-select_if(dataf, is.numeric)


# 14. Compute volume as (x y z) when depth is greater than 60. In case of depth less than 60 default volume to 8. 
dataf$z = as.numeric(as.character(dataf$z))
dataf$z[is.na(dataf$z)] <- 0
dataf$volume<-0
dataf$volume<-ifelse(dataf$depth,dataf$x*dataf$y*dataf$z,8)

# 15. Impute missing price values with mean.
dfr3<-dataf
dfr3$price <- ifelse(is.na(dfr3$price), mean(dfr3$price, na.rm=TRUE), dfr3$price)


