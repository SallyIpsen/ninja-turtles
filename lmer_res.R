###### Using the lmer command on restricted population

library(readstata13)
library(Matrix)
library(lme4)
library(xtable)
library(splines)

alldata <- read.dta13("final_long_NY.dta")

x <- 0:72
spl <- bs(x,knots=c(37,53))

alldata$Time <- predict(spl,alldata$time)

## Logaritmisk model
lmer6 <- lmer(log(total_DDD)~Time+factor(kqn2)+diag_after+factor(diag_how)+I(diag_age-80)+time_sin_diag+(1|pnr),data=alldata)
summary(lmer6)
object6 <- coef(summary(lmer6))
object6
print(xtable(object6),file="lmer6_res.txt")

lmer7 <- lmer(log(total_DDD)~Time+factor(kqn2)+factor(diag_how)+I(diag_age-80)+(1|pnr),data=alldata)
summary(lmer7)
object7 <- coef(summary(lmer7))
object7
print(xtable(object7),file="lmer7_res.txt")

## Residualplot
layout(matrix(1:2, ncol=2))
ranint2 <- ranef(lmer7)$pnr[["(Intercept)"]]
res2 <- residuals(lmer7)

qqnorm(ranint2, main="Random Intercepts")
qqline(ranint2)
qqnorm(res2, main="Residuals")
qqline(res2)


layout(matrix(1:2, ncol=2))
hist(ranint2,breaks=100,main="Random Intercepts")
hist(res2,breaks=100,main="Residuals")


## Plotte procentvis �ndring over tid, n�r vi har justeret for alder osv.
coef=coef(summary(lmer7))[2:6,1]
spline=exp(spl%*%coef)
plot(spline,type="l",col="magenta",lwd=2,xlab="Time",ylab="DDD - Index 100")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
