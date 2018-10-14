# Learning R

testR <- function()
{
  print("R Test case ....")
  
  x = c(1:10)
  nx = normalize(x)

  print(nx)  
}

normalize <- function(x, m=mean(x), s=sd(x))
{
  (x-m)/s
}

f <- function(x)
{
  y <- 1
 
  g <- function(x)
  {
    (x+y)/2
  }
 
  g(x)
}