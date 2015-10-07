# Load this file into R or RStudio and run the following function for basic unit tests
# used setwd() to set your working dir to where the code is
# Tests use v small contrived logfile test.log
# runtests()


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


runtests <- function(){
testsuite.httpLogStats <- defineTestSuite("httpLogStats",
                                          dirs = "/Users/Sean/ss/R/httpLogStats",
                                          testFileRegexp = "^Unit.+\\.R",
                                          testFuncRegexp = "^test.+",
                                          rngKind = "Marsaglia-Multicarry",
                                          rngNormalKind = "Kinderman-Ramage")

testResult <- runTestSuite(testsuite.httpLogStats)
printTextProtocol(testResult)
}

