#library(readxl)
#df<- read_excel("D:/SaleData.xlsx")

#1. Find the least amount sale that was done for each item.
least_sales <- function(df){
  ls <- aggregate(df[,'Sale_amt'], list(df$Item), min)
  return(ls)
}
#least_sales(df)


# 2. Compute the total sales for each year and region across all items 
sales_year_region <- function(df){
  df['year'] <- format(as.Date(df$OrderDate, format="%m/%d/%Y"),"%Y")
  ls <- aggregate(df[,'Sale_amt'], list(df$Item,df$year,df$Region), sum)
  return(ls)
}
#sales_year_region(df)


# 3. Create new column 'days_diff' with number of days difference between reference date passed and each order date 
days_diff <- function(df,refdate){
  df$days_diff <-as.Date(refdate,'%m-%d-%Y')
  df$days_diff<- difftime(df$days_diff ,df$OrderDate , units = c("days"))
  return(df)
}
#days_diff(df,'01-02-2020')


# 4. Create a dataframe with two columns: 'manager', 'list_of_salesmen'. Column 'manager' will contain the unique managers present and column 'list_of_salesmen' will contain an array of all salesmen under each manager.
mgr_slsmn <- function(df)
{
  datfr<-aggregate(df['SalesMan'], list(df$Manager), unique)
  return(datfr)
}
#mgr_slsmn(df)


# 5. For all regions find number of salesman and total sales. Return as a dataframe with three columns Region, salesmen_count and total_sale
slsmn_units <- function(df){
  fra<-aggregate(df['Sale_amt'], list(df$Region), sum)
  df1<-aggregate(df['SalesMan'], list(df$Region), list)
  fra['Salesman_count']<-c(1,1,1)
  for(i in 1:3) {
    fra[i,3]<-length(unique(unlist(df1[i,2])))
  }
  colnames(fra)[1]<-'Region'
  colnames(fra)[2]<-'total_sale'
  return(fra)
}
#slsmn_units(df)


# 6. Create a dataframe with total sales as percentage for each manager. Dataframe to contain manager and percent_sales
sales_pct<-function(df)
{
  da<-aggregate(df['Sale_amt'], list(df$Manager), sum)
  sumin<-sum(df$Sale_amt)
  da['percent_sales']<-(da['Sale_amt']/sumin)*100
  colnames(da)[1]<-"manager"
  return(da)
}
#sales_pct(df)

#library(dplyr)
#df<-read.csv("D:/imdb2.csv")
# 7. Get the imdb rating for fifth movie of dataframe
fifth_movie<-function(df){
  d=df[['imdbRating']][5]
  return(d)
}
#fifth_movie(df)

# 8. Return titles of movies with shortest and longest run time
movies<-function(df){
  min=df$title[which.min(df$duration)]
  max=df$title[which.max(df$duration)]
  ne=list(min,max)
  return(ne)
}
#movies(df)
# 9. Sort the data frame by in the order of when they where released and have higer ratings, Hint : release_date (earliest) and Imdb rating(highest to lowest)
sort_df<-function(df){
  dataf1<-df[order( df[,9],-df[,6] ),]
  return(dataf1)
}
#sort_df(df)


# 10. Subset the dataframe with movies having the following prameters. revenue more than 2 million spent less than 1 million duration between 30 mintues to 180 minutes 
#df<-read.csv("D:/movie_metadata.csv")
subset_df<-function(df){
  dataf1<-subset(df,(duration>30)&(duration<180)&(gross>2000000)&(budget<1000000))
  return(dataf1)
}
#subset_df(df)


#df<-read.csv("D:/diamonds.csv")
#library(dplyr)

# 11. Count the duplicate rows of diamonds DataFrame.
dupl_rows<-function(df){
  l=nrow(df)-nrow(unique(df))
  return(l)
}
#dupl_rows(df)


# 12. Drop rows in case of missing values in carat and cut columns. 
drop_row<-function(df){
  dfr<-df[complete.cases(df[ , 1:2]),]
  return(dfr)
}
#drop_row(df)


