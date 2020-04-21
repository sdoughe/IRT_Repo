this.dir = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(this.dir)
## Did I update my email address
### Optimize CAT Example Code
#Source to IrtFunctions file, which needs to be in the working directory
source("IrtFunctions.R")
#Set N examinees, J items, and bank size (number of items) M
N <- 100
J <- 50
M <- 500
#Generate true examinee latent traits
THETA <- rnorm(N)
#Generate vectors of item parameters and bind together
B <- cbind(runif(M, 0.3, 1.2),runif(M, -2, 2),runif(M, 0, 0.25))
#Generate sequence of thetas for grid search
seq.theta <- matrix(seq(from = -3.5, to = 3.5,by = 0.01), ncol = 1)
#Set empty vector for storing final theta estimates
t.final <- rep(NA,N)
#Begin exam simulation
for (i in 1:N){
  #Reset bank,exam,response vector for each examinee
  B.i <- B
  y.i <- 1:J
  exam.i <- matrix(0, J, ncol(B)) 
  #Assign random theta hat to begin item selection 
  t.ij <- rnorm(1)
  #Administer items 
  for (j in 1:J){
    #select next item by maximizing Fisher information at theta hat
    max_index <- which.max(info.items(B.i, t.ij))
    #add selected item to the exam
    exam.i[j, ] <- B.i[max_index, ]
    #simulate response for current item
    y.i[j] <- rbinom(1, 1, IRF(exam.i[j, 1], exam.i[j, 2], exam.i[j, 3], THETA[i]))
    #For Grid Search, run the next two lines and comment out the optimize call four lines below
    #loglkhd.vec <- apply(seq.theta, 1, loglkhd,exam = exam.i[1:j,],y = y.i[1:j])
    #t.ij <- seq.theta[which.max(loglkhd.vec), ]
    ##For Optimize, run line below and comment out two previous lines
    t.ij <- optimize(loglkhd,c(-3.5, 3.5), exam=exam.i[1:j, ], y=y.i[1:j], maximum = TRUE, tol = 1e-12)$maximum
    #Remove selected item from bank
    B.i <- B.i[-max_index, ]
  }
  #store final theta estimate for examinee i
  t.final[i] <- t.ij
}

#compute bias and MSE, respectively
mean(THETA - t.final)
mean((THETA - t.final)^2)

