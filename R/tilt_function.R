#'@name tilt_function
#'
#'@title Tilt Function
#'
#'@description Provides the given tilt along with the two neighboring tilts
#'
#'@param tilt The axis on which the ball spins, measured like hours and minutes on a clock, rounded to the nearest 15 minutes
#'
#'
#'@return Returns a length three character vector of the inputted tilt and the two other closest tilts
#'
#'
#'@export

library(stringr)

tilt_function = function(tilt){
  if(str_detect(substr(tilt,1,2),":")==TRUE){
    ending = as.integer(substr(tilt, 3, 4))
    ret = c(paste0(substr(tilt,1,2),ending -15), tilt,  paste0(substr(tilt,1,2),ending + 15))
    if(any(str_detect(ret,"60"))){
      ret[3] = paste0(as.integer(substr(tilt,1,1))+1,":00")}
    else if(any(str_detect(ret,"-15"))){
      ret[1] = paste0(as.integer(substr(tilt,1,1))-1,":45")}
  }

  else if(str_detect(substr(tilt,1,2),":")==FALSE){
    ending = as.integer(substr(tilt, 4, 5))
    ret = c(paste0(substr(tilt,1,3),ending -15), tilt,  paste0(substr(tilt,1,3),ending + 15))
    if(any(str_detect(ret,"60"))){
      ret[3] = paste0(as.integer(substr(tilt,1,2))+1,":00")}
    else if(any(str_detect(ret,"-15"))){
      ret[1] = paste0(as.integer(substr(tilt,1,2))-1,":45")}
  }

  if(substr(ret[1],1,1)==0){
    ret[1] = "12:45"
  }

  if(substr(ret[3],1,2)==13){
    ret[3] = "1:00"
  }
  return(ret)
}





