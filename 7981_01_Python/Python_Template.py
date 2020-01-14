# import pandas, numpy
# Create the required data frames by reading in the files

# Q1 Find least sales amount for each item
# has been solved as an example
def least_sales(df):
    # write code to return pandas dataframe
	ls = df.groupby(["Item"])["Sale_amt"].min()
    return ls

# Q2 compute total sales at each year X region
def sales_year_region(df):
    lss = df.groupby(["Region",pd.DatetimeIndex(df['OrderDate']).year,"Item"])["Sale_amt"].sum()
    return lss

# Q3 append column with no of days difference from present date to each order date
def days_diff(df):
    ref_date = pd.to_datetime('1-1-2016')
    df['Diff_Date']=df['OrderDate']-ref_date
    return df

# Q4 get dataframe with manager as first column and  salesman under them as lists in rows in second column.
def mgr_slsmn(df):
    new=df.groupby('Manager')['SalesMan'].unique().reset_index(name='list_of_salesmen')
    return new

# Q5 For all regions find number of salesman and number of units
def slsmn_units(df):
    df1=pd.DataFrame()
    df1['total_sales']=df.groupby(["Region"])["Sale_amt"].sum()
    df1['salesman_count']=df.groupby("Region")["SalesMan"].nunique()
    return df1

# Q6 Find total sales as percentage for each manager
def sales_pct(df):
    data=pd.DataFrame()
    data=df.groupby(["Manager"])["Sale_amt"].sum()/df['Sale_amt'].sum()*100
    return data

# Q7 get imdb rating for fifth movie of dataframe
def fifth_movie(df):
	df['imdbRating'][4]

# Q8 return titles of movies with shortest and longest run time
def movies(df):
	minval=df[df["duration"]==df["duration"].min()]["title"]
    maxval=df[df["duration"]==df["duration"].max()]["title"]
    return minval,maxval

# Q9 sort by two columns - release_date (earliest) and Imdb rating(highest to lowest)
def sort_df(df):
	df.sort_values(by=['year', 'imdbRating'],ascending = [True,False])
    return df

# Q10 subset revenue more than 2 million and spent less than 1 million & duration between 30 mintues to 180 minutes
def subset_df(df):
	df=pd.read_csv("movie_metadata.csv")
    df[(df['gross'].astype(float)>2000000)&(df['budget'].astype(float)<1000000) & (df['duration'].astype(float)>30) &    (df['duration'].astype(float)<180)]

# Q11 count the duplicate rows of diamonds DataFrame.
def dupl_rows(df):
	len(df[df.duplicated()])

# Q12 droping those rows where any value in a row is missing in carat and cut columns
def drop_row(df):
	df.dropna(subset=['carat','cut'])

# Q13 subset only numeric columns
def sub_numeric(df):
	df._get_numeric_data()

# Q14 compute volume as (x*y*z) when depth > 60 else 8
def volume(df):
	df['z'].fillna(0, inplace = True) 
    for i in range(0,len(df)):
    if(df['z'][i]=="None"):
        df['z'][i]=0
    for i in range(0,len(df)):
    df['z']=df['z'].astype(float)
    ans=[]
    for i in range(0,len(df)):
        if df['depth'][i]>60:
            ans.append(df['x'][i]*df['y'][i]*df['z'][i])
        else:
            ans.append(8)
    df['volume']=ans
    return df


# Q15 impute missing price values with mean
def impute(df):
	df.fillna(df.mean())
