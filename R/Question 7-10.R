
library(dplyr)
dataf<-read.csv("D:/imdb2.csv")
# 7. Get the imdb rating for fifth movie of dataframe
dataf[['imdbRating']][5]

# 8. Return titles of movies with shortest and longest run time
print('minimum duration:')
dataf$title[which.min(dataf$duration)]

print('maximum duration:')
dataf$title[which.max(dataf$duration)]

# 9. Sort the data frame by in the order of when they where released and have higer ratings, Hint : release_date (earliest) and Imdb rating(highest to lowest)
dataf1<-dataf[order( dataf[,9],-dataf[,6] ),]


# 10. Subset the dataframe with movies having the following prameters. revenue more than 2 million spent less than 1 million duration between 30 mintues to 180 minutes 
dataf<-read.csv("D:/movie_metadata.csv")
dataf1<-subset(dataf,(duration>30)&(duration<180)&(gross>2000000)&(budget<1000000))
