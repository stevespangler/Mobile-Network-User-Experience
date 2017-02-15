# Script to create a summary of dataset
#
# coding: utf-8

import pandas as pd
import numpy as np

## Custom median function to deal with data type errors

def mymed(x):
    try:
        x.median()
        return x.median()
    except TypeError:
        return None
    except ValueError:
        return None


## Input data
mydata = pd.read_csv('projectdata.csv', na_values='(null)')

## If necessary, change data types for columns
## i.e. Numeric ID data to strings

mydata.location_id = mydata.location_id.astype('str')

##

sumdf = pd.DataFrame()
sumdf['Header'] = mydata.columns
sumdf['DataType'] = mydata.dtypes.values
sumdf['NumberRecords'] = len(mydata)
sumdf['NumberNull'] = mydata.isnull().sum().values
sumdf['NullPercent'] = sumdf.NumberNull / sumdf.NumberRecords
sumdf['Uniques'] = mydata.apply(lambda x: len(x.unique())).values
sumdf['MostFreq'] = mydata.apply(lambda x: x.value_counts().index[0]).values  # OR mydata.apply(lambda x: x.mode()[0]).values
sumdf['MostFreqCount'] = mydata.apply(lambda x: x.value_counts().values[0]).values
sumdf['MostFreqPercent'] = sumdf.MostFreqCount / sumdf.NumberRecords
sumdf['MinValue'] = mydata.describe(include='all').T['min'].values
sumdf['Median'] = mydata.apply(lambda x: mymed(x)).values
sumdf['MaxValue'] = mydata.describe(include='all').T['max'].values
sumdf['Mean'] = mydata.describe(include='all').T['mean'].values
sumdf['StDev'] = mydata.describe(include='all').T['std'].values
# Add entropy later
# sumdf['Entropy'] = 

## Output dataframe to CSV
sumdf.to_csv('datasummary.csv')

