df<-read.csv("D:/diamonds.csv")
library(dplyr)

# 11. Count the duplicate rows of diamonds DataFrame.
dupl_rows<-function(df){
l=nrow(df)-nrow(unique(df))
return(l)
}
dupl_rows(df)


# 12. Drop rows in case of missing values in carat and cut columns. 
drop_row<-function(df){
dfr<-df[complete.cases(df[ , 1:2]),]
return(dfr)
}
drop_row(df)


# 13. Subset the dataframe with only numeric columns.
sub_numeric<-function(df){
dfr1<-select_if(df, is.numeric)
return(dfr1)
}
sub_numeric(df)

# 14. Compute volume as (x y z) when depth is greater than 60. In case of depth less than 60 default volume to 8. 
volume<-function(df){
df$z = as.numeric(as.character(df$z))
df$z[is.na(df$z)] <- 0
df$volume<-0
df$volume<-ifelse(df$depth,df$x*df$y*df$z,8)
return(df)
}
volume(df)

# 15. Impute missing price values with mean.
impute<-function(df){
dfr3<-df
dfr3$price <- ifelse(is.na(dfr3$price), mean(dfr3$price, na.rm=TRUE), dfr3$price)
return(dfr3)
}
impute(df)

