
create_gap <- function(dat, start, length, beginning=TRUE){
  if(!beginning){
    sub <- order(dat$Time, decreasing=TRUE)[start:(start+length-1)]
  }else{
    sub <- order(dat$Time)[start:(start+length-1)]
  }
  return(dat[-sub,])
}



