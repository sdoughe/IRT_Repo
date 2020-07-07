# IRT_Repo

Item Response Theory Functions (IRT) and Code files for Rcpp, Serial, and Parallel Cases in R for running Computer Adaptive Testing (CAT) simulations.
The Exam styles being simulated are fixed length, binary response exams. (Answers are either True (1) or False (0)). 

Each program will return the MSE and Bias of a simulation with tests of length J administered to N students from a question bank of size M, where each item in the question bank has 3 parameters, a: discrimination, b: difficulty, and c: random guessing probability. 

A 3 Parameter Logistic (3PL) model is used to determine the probability that a student with a given latent ability: &theta;, correctly answers the question with a given a,b, and c parameters. This latent ability is then estimated using maximum log likelihood, and this estimated value:  &theta;_hat, is used to select the next question to be administered to the student. 
  
Further information on Item Response Theory can be found at:

http://edres.org/irt/baker/

To fully utilize these documents, the src, and R source files must be downloaded and placed in the working directory of code being run. 

All code produces identical results across random seeds for each optimization method: optimize() and gridsearch results will be different, but Rcpp and Parallel code will be identical in results to Serial code for a given method.

Current Code requires the libraries doParallel, Rcpp, doRNG, and foreach; available at the following links: 

https://cran.r-project.org/web/packages/doParallel/index.html

https://cran.r-project.org/web/packages/Rcpp/index.html

https://cran.r-project.org/web/packages/doRNG/index.html

https://cran.r-project.org/web/packages/foreach/index.html



