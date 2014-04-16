
create_gap <- function(dat, start, length, beginning=TRUE){
  if(start=="random"){
    start = sample(1:(length(dat$Time) - length+1), size=1)
    sub <- order(dat$Time)[start:(start+length-1)]
  }else{
    if(!beginning){
      sub <- order(dat$Time, decreasing=TRUE)[start:(start+length-1)]
    }else{
      sub <- order(dat$Time)[start:(start+length-1)]
    } 
  }
  
  return(dat[-sub,])
}



