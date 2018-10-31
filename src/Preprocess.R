# Data Preprocess 
#
#
###################### 1- Load Data ##############################
txt2Rdata <- function(filepathlist){
  # 1. Load Lightning Data
#  oldWorkDir = getwd()
  workDir <- "J:/HbThunderStorm/01.Datasets/08.Flash/0.Dataset/02.Cleaning"
  setwd(workDir)
  
  for (fp in filepathlist)
  {
    print(paste(fp, " is loading..."))
    dt <- read.table(fp, header=TRUE)
    rdataFile = sub(pattern = ".txt", replacement = ".RData", fp)
    
    print(paste(rdataFile, " is saving..."))
    save(dt, file=rdataFile)
    
    rm(dt)
  }
}


###########################################################
## Load list File, translate to frame File
###########################################################
transList2Frame <- function(rdataPaths, isViewFrame=FALSE)
{
  for (rdatafile in rdataPaths)
  {
    print(paste(rdatafile, "is loading"))
    
    load(rdatafile)
    
    df <- list2Frame(dt, isViewFrame = isViewFrame)
    
    rm(dt)
    
    # split year/month/day/...
    df <- splitLightningDate(df)
    
    framefile = sub(pattern=".RData", replacement = "_frm.RData", rdatafile)
    print(paste(framefile, "is saving..."))
    save(df, file=framefile)
  }
}

########################################################
## lightning list to Frame
########################################################
list2Frame <- function(ls, isViewFrame=FALSE)
{
  df <- as.data.frame(ls)
  
  colnames(df) <- c("datetime", "lat", "lon", "current", "strike")
  
  df$datetime <- as.POSIXct(df$datetime, tz="Asia/Chongqing")
  df$lat <- as.numeric(df$lat)
  df$lon <- as.numeric(df$lon)
  df$current <- as.numeric(df$current)
  df$strike <- as.numeric(df$strike)
  
  
  # split year/month/day/...
  splitLightningDate(df)
  
  if (isViewFrame)
  {
    View(df)
  }
  
  return(df)
}


########################################
## Split Lightning Date...
########################################
splitLightningDate <- function(df)
{
  # split year/month/day/...
  xlt <- as.POSIXlt(df$datetime)
  
  df$year <- as.numeric(xlt$year)+1900 #
  df$month <- as.numeric(xlt$mon)+1  #base 0
  df$season <- as.integer(xlt$mon/3)
  df$hour <- as.numeric(xlt$hour)
  df$yday <- as.numeric(xlt$yday)+1 #base 0
  
  rm(xlt)

  return(df)  
}

# 2. Load Terrain Data

# 3. Load Land Cover

# 4. Load AOD

# 5. Load TRMM_Precipitation

########################### 2- Join Data ###########################


########################## 3- Save Data ############################

# 1 Prepare Data
## 1.1 Lightning Density - ok 
## 1.2 Terrain Class - ok
## 1.3 Land Cover - ok
## 1.4 AOD - ...
## 1.5 Percipitation - ...
## 1.6 
##
# 2 Statistics of Spatio-temporal Distribution 
## 2.1 Spatio Distribution
## 2.2 Temporal Distribution
##
# 3 Geodetector
## 3.1 Geo-Joint
## 3.2 q
## 3.3 interaction
# 4 Modelling
## 4.1 Training sets
## 4.2 Modelling...
## 4.3 Precision...
##
# 5 Results
##
##