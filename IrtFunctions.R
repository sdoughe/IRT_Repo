#IRF() function arguments are 3PL item parameters and theta. 
#Returns IRF probability at theta
IRF <- function( .a , .b , .c , .theta){
  return( .c + (1 - .c) * plogis(1.7 * .a * (.theta - .b)))
}

#loglkhd() function arguments are theta value, exam and item responses. 

#Returns value of log likehood at given theta value

loglkhd <- function( tt, exam, y){
  
  if (is.matrix(exam)){
    probs <- IRF(exam[, 1], exam[, 2], exam[, 3], tt)
  }
  
  else{
    probs <- IRF(exam[1], exam[2], exam[3], tt)
  }
  
  loglk <- sum(log(probs) * (y) + log(1 - probs) * (1 - y))	
  
}		

#item.info() function arguments are items and theta 
#Returns Fisher information for items at theta value

info.items<-function(pars.mat,tt){
  
  IRFcall <- IRF(pars.mat[,1], pars.mat[,2], pars.mat[,3], tt)
  
  info <- (2.89 * pars.mat[,1] ^ 2 * (1 - IRFcall) / IRFcall) * (((IRFcall) - pars.mat[,3]) ^ 2 / (1 - pars.mat[,3]) ^ 2)
  
}





