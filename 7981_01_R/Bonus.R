library(dplyr)
library(descr)
library(mltools)
library(readr)
library(tidyr)
library(imputeTS)


df<-read_delim("D:/imdb.csv", delim=',', escape_double=FALSE, escape_backslash=TRUE)
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

ques2(df)


df <- read.csv('D:/diamonds.csv')

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

ques3(df)


#5Ans
df<-read_delim("D:/imdb.csv", delim=',', escape_double=FALSE, escape_backslash=TRUE)
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
ques5(df)

df <- read.csv("movie_metadata.csv")

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