# 13. Subset the dataframe with only numeric columns.
sub_numeric<-function(df){
  dfr1<-select_if(df, is.numeric)
  return(dfr1)
}
#sub_numeric(df)

# 14. Compute volume as (x y z) when depth is greater than 60. In case of depth less than 60 default volume to 8. 
volume<-function(df){
  df$z = as.numeric(as.character(df$z))
  df$z[is.na(df$z)] <- 0
  df$volume<-0
  df$volume<-ifelse(df$depth,df$x*df$y*df$z,8)
  return(df)
}
#volume(df)

# 15. Impute missing price values with mean.
impute<-function(df){
  dfr3<-df
  dfr3$price <- ifelse(is.na(dfr3$price), mean(dfr3$price, na.rm=TRUE), dfr3$price)
  return(dfr3)
}
#impute(df)

#library(dplyr)
#library(descr)
#library(mltools)
#library(readr)
#library(tidyr)
#library(imputeTS)


#df<-read_delim("D:/imdb.csv", delim=',', escape_double=FALSE, escape_backslash=TRUE)
#2Ans
ques2<-function(df)
{
  df$length1<-nchar(gsub(" ","",df$wordsInTitle,fixed=TRUE))
  df$quantile<-as.numeric(ntile(df$length1,4))
  df3<-as.data.frame.matrix(table(df$year,df$quantile))
  df4<-df%>%group_by(year)%>%summarise(minimum=min(length1,na.rm=TRUE),maximum=max(length1,na.rm=TRUE))
  df4<-drop_na(df4)
  df5<-cbind(df4,df3)
  row.names(df5)<-NULL
  return(df5)
}

#ques2(df)


#df <- read.csv('D:/diamonds.csv')

#3Ans
ques3<-function(df){
  depth.filter<-df$depth>60
  v<-c()
  for(i in 1:length(depth.filter)){
    if(depth.filter[i]){
      vol<-(as.numeric(as.character(df$x[i]))*
              as.numeric(as.character(df$y[i]))*
              as.numeric(as.character(df$z[i])))
    }
    else{
      vol<-8
    }
    v<-c(v,vol)
  }
  df$volume<-v
  df$Bins<-as.numeric(ntile(df$volume,5))
  tvol=sum(df$volume)
  t<-crosstab(df$Bins,df$cut,plot=FALSE,prop.t=TRUE)
  return(t)
}

#ques3(df)


#5Ans
#df<-read_delim("D:/imdb.csv", delim=',', escape_double=FALSE, escape_backslash=TRUE)
ques5<-function(df)
{
  df<-na_mean(df)
  df$deciles<-as.numeric(ntile(df$duration,10))
  df1<-df%>%group_by(deciles)%>%summarise(nr_Of_Nominations=sum(nrOfNominations,na.rm=TRUE),nr_Of_Wins=sum(nrOfWins))
  df1$count<-as.data.frame(table(df$deciles))['Freq']
  df2<-df[c(17:44)]
  df3<-df2%>%group_by(deciles)%>%summarise_all(sum)
  df3<-as.data.frame.matrix(t(df3))
  names<-row.names(df3)
  high<-function(x)
  {
    return(names[order(x,decreasing = TRUE)[1:3]])
  }
  df4<-as.data.frame.matrix(t(sapply(df3,high)))
  colnames(df4)<-c('first','second','third')
  df1['top genres']<-paste(df4$first,',',df4$second,',',df4$third)
  return(df1)
}
#ques5(df)

#df <- read.csv("movie_metadata.csv")

#Ques1
ques1<-function(df)
{
  df1=df %>%group_by(title_year,genres,color)%>%
    summarize(mean = mean(imdb_score, na.rm = TRUE),
              min = min(imdb_score),sum_of_duration = sum(duration, na.rm = TRUE))
}

#Ques4
ques4<-function(df)
{
  df<-df %>% drop_na()
  df2<-df %>% group_by(title_year)%>%summarise(Avg_Rating=mean(imdb_score))
  return(df2)
}



