FactorPreprocess <- function(infilelist, clipshp, clssep=400)
{
  library(sp)
  library(raster)
  library(rgeos)
  
  clscount = 3000/clssep + 1
  minval = 0:clscount * clssep
  maxval = minval + clssep
  
  m <- c(minval[1], maxval[1], 1)
  for (i in c(2:(clscount+1)))
  {
    m <- c(m, minval[i], maxval[i], i)
  }
  
  for (filepath in infilelist)
  {
    inras <- raster(filepath)
    
    cropras <- crop(inras, clipshp)
    
    croprascls <- reclassify(cropras, m);
    
    cropclsshp <- rasterToPolygons(croprascls)
    
    clsshp <- intersect(cropclsshp, clipshp)
    clsshp2 <- aggregate(clsshp, by='layer')
    
    shppath = sub(pattern = ".tif", replacement = ".shp", filepath)
    
    shapefile(clsshp2, shppath, overwrite = TRUE)
  }
}

TestFactorPreprocess <- function()
{
  perpath <- "J:\\HbThunderStorm\\01.Datasets\\03.Meteorology\\Percipitation2015\\original\\per_2015.tif"
  clpshp <- "J:\\HbThunderStorm\\01.Datasets\\08.Flash\\0.Dataset\\02.Cleaning\\hbshp_wgs84.shp"
  
  clpshp <- shapefile(clpshp)
  
  FactorPreprocess(perpath, clpshp)
}