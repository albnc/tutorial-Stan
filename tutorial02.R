## Tutorial based on this video:
## https://youtu.be/0FdMZwIbJ_4

## CONVERGENCE
tosses = rbinom(n=10, size=1, prob=0.5)
mean(tosses)

## Mean = Expectancy
tosses <-  rbinom(n=5000, size=1, prob=0.5)
means <- sapply(1:5000, function(x) mean(tosses[1:x]))
plot(means, ty='l', ylim=c(0,1), xlab='toss', ylab='mean of tosses')
abline(h=0.5, lty='dashed')

## Poisson distribution
sample_pois <- sapply(1:10000, function(x) rpois(1000, 0.6))
sample_exp <- sapply(1:10000, function(x) rexp(1000, 0.6))
mean_pois <- colMeans(sample_pois)
mean_exp <- colMeans(sample_exp)
plot(density(mean_pois))
plot(density(mean_exp))


## 8 SCHOOL example
school_dat <- list(J=8, y=c(28,8,-3,7,-1,1,18,12))
sigma <- c(15,10,16,11,9,11,10,18)

require(rstan)
fit <- stan("tutorial02-model.stan", data=school_dat, chains=4, iter=20)
params <- extract(fit, permuted=FALSE, inc_warmup=TRUE)