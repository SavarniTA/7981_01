# import pandas, numpy
# Create the required data frames by reading in the files

# Q1 Find least sales amount for each item
def least_sales(df):
    ls = df.groupby(["Item"])["Sale_amt"].min()
    return ls

# Q2 compute total sales at each year X region
def sales_year_region(df):
    lss = df.groupby(["Region",pd.DatetimeIndex(df['OrderDate']).year,"Item"])["Sale_amt"].sum()
    return lss

# Q3 append column with no of days difference from present date to each order date
def days_diff(df,refdate):
    ref_date = pd.to_datetime(refdate)
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
    h=df['imdbRating'][4]
    return h
# Q8 return titles of movies with shortest and longest run time
def movies(df):
    minval=df[df["duration"]==df["duration"].min()]["title"]
    maxval=df[df["duration"]==df["duration"].max()]["title"]
    return minval,maxval

# Q9 sort by two columns - release_date (earliest) and Imdb rating(highest to lowest)
def sort_df(df):
    so=df.sort_values(by=['year', 'imdbRating'],ascending = [True,False])
    return so

# Q10 subset revenue more than 2 million and spent less than 1 million & duration between 30 mintues to 180 minutes
def subset_df(df):
    sa=df[(df['gross'].astype(float)>2000000)&(df['budget'].astype(float)<1000000) & (df['duration'].astype(float)>30) &    (df['duration'].astype(float)<180)]
    return sa

# Q11 count the duplicate rows of diamonds DataFrame.
def dupl_rows(df):
    q=len(df[df.duplicated()])
    return q

# Q12 droping those rows where any value in a row is missing in carat and cut columns
def drop_row(df):
    hs=df.dropna(subset=['carat','cut'])
    return hs

# Q13 subset only numeric columns
def sub_numeric(df):
    num=df._get_numeric_data()
    return num

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
    df=df.fillna(df.mean())
    return df

#Bonus Questions:

# Q1 Generate a report that tracks the various Genere combinations for each type year on year.
# The result data frame should contain type, Genere_combo, year, avg_rating, min_rating, max_rating,total_run_time_mins

def ques1(df):
    df['GenreCombo']=df[df.columns[16:]].T.apply(lambda g: '|'.join(g.index[g==1]),axis=0)
    res=df.groupby(["type","year","GenreCombo"]).agg({"imdbRating":[min,max,np.mean],'duration':np.sum})
    return res


# Q2 Is there a realation between the length of a movie title and the ratings ? Generate a report that captures
#the trend of the number of letters in movies titles over years. We expect a cross tab between the year of
#the video release and the quantile that length fall under. The results should contain year, min_length,
#max_length, num_videos_less_than25Percentile, num_videos_25_50Percentile ,
#num_videos_50_75Percentile, num_videos_greaterthan75Precentile

def ques2(df):
    df['Title_Length']=df['title'].apply(lambda x:len(x.split('(')[0].replace(" ","").rstrip()))
    dataf=pd.crosstab(df.year,df.Quantile,margins=False)
    dataf["min"]=df.groupby(["year"])["Title_Length"].min()
    dataf["max"]=df.groupby(["year"])["Title_Length"].max()
    return dataf

def core(df):
    d=df['Title_Length'].corr(df['imdbRating'])
    return d 


#Q3 In diamonds data set Using the volumne calculated above, create bins that have equal population within
#them. Generate a report that contains cross tab between bins and cut. Represent the number under
#each cell as a percentage of total.

def ques3(df):
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
    df["bins"]=pd.qcut(df["volume"],q=5,labels=['1','2','3','4','5'])
    df3=(pd.crosstab(df["bins"],df["cut"],normalize=True))*100
    return df3


#Q4 Generate a report that tracks the Avg. imdb rating quarter on quarter, in the last 10 years, for movies
#that are top performing. You can take the top 10% grossing movies every quarter. Add the number of top
#performing movies under each genere in the report as well.


def ques4(df,df2):
    import math  
    df['url']=df['movie_imdb_link'].apply(lambda x:x.split('?')[0])
    k=pd.DataFrame()
    hh=df['title_year'].unique()
    for x in hh:
        ll1=df[(df['title_year']==x)]
        lr=ll1.sort_values(by=['gross'], ascending=False)
        g=lr.head(math.ceil(len(ll1)*0.10))
        k=k.append(g)
    q=pd.merge(k,df2,on="url",how="left")
    genres=q.loc[:,'Action':'Western'].columns.tolist()
    m=pd.DataFrame()
    m=q.groupby("title_year")[genres].sum()
    m['Avg_imdb']=q.groupby("title_year")["imdb_score"].mean()
    return m
#df=pd.read_csv("movie_metadata.csv",escapechar="\\")
#df2=pd.read_csv("imdb.csv",escapechar="\\")
#ques4(df,df2)


#Q5 Bucket the movies into deciles using the duration. Generate the report that tracks various features like
#nomiations, wins, count, top 3 geners in each decile.

def ques5(df):
    df['Decile'] = pd.qcut(df['duration'], 10, labels=False)
    datf=df.groupby(["Decile"]).agg({"nrOfNominations":np.sum,"nrOfWins":np.sum})
    datf["count"]=df.groupby("Decile")["year"].count()
    datf.columns=["Total Nominations","Total Wins","Total Count"]
    #dataf1=pd.crosstab(df.GenreCombo,df.Decile,margins=False)
    dataf1=(df.groupby("Decile")[df.loc[:,'Action':'Western'].columns.tolist()].sum()).transpose()
    dat=pd.DataFrame(dataf1.apply(lambda x: x.nlargest(3).index,axis=0).transpose(),)
    datf["TopGenreCombos"]=dat[1]+","+dat[2]+","+dat[0]
    return datf
