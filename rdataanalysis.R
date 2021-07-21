library(dplyr)

temp = list.files(pattern="/home/mremington/Documents/krattle_analysis/krattle_analysis/Data/*.csv")
myfiles = lapply(temp, read.delim)
