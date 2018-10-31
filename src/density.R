library(sp)
library(raster)

#
# calculate density of lightning activity
# df - data frame of lightning (load...)
# shp - shape file of region
# month - month val, 0 is a year, 1-12 is the month
# cellsize - grid cell for calculate density
#
densityLightning <-function(df, shp, month=0, cellsize=0.05)
{
  #1.data.frame --> spatial Points
  lonlat <- cbind(df$lon, df$lat)
  
  if (month>=1 & month<=12)
  {
    id <- which(df$month == month)
    ptsAll <- SpatialPoints(coords = lonlat[id,], proj4string = CRS("+proj=longlat +datum=WGS84"))
  }
  else
  {
    ptsAll <- SpatialPoints(coords = lonlat[], proj4string = CRS("+proj=longlat +datum=WGS84"))
  }
  
  # shp extent ---> raster
  grd <- raster(shp, nrow=1, ncol=1, vals=1)
  names(grd) <- "extent"
  
  # points of shape extent
  pts <- intersect(ptsAll, grd)
  
  #2.Create roi polygon == shapefile polygons
  roi <- raster(shp)
  res(roi) <- cellsizer
  roi <- rasterize(shp, roi)
  
  # plot code for vis
  quads <- as(roi, 'SpatialPolygons')
  plot(roi)
  plot(quads, add=TRUE)
  
  #3.density
  nc <- rasterize(coordinates(pts), roi, fun='count', background=0)
  nc2 <- mask(nc, roi)
  return(nc2)
}


testDensity <- function()
{
  setwd("J:/HbThunderStorm/01.Datasets/08.Flash/0.Dataset/02.Cleaning")
  
  shpfile <- "hbshp_wgs84.shp"
  fpathlists <- c("2013_frm.RData", "2014_frm.RData", "2015_frm.RData")
  months <- c(1:12)
  cellsize <- 0.05  #degree...
  
  hbshp<-shapefile(shpfile)
  
  for (fp in fpathlists)
  {
    # load data frame
    load(fp)
    
    for (m in months)
    {
      nc <- densityLightning(df, hbshp, month=m, cellsize=cellsize)
      
      densityfile = sub(pattern = "frm.RData", replacement = "", fp)
      
      densityfile = paste(densityfile, as.character(m), sep="")
      densityfile = paste(densityfile, "_density.tif", sep="")
      
      writeRaster(nc, densityfile, overWrite=TRUE)
    }
  }
}