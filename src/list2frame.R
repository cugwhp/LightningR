# list to data frame

# Set Work Directory
oldDir <- getwd()
workDir <- "J:/HbThunderStorm/01.Datasets/08.Flash/0.Dataset/02.Cleaning"
setwd(workDir)

#
load("2014.RData")
df <- as.data.frame(d14)

# rm(d14)

colnames(df) <- c("datetime", "lat", "lon", "current", "strike")

df$datetime <- as.POSIXct(df$datetime, tz="Asia/Chongqing")
df$lat <- as.numeric(df$lat)
df$lon <- as.numeric(df$lon)
df$current <- as.numeric(df$current)
df$strike <- as.numeric(df$strike)

xlt <- as.POSIXlt(df$datetime)
df$year <- as.numeric(xlt$year)+1900
df$month <- as.numeric(xlt$mon)
df$season <- df$month/3
df$hour <- as.numeric(xlt$hour)
df$yday <- as.numeric(xlt$yday)

# rm(xlt)


View(df)

# 
setwd(oldDir)
