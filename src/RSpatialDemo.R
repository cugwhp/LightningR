#
# RSpatial code
#

library(sp)

wd <- "J:/HbThunderStorm/01.Datasets/08.Flash/0.Dataset/02.Cleaning"
setwd(wd)

##1. Open shapefile
shpfile <- paste0(wd, "/HbRange/HbProvince.shp")
hbshp <- shapefile(shpfile)
plot(hbshp, col='light blue')


##2. data.Frame --> Spatial Points
lonlat <- cbind(df$lon, df$lat)
pts <- SpatialPoints(coords=lonlat[1:2000,], proj4string=CRS("+proj=longlat +datum=WGS84"))

# save shapfile
#soutfile <- "lightningpts.shp"
#shapefile(pts, soutfile, overwrite=T)

##3. Create Grid cell and Calc density
grd <- raster(hbshp)
res(grd) <- 0.05  #0.05degree about 5km
grd <- rasterize(hbshp, grd)  #rasterize hbshp by 0.05 degree
plot(grd)

quads <- as(grd, 'SpatialPolygons') #Grid -->Polygon(渔网)
plot(quads, add=TRUE) #叠加显示
points(pts, col='red', cex=.5)

#density calculation
nc <- rasterize(coordinates(pts), grd, fun='count', background=0)
nclight <- mask(nc, hbshp)  #mask by hb shapefile
plot(nclight)
plot(hbshp, add=TRUE)





