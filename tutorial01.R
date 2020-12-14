data("iris")
head(iris)

versicolor <- which(iris$Species == "versicolor")
x <- iris$Sepal.Length[versicolor]
y <- iris$Sepal.Width[versicolor]

plot(x,y, xlab = "Sepal Length", ylab = "Sepal Width")

data = list(N=length(x), x=x, y=y)

require(rstan)
fit <- stan(file='stan-tutorial/tut01-model.stan', data=data)

summary(fit)
params <- extract(fit)
alpha <- mean(params$alpha)
beta <- mean(params$beta)
abline(a=alpha, b=beta)

xr <- seq(4, 7.5, 0.1)
yCI <- sapply(xr, function(k) quantile(params$beta * k + params$alpha, probs = c(0.05, 0.95)))
lines(xr, yCI[1,], col='red')
lines(xr, yCI[2,], col='red')

## Simulated data
#fit <- stan(file='stan-tutorial/tut01-model.stan', data=data)
plot(density(y), xlim=c(1,4.5), ylim=c(0,1.8))
params <- extract(fit)
for(i in 1:10) {lines(density(params$y_sim[i,]), col='red')}


y_new <- params$y_sim[20,]
data_new = list(N=length(x), x=x, y=y_new)
fit_new <- stan(file='stan-tutorial/tut01-model.stan', data=data_new)
params_new <- extract(fit_new)
plot(density(params$alpha))
lines(density(params_new$alpha), col='red')

plot(density(params$beta))
lines(density(params_new$beta), col='red')
