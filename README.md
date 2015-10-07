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
 
 ## Example usage
 
 ```
 > dat <- proclogs()
Joining by: "min"
> summary(dat)
      min           mbytespsec            avresp           Failures         Success      
 Min.   :  0.00   Min.   : 0.000082   Min.   : 172384   Min.   : 0.000   Min.   :   1.0  
 1st Qu.: 91.75   1st Qu.:12.679660   1st Qu.: 305929   1st Qu.: 2.000   1st Qu.: 823.5  
 Median :183.50   Median :15.082880   Median : 346183   Median : 2.000   Median : 919.0  
 Mean   :183.61   Mean   :13.381734   Mean   : 415054   Mean   : 1.959   Mean   : 864.0  
 3rd Qu.:275.25   3rd Qu.:16.995893   3rd Qu.: 455985   3rd Qu.: 2.000   3rd Qu.:1012.0  
 Max.   :368.00   Max.   :27.009407   Max.   :2083250   Max.   :17.000   Max.   :2159.0  
      time                    
 Min.   :2015-03-30 05:04:17  
 1st Qu.:2015-03-30 06:36:02  
 Median :2015-03-30 08:07:47  
 Mean   :2015-03-30 08:07:53  
 3rd Qu.:2015-03-30 09:39:32  
 Max.   :2015-03-30 11:12:17  
 ```
 
 
 ```
 plot(dat$time, dat$avresp)
 ```
