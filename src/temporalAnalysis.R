#
# temporal Distribution with Lightning
#
# temporalType: 1 - monthly
#               2 - seasonly
#               3 - hourly
#
temporalAnalysis <- function(df, temporalType = 1)
{
  hist(df$month, main="Monthly Lightning Activity")
  
  hist(df$season, main="Seasonly Lightning Activity")
  
  hist(df$hour, main = "hourly Lightning Activity")
  
  
}