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


# Lets read in the logs and tidy them up
# read.csv with a space for seperator should work fine
# also add some decent column names

setwd("/Users/Sean/ss/R")
logs = read.table("access.log", sep=" ", header=F, stringsAsFactors=FALSE, col.names = c("IP", "RLN", "RU", "DATETIME", "GMTOFFSET", "REQ", "STATUS", "SIZE", "SVTIME" ))

# Now lets get the time into R POSIX time format

logs$dt <- strptime(logs$DATETIME, format('[%d/%b/%Y:%H:%M:%S'))

# Calculate earliest time
starttime <- min(logs$dt)

# Grab date
logs$date <- format(logs$dt, "15/03/30" )

# Grab minutes since start of interval for buckets
logs$min <- round(as.numeric(difftime(logs$dt, starttime , unit="mins")))
