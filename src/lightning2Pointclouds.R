lightning2Pointclouds<-function(df, nmonth)
{
  # Input RData
  utmproj = CRS("+proj=utm +zone=49 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0")
  geoproj = CRS("+proj=longlat +datum=WGS84")
 
  idx <- which(df$month==nmonth)
  df2 <- df[idx,]
  
  # lonlat --> points
  pts <- SpatialPoints(cbind(df2$lon, df2$lat), proj4string = geoproj)
  
  # lonlat --> utm
  ptsutm <- spTransform(pts, utmproj)
  
  # add time
  xlt <- as.POSIXlt(df2$datetime)
  
  mday <- as.numeric(xlt$mday)
  hour <- as.numeric(xlt$hour)
  min <- as.numeric(xlt$min)
  sec <- as.numeric(xlt$sec)
  
  crd = coordinates(ptsutm)
  crd <- cbind(crd, (mday*86400+hour*3600+min*60+sec))
  names(crd) <- c("X", "Y", "tsec")
  
  rm(df2, xlt, mday, hour, min, sec, pts, ptsutm)
  
  return(crd)
}