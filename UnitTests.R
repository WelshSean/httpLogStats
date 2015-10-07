library(RUnit)
source("httpLogStats.R")

test.success <- function(){
  totalS <- sum(proclogs(filename="test.log", wdir="/Users/Sean/ss/R/httpLogStats")["Success"])
  checkEquals(totalS, 6)
}

test.failures <- function(){
  totalF <- sum(proclogs(filename="test.log", wdir="/Users/Sean/ss/R/httpLogStats")["Failures"])
  checkEquals(totalF, 1)  
}

test.averageresponse <- function(){
  avmin0 <- as.numeric(proclogs(filename="test.log", wdir="/Users/Sean/ss/R/httpLogStats")[1,]["avresp"])
  checkEquals(avmin0, 1e+05)
}

test.mbpersec <- function (){
  mbsecmin180 <- as.numeric(proclogs(filename="test.log", wdir="/Users/Sean/ss/R/httpLogStats")[2,]["mbytespsec"])
  checkEquals(mbsecmin180, 8)
  }

