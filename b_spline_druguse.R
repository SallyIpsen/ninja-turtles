### Making b-splines, test for forskel på tidligere brug af antipsykotika

library(splines)
library(xtable)

x <- 1:72

spl <- bs(x,knots=c(37,53))
Spl <- rbind(spl,spl)

alldata_MED = read.table("means_DDD_MED_comma.csv",header=TRUE,sep=",")
mean_DDD_MED=alldata_MED$mean_DDD
w_MED = alldata_MED$patient_no
alldata_UDEN = read.table("means_DDD_UDEN_comma.csv",header=TRUE,sep=",")
mean_DDD_UDEN=alldata_UDEN$mean_DDD
w_UDEN = alldata_UDEN$patient_no

mean_DDD_all <- c(mean_DDD_MED,mean_DDD_UDEN)
w_all <- c(w_MED,w_UDEN)
S <- factor(c(rep("M",72),rep("U",72)))  #tidligeredruguse-faktor
fit <- lm(mean_DDD_all~S*Spl,weight=w_all)

object21 <- summary(fit)
print(xtable(object21),file="fit_druguse.txt")

object22 <- drop1(fit,test="F")  #signifikant vekselvirkning??
print(xtable(object22),file="drop1_druguse.txt")

pr <- predict(fit)

plot(x,mean_DDD_MED,ylim=c(0,75),ylab="DDD",xlab="Time")
lines(x,pr[1:72])
points(x,mean_DDD_UDEN,col="red")
lines(x,pr[73:144],col="red")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
