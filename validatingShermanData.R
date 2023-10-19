# install.packages('openxlsx')

rm(list=ls())

library(openxlsx)


help(read.xlsx)

icpData = read.xlsx("C:/...file.xlsx", sheet="")