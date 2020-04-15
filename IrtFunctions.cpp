

#include<Rcpp.h>
#include<cmath>

using namespace Rcpp;


// IRF Function
//[[Rcpp::export]]
double rcpp_IRF(double a, double b, double c, double theta){
  double plogis = 1.0/(1.0 + exp(-1.7 * a * (theta-b)));
  return c + (1.0 -c) * plogis;
}

// [[Rcpp::export]]
double rcpp_loglkhd(NumericVector exam_a, NumericVector exam_b, NumericVector exam_c, NumericVector y, double tt){
  double loglk = 0.0;
  double probs;
  int n = y.size();
  for(int i = 0; i < n; i++){
    probs = rcpp_IRF(exam_a[i], exam_b[i], exam_c[i], tt);
    loglk += log(probs) * y[i] + log(1.0 - probs) * (1.0 - y[i]);
  }
  return loglk;
}


// [[Rcpp::export]]
NumericVector rcpp_info_items(NumericVector pars_mat_a, NumericVector pars_mat_b, NumericVector pars_mat_c, double tt){
  int rows = pars_mat_a.size();
  NumericVector info(rows);
  double IRFcall;
  for(int i = 0; i < rows; i++){
    IRFcall = rcpp_IRF(pars_mat_a[i], pars_mat_b[i], pars_mat_c[i], tt);
    info[i] = pow((2.89*pars_mat_a[i]),2)* ((1.0/IRFcall) - 1.0)*pow((IRFcall-pars_mat_c[i]),2)/pow((1.0-pars_mat_c[i]),2); // possible to reduce the number of calls to pow here, but might not be worth it
  }
  
  return info;
}

