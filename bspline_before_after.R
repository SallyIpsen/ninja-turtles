### Making b-splines, test for forskel på diagnosetidspunkt før/efter guideline i 2007

library(splines)
library(xtable)

x <- 1:72
x_a <- 53:72


spl <- bs(x)
spl_a <- bs(x_a)
Spl <- rbind(spl,spl_a)

alldata_before = read.table("means_DDD_before_comma.csv",header=TRUE,sep=",")
mean_DDD_before=alldata_before$mean_DDD
w_before = alldata_before$patient_no
alldata_after = read.table("means_DDD_after_comma.csv",header=TRUE,sep=",")
mean_DDD_after=alldata_after$mean_DDD[53:72]
w_after = alldata_after$patient_no[53:72]

mean_DDD_all <- c(mean_DDD_before,mean_DDD_after)
w_all <- c(w_before,w_after)
S <- factor(c(rep("BG",72),rep("AG",20)))  #diagnosetidspunktssfaktor
fit <- lm(mean_DDD_all~S*Spl,weight=w_all)

object21 <- summary(fit)
print(xtable(object21),file="fit0_diagtime.txt")

object22 <- drop1(fit,test="F")  #signifikant vekselvirkning?? JA!
print(xtable(object22),file="drop1_diagtime.txt")
b
pr <- predict(fit)

plot(x,mean_DDD_before,ylim=c(0,75),xlab="Time",ylab="DDD")
lines(x,pr[1:72])
points(x_a,mean_DDD_after,col="red")
lines(x_a,pr[73:92],col="red")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

