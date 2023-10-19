# install.packages('openxlsx')

rm(list=ls())

library(openxlsx)


help(read.xlsx)

#This is an example... change the http: to match the one you've uploaded
icpData = read.xlsx('https://github.com/ValenteJJ/OccupancyClosureMS/blob/main/SimulationParameters.xlsx?raw=true', sheet='Interval0')

# Test to make sure this works