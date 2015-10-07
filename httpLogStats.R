# Develop a process (using an existing 3rd party tool or your own implementation) that can 
# consume web access log files and emit the following metrics: 
#     No. of successful requests per minute 
#     No. of error requests per minute  
#     Mean response time per minute  
#     MBs sent per minute  

# Apache logs in this format
# "%a %l %u %t \"%r\" %>s %b %D” 
# %a        IP Address
# %l        remote log name
# %u        remote username
# %t        Time the request was received, in the format [18/Sep/2011:19:18:28 -0400]
# %r        first line of request
# %>s       final status
# %b        size of response in bytes
# %D        time taken to serve request in microseconds

proclogs <- function(filename="access.log", wdir="/Users/Sean/ss/R"){
  
# Load this file into R or RStudio and source it - the you can run the function "proclogs"
# Arguments are:
#                 filename - file to process (default access.log)
#                 wdir - working directort (Default to /Users/Sean/ss/R) - you will need to change this!
# Output will be summarised data of the form
#  min mbytespsec   avresp Failures Success                time
#  1    0   11.70955 337287.8        2     700 2015-03-30 05:04:17
#  2    1   13.37738 348153.7        2     834 2015-03-30 05:05:17
#  3    2   14.67892 280089.1        2     908 2015-03-30 05:06:17
#  4    3   13.89663 285306.3        2     767 2015-03-30 05:07:17
# Where minute is minutes since the start of the sample
# mbytespsec is the Megabytes transferred per minute
# avresp is the Mean Response time for requests by minute
# Failures is the number of failed requests requests in that minute
# Success is the number of successful requests in that minute


# Load packages
require(dplyr)

# Lets read in the logs and tidy them up
# read.csv with a space for seperator should work fine
# also add some decent column names
# Use na.strings to mape - in size to NA

setwd(wdir)
logs = read.table(filename, sep=" ", header=F, stringsAsFactors=FALSE, na.strings = "-", 
            col.names = c("IP", "RLN", "RU", "DATETIME", "GMTOFFSET", "REQ", "STATUS", "SIZE", "SVTIME"),
            colClasses = c("character", "character", "character", "character", "character",
                           "character", "character", "numeric", "numeric"))

# Now lets get the time into R POSIX time format

logs$dt <- strptime(logs$DATETIME, format('[%d/%b/%Y:%H:%M:%S'))

# Calculate earliest time
starttime <- min(logs$dt)

# Grab date
logs$date <- format(logs$dt, "15/03/30" )

# Grab minutes since start of interval for buckets
logs$min <- round(as.numeric(difftime(logs$dt, starttime , unit="mins")))

# Now lets start bulding the aggregations using a dplyr pipeline
# for HTTP codes, Success: 200(OK), 304(Not Modified), Failure 500(Internal error)

summary <- logs %>%
  select(date, min, SIZE, STATUS, SVTIME) %>%
  group_by(min) %>%
  summarise( mbytespsec=sum(SIZE/(1024*1024), na.rm=TRUE), avresp=mean(SVTIME, na.rm=TRUE),
            Failures=sum(STATUS=="500"), Success=sum(STATUS %in% c("200", "304"))) %>%
  mutate(time = starttime + 60 * min)

# Add dates back in - build lookup table
datedf <-logs %>%
  select (date, min)
datedf <- datedf[!duplicated(datedf$min),]

# Now join summary data back to the lookup table to get the dates back

summary <- left_join(summary, datedf)

summary <- subset(summary, select=-c(date)) # Just remove the date column to tidy up

summary

}