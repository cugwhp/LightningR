GetMeteor <- function(lightning, meteor)
{
  mt <- as.POSIXlt(meteor$datetime)
  
  # Search time
  for (lpt in lightning)
  {
    lt <- as.POSIxlt(lpt$datetime)    
    
    dt <- as.numeric(mt-lt, units="hours")
    idx <- which(abs(dt<3.000001))
    
    # search poistion
    pt <- cbind(lpt$lon, lpt$lat)
    
    for (met in meteor[idx])
    {
      # calculate distance...
    }
    
  
    
    
  }
  
}