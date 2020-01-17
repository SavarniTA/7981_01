library(readxl)
df<- read_excel("D:/SaleData.xlsx")

#1. Find the least amount sale that was done for each item.
least_sales <- function(df){
  ls <- aggregate(df[,'Sale_amt'], list(df$Item), min)
  return(ls)
}
least_sales(df)


# 2. Compute the total sales for each year and region across all items 
sales_year_region <- function(df){
df['year'] <- format(as.Date(df$OrderDate, format="%m/%d/%Y"),"%Y")
ls <- aggregate(df[,'Sale_amt'], list(df$Item,df$year,df$Region), sum)
return(ls)
}
sales_year_region(df)


# 3. Create new column 'days_diff' with number of days difference between reference date passed and each order date 
days_diff <- function(df,refdate){
df$days_diff <-as.Date(refdate,'%m-%d-%Y')
df$days_diff<- difftime(df$days_diff ,df$OrderDate , units = c("days"))
return(df)
}
days_diff(df,'01-02-2020')


# 4. Create a dataframe with two columns: 'manager', 'list_of_salesmen'. Column 'manager' will contain the unique managers present and column 'list_of_salesmen' will contain an array of all salesmen under each manager.
mgr_slsmn <- function(df)
{
datfr<-aggregate(df['SalesMan'], list(df$Manager), unique)
return(datfr)
}
mgr_slsmn(df)


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
slsmn_units(df)


# 6. Create a dataframe with total sales as percentage for each manager. Dataframe to contain manager and percent_sales
sales_pct<-function(df)
{
da<-aggregate(df['Sale_amt'], list(df$Manager), sum)
sumin<-sum(df$Sale_amt)
da['percent_sales']<-(da['Sale_amt']/sumin)*100
colnames(da)[1]<-"manager"
return(da)
}
sales_pct(df)