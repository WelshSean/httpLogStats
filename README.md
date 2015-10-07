# httpLogStats
Evaluate HTTP Log Stats using R

## Function usage

 Load httpLogStats.R into R or RStudio and source it - the you can run the function "proclogs"
 
 Arguments are:
                 filename - file to process (default access.log)
                 wdir - working directort (Default to /Users/Sean/ss/R) - you will need to change this!
                 
                 
 Output will be summarised data of the form

```  
min mbytespsec   avresp Failures Success                time
  1    0   11.70955 337287.8        2     700 2015-03-30 05:04:17
  2    1   13.37738 348153.7        2     834 2015-03-30 05:05:17
  3    2   14.67892 280089.1        2     908 2015-03-30 05:06:17
  4    3   13.89663 285306.3        2     767 2015-03-30 05:07:17
```


 Where minute is minutes since the start of the sample
 
 mbytespsec is the Megabytes transferred per minute
 
 avresp is the Mean Response time for requests by minute
 
 Failures is the number of failed requests requests in that minute
 
 Success is the number of successful requests in that minute
