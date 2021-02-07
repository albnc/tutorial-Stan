# This tutorial is from the following link and paper:
# http://www.stat.columbia.edu/~gelman/research/published/stan_jebs_2.pdf
# Andrew Gelman, Daniel Lee, and Jiqiang Guo (2015) Stan: A probabilistic programming language for Bayesian inference and optimization. In press, Journal of Educational and Behavior Science.

 # stan code
code = '
data {
  int N;
  vector[N] x;
  vector[N] y;
}
parameters {
  vector[2] log_a;
  vector[2] log_b;
  real<lower=0> sigma;
}
transformed parameters{
  vector<lower=0>[2] a;
  vector<lower=0>[2] b;
  a = exp(log_a);
  b = exp(log_b);
}
model {
  vector[N] ypred;
  
  log_a ~ normal(0,1);
  log_b ~ normal(0,1);
  ypred = a[1]*exp(-b[1]*x) + a[2]*exp(-b[2]*x);
  y ~ lognormal(log(ypred), sigma);
}
'
# Set up the true parameter values
a <- c(.8, 1)
b <- c(.2, .1)
sigma <- .2

# Simulate data
x <- (1:1000)/100
N <- length(x)
ypred <- a[1]*exp(-b[1]*x) + a[2]*exp(-b[2]*x)
y <- ypred*exp(rnorm(N, 0, sigma))

# Fit the model
library("rstan")
fit <- stan(model_code = code, 
            data=list(N=N, x=x, y=y), 
            iter=1000, chains=4)
print(fit, pars=c("a", "b", "sigma"))
