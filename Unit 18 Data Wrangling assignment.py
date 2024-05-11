#!/usr/bin/env python
# coding: utf-8

# In[3]:


import os
import pandas as pd


# In[4]:


#Read the data set and see what features and records it has.
df=pd.read_csv('college_graduation_rate_at_fouryear_institutions_within_six_years_of_start_usafacts.csv', header=[0], index_col=[0])
print(df.head())


# In[5]:


df.shape


# In[6]:


#Checking the data type of each column.
df.info()
#Why do the years between 2002 and 2008 all come up as object when the rest are floats?


# In[7]:


#Switch the rows and columns so that the years become the records and the different rates become the columns.
df_T = df.transpose()
print(df_T.head())


# In[8]:


df_T.columns


# In[9]:


#Drop the columns with all NaN values.
df=df_T.drop([ '    By gender','    By type of institution','    By race and ethnicity or residency', 'Sources:', 'Exported on: 05/04/2024'], axis=1)


# In[10]:


df.columns


# In[11]:


df.head()
#Still need to eliminate the nan columns, but cannot use the drop method because of the name at this moment.
df.drop(df.columns[len(df.columns)-1], axis=1, inplace=True)


# In[12]:


df.columns


# In[13]:


print(df)


# In[24]:


#It seems the years from 2002 to 2010 are the most inconsistent. These years contain the most NaN values. 
#There are too many NaN values to interpolate and the mean does not make a reasonable replacement for values increasing with time.
df = df.dropna()
print(df)



# In[27]:


print(df.dtypes)


# In[28]:


dfcols = df.columns
print(dfcols)


# In[30]:


#The columns should be numeric values. The rows before transposing were numeric.
df[dfcols] = df[dfcols].apply(pd.to_numeric, errors='coerce')
print(df.dtypes)


# In[31]:


#Now that the columns are numeric, they need to be described.
df.describe([.25, .5, .75])


# In[33]:


#The ranges of each column.
col_ranges = df.max() - df.min()
print(col_ranges)


# In[ ]:




