# This tutorial is from the following link:
# https://www.youtube.com/watch?v=ev2xpOKxbDQ&list=PLu77iLvsj_GPoC6tTw01EP1Tcr2I6zEm8

library(rstan)
# stan model code
model <- '
data{
  int nY;
  vector[nY] Y;
} 
parameters {
  real mu;
}
model {
  mu ~ normal(100,20); // prior
  Y ~ normal(mu,15);   // likelihood
}
'

# random seed
set.seed(1)
# fake data
Y = rnorm(30,110,10)
# package data for stan
data = list(
  nY = length(Y),
  Y = Y
)

fit = stan(model_code = model, 
           data = data,
           iter = 1e5,
           chains = 4)

print(fit)
