library(dplyr)
df<-read.csv("D:/imdb2.csv")
# 7. Get the imdb rating for fifth movie of dataframe
fifth_movie<-function(df){
  d=df[['imdbRating']][5]
  return(d)
}
fifth_movie(df)

# 8. Return titles of movies with shortest and longest run time
movies<-function(df){
min=df$title[which.min(df$duration)]
max=df$title[which.max(df$duration)]
ne=list(min,max)
return(ne)
}
movies(df)
# 9. Sort the data frame by in the order of when they where released and have higer ratings, Hint : release_date (earliest) and Imdb rating(highest to lowest)
sort_df<-function(df){
  dataf1<-df[order( df[,9],-df[,6] ),]
  return(dataf1)
}
sort_df(df)


# 10. Subset the dataframe with movies having the following prameters. revenue more than 2 million spent less than 1 million duration between 30 mintues to 180 minutes 
df<-read.csv("D:/movie_metadata.csv")
subset_df<-function(df){
dataf1<-subset(df,(duration>30)&(duration<180)&(gross>2000000)&(budget<1000000))
return(dataf1)
}
subset_df(df)
