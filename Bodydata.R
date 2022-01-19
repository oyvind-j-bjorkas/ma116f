# FUNCTIONS FOR DESCRIPTIVE STATISTICS
# Øyvind Jacobsen Bjørkås
#
# Please go to RStudio's preferences and set the working directory to
# where you store this program. 
#
# Then make a Data folder where you keep your data files. 
#
#
# 1. READING DATA
# 2. COMPUTING MEASURES
# 3. DRAWING TABLES AND GRAPHS
# 4. SOME PRETTYPRINTING
# 5. SOME ADDITIONAL GRAPHS

#test

# Installing a useful package: 
install.packages("skimr")
Yes
install.packages("epiDisplay")
#Loading the package:
library(skimr)
library(epiDisplay)

### 1. READING DATA

# read comma separated value (csv) file with ; as separator and , as decimal point
# (then we use the read.csv2 function)
# we often use 'df' as a variable name for the main data matrix (data frame)
df = read.csv2("../Excel/01 - Body Data.csv", sep=";", dec=",", )


### 2. COMPUTING MEASURES

#computing the mean of the variable 'AGE'
mean(df[['AGE']])

#computing the median
median(df[['AGE']])

#this doesn't work -- mode means something else. 
mode(df[['AGE']])

# R doesn't have a built-in mode function. So we must define our own: 
find_mode <- function(x) {
  u <- unique(x)
  tab <- tabulate(match(x, u))
  u[tab == max(tab)]
}

# Now we can use our own find_mode function: 
find_mode(df[['AGE']])

# The summary function: 
# summary for all variables: 
summary(df)
# summary for a couple variables: 
summary(df[c('AGE', 'PULSE')])

# Standard deviations: 
sapply(df,sd)

# A very useful function: 
skim(df)

# maximum and minimum value of AGE: 
max(df[['AGE']])
min(df[['AGE']])


### 3. DRAWING TABLES AND GRAPHS

# Simple frequency table
table(df[['AGE']])
# The previous, with fractions
prop.table(table(df[['AGE']]))

#using the function from epiDisplay: 
tab1(df[['AGE']])

#Making a frequency tables with "bins": 
bins <- seq(0.5,189.5,by=20)
ages <- cut(df[['AGE']], breaks=bins)
tab1(ages)

# the histogram function: 
# computes default bins and limits
hist(df[['AGE']])

#forcing bins: 
hist(df[['AGE']], breaks=bins)



### 4. SOME PRETTYPRINTING
#

hist(df[['AGE']], 
     breaks=bins, 
     main="Histogram of ages", 
     xlab = 'Age',
     ylab = 'Frequency', 
     col = 'light blue')

### 5. SOME ADDITIONAL GRAPHS
# The so-called "stem-and-leaf plot" can be seen as a histogram
# with bin values of 10 but with a little information of the 
# data in the bins
stem(df[['AGE']])

# stripchart provides the "dotplot" chart of figure 2-6. 
stripchart(df[['AGE']], method='stack')


### 6. THE SUBSET FUNCTION
# To get the subset of bears who are male,
# we use the condition 
#     SEX..1.M. == 1: 

df2 = subset(x = df, subset = SEX..1.M. == 1)