# install.packages('openxlsx')

rm(list=ls())

library(openxlsx)


help(read.xlsx)

#This is an example... change the http: to match the one you've uploaded
icpData = read.xlsx('https://github.com/ValenteJJ/OccupancyClosureMS/blob/main/SimulationParameters.xlsx?raw=true', sheet='Interval0')
JustinData = read.xlsx('https://github.com/ValenteJJ/CodingExercises/blob/main/ICP%201.0%20JHall%20Mam%20Data.xlsx?raw=true', sheet='Sherman Trap Encounters', detectDates=T)

str(icpData)


test = icpData |> 
  full_join(JustinData, by=c("PointID", "WMA", "Date", "Time", "Trap", "Species", "Sex", "Wgt", "HindFt", "TailLgth", "BodyLgth", "TotalLgth"))

class(icpData$TotalLgth)
class(JustinData$TotalLgth)


# colnames(icpData)
# colnames(JustinData)

test = icpData

library(dplyr)
library(readxl)

#Some icp Datesare like this: "%m /%d/%Y" and some like this: "%m/%d/%Y"

 icpData$Date <- as.Date(icpData$Date, format ="%m /%d/%Y")
str(icpData)

#Correcting typo dates
JustinData$Date[630] <- "2008-10-7"
JustinData$Date[686] <- "2008-10-8"
JustinData$Date[799] <- "2008-11-8"
JustinData$Date[800] <- "2008-11-8"
View(JustinData)

#Convert to Date
 JustinData$Date <- as.Date(JustinData$Date, format ="%Y-%m-%d")
str(icpData)

#Covert Time to numeric

JustinData$Time <- as.numeric(JustinData$Time)

#Fixing NA Value which was 11:45 AM
JustinData$Time[1] <- 0.48958333

convertDecimalToTime <- function(Time) {
  
  hours <- floor(JustinData$Time* 24)
  minutes <- floor((Time * 24 - hours)*60)
  am_pm <- ifelse(hours < 12, "AM", "PM")
  hours <- ifelse(hours > 12, hours - 12, ifelse(hours==0, 12, hours))
  hours[hours ==0] <- 12
  times <- sprintf("%02d:%02d:00 %s", hours, minutes, am_pm)
  return(times)
}

JustinData$Time <- convertDecimalToTime(JustinData$Time)

#Convert pointIDs to numeric
JustinData$PointID <- as.numeric(JustinData$PointID)
icpData$PointID <- as.numeric(icpData$PointID)
str(JustinData)

#remove comments so that column names are equal in both data frames
JustinData <- JustinData[, -13]
View(JustinData)

install.packages("dplyr")
library(dplyr)

#remove time to see how interect changes
icpData <- icpData[, -4]
JustinData <- JustinData[, -4]

#remove date to see how intersect changes
icpData <- icpData[, -3]
JustinData <- JustinData[, -3]

common_rows <- intersect(icpData, JustinData)
View(common_rows)

dif_rows <- setdiff(icpData, JustinData)
View(dif_rows)
