###### Using the lmer command with new added variable

library(readstata13)
library(Matrix)
library(lme4)
library(xtable)
library(splines)

alldata <- read.dta13("final_long2.dta")

x <- 0:72
spl <- bs(x,knots=c(37,53))

alldata$Time <- predict(spl,alldata$time)


## Logaritmisk model
lmer6 <- lmer(log(total_DDD)~Time+factor(kqn2)+factor(diag_how)+I(diag_age-80)+time_sin_diag+prev_druguse+(1|pnr),data=alldata)
summary(lmer6)
object6 <- coef(summary(lmer6))
object6
print(xtable(object6),file="lmer6_2.txt")


## Residualplot for model 3
layout(matrix(1:2, ncol=2))
ranint2 <- ranef(lmer6)$pnr[["(Intercept)"]]
res2 <- residuals(lmer6)

qqnorm(ranint2, main="Random Inetercepts")
qqline(ranint2)
qqnorm(res2, main="Residuals")
qqline(res2)

# Histogram
layout(matrix(1:2, ncol=2))
hist(ranint2,breaks=100,main="Random Intercepts")
hist(res2,breaks=100,main="Residuals")


## Plotte procentvis ændring over tid, når vi har justeret for alder osv.
coef=coef(summary(lmer6))[2:6,1]
spline=exp(spl%*%coef)
plot(spline,type="l",col="magenta",lwd=2,xlab="Time",ylab="DDD - Index 100")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
