# IRT_Repo
IRT Functions and Code files for Rcpp, Serial, and Parallel Cases in R for running Computer Adaptive Testing (CAT) simulations.
The Exam styles being simulated are fixed length, binary response exams. (Answers are either True (1) or False (0) ). 
All code produces identical results across seeds for each optimization method: optimize() and gridsearch results will be different, but Rcpp and Parallel code will be identical in results to Serial code for a given method.
To fully utilize these documents, the src, and R source files must be downloaded and placed in the working directory of code being run. 
Current Code requires the libraries: (doParallel, Rcpp, doRNG, and foreach)

