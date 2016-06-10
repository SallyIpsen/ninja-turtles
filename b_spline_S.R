### Making b-splines 

library(splines)
library(xtable)

x <- 1:72

spl <- bs(x,knots=c(37,53))
spl0 <- bs(x)

alldata = read.table("means_DDD_comma.csv",header=TRUE,sep=",")
mean_DDD=alldata$mean_DDD
w = alldata$patient_no

fit_overall <- lm(mean_DDD~spl,weight=w)
fit0_overall <- lm(mean_DDD~spl0,weight=w)

object00 <- summary(fit0_overall)
object01 <- summary(fit_overall)

print(xtable(object00),file="fit0_overall.txt")
print(xtable(object01),file="fit_overall.txt")

object00
object01

pr_overall <- predict(fit_overall)
pr0_overall <- predict(fit0_overall)

plot(x,mean_DDD,ylim=c(0,40),xlab="Time",ylab="DDD")
lines(x,pr_overall,col="blue")
lines(x,pr0_overall,col="red")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

object02 <- anova(fit0_overall,fit_overall)
print(xtable(object02),file="anova_overall.txt")
object02


#test for kønsforskel 

Spl <- rbind(spl,spl)
alldata_female = read.table("means_DDD_female_comma.csv",header=TRUE,sep=",")
mean_DDD_female=alldata_female$mean_DDD
w_female = alldata_female$patient_no
alldata_male = read.table("means_DDD_male_comma.csv",header=TRUE,sep=",")
mean_DDD_male=alldata_male$mean_DDD
w_male = alldata_male$patient_no

mean_DDD_all <- c(mean_DDD_female,mean_DDD_male)
w_all <- c(w_female,w_male)
S <- factor(c(rep("F",72),rep("M",72)))  #kønsfaktor
fit <- lm(mean_DDD_all~S*Spl,weight=w_all)

object1 <- summary(fit)
#object1
print(xtable(object1),file="fit_gender.txt")

object2 <- drop1(fit,test="F")  #signifikant vekselvirkning?? NEJ!
print(xtable(object2),file="drop1_gender.txt")

fit1 <- lm(mean_DDD_all~S+Spl,weight=w_all)
object3 <- summary(fit1)
print(xtable(object3),file="fit1_gender.txt")

pr <- predict(fit1)

plot(x,mean_DDD_male,ylim=c(0,40),xlab="Time",ylab="DDD")
lines(x,pr[73:144])
points(x,mean_DDD_female,col="red")
lines(x,pr[1:72],col="red")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

# Sammenligne model med og uden knuder
spl0 <- bs(x)
Spl0 <- rbind(spl0,spl0)
fit0 <- lm(mean_DDD_all~S+Spl0,weight=w_all)
object4 <- summary(fit0)  #parallelle splines med signifikant afstand
print(xtable(object4),file="fit0_gender.txt")

object5 <- anova(fit0,fit1)
print(xtable(object5),file="anova_gender.txt")
object5
