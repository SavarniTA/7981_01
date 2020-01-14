library(readxl)
exfr<- read_excel("D:/SaleData.xlsx")

#1. Find the least amount sale that was done for each item.
aggregate(exfr[,'Sale_amt'], list(exfr$Item), min)


# 2. Compute the total sales for each year and region across all items 
exfr['year']=format(as.Date(exfr$OrderDate, format="%m/%d/%Y"),"%Y")
aggregate(exfr[,'Sale_amt'], list(exfr$Item,exfr$year,exfr$Region), sum)


# 3. Create new column 'days_diff' with number of days difference between reference date passed and each order date 
exfr$days_diff <-as.Date('01-02-2020','%m-%d-%Y')
exfr$days_diff<- difftime(exfr$days_diff ,exfr$OrderDate , units = c("days"))

# 4. Create a dataframe with two columns: 'manager', 'list_of_salesmen'. Column 'manager' will contain the unique managers present and column 'list_of_salesmen' will contain an array of all salesmen under each manager.
datfr<-aggregate(exfr['SalesMan'], list(exfr$Manager), unique)

# 5. For all regions find number of salesman and total sales. Return as a dataframe with three columns Region, salesmen_count and total_sale
fra<-aggregate(exfr['Sale_amt'], list(exfr$Region), sum)
df1<-aggregate(exfr['SalesMan'], list(exfr$Region), list)
fra['Salesman_count']<-c(1,1,1)
for(i in 1:3) {
  fra[i,3]<-length(unique(unlist(df1[i,2])))
  
}
colnames(fra)[1]<-'Region'
colnames(fra)[2]<-'total_sale'

# 6. Create a dataframe with total sales as percentage for each manager. Dataframe to contain manager and percent_sales
da<-aggregate(exfr['Sale_amt'], list(exfr$Manager), sum)
sumin<-sum(exfr$Sale_amt)
da['percent_sales']<-(da['Sale_amt']/sumin)*100
colnames(da)[1]<-"manager"