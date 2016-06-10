### Making b-splines, test for forskel ang. diagnosetyper. 

library(splines)
library(xtable)

x <- 1:72
x_p <- 12:72
spl <- bs(x,knots=c(37,53))
spl0 <- bs(x)
spl_p <- bs(x_p,knots=c(37,53))
spl0_p <- bs(x_p)
Spl <- rbind(spl,spl,spl_p)
Spl2 <- rbind(spl,spl)
alldata_inpsyk = read.table("means_DDD_inpsyk_comma.csv",header=TRUE,sep=",")
mean_DDD_inpsyk=alldata_inpsyk$mean_DDD
w_inpsyk = alldata_inpsyk$patient_no
alldata_insom = read.table("means_DDD_insom_comma.csv",header=TRUE,sep=",")
mean_DDD_insom=alldata_insom$mean_DDD
w_insom = alldata_insom$patient_no
alldata_prescpt = read.table("means_DDD_prescpt_comma.csv",header=TRUE,sep=",")
mean_DDD_prescpt=alldata_prescpt$mean_DDD[12:72]
w_prescpt = alldata_prescpt$patient_no[12:72]

mean_DDD_all <- c(mean_DDD_inpsyk,mean_DDD_insom,mean_DDD_prescpt)
w_all <- c(w_inpsyk,w_insom,w_prescpt)
S <- factor(c(rep("PS",72),rep("S",72),rep("PR",61)))  #diagnosetypefaktor
S=relevel(S,"PS")
fit <- lm(mean_DDD_all~S*Spl,weight=w_all)

object11 <- summary(fit)
print(xtable(object11),file="fit_diagtype.txt")

object12 <- drop1(fit,test="F")  #signifikant vekselvirkning?? JA!
print(xtable(object12),file="drop1_diagtype.txt")

pr <- predict(fit)

plot(x,mean_DDD_inpsyk,ylim=c(0,75),xlab="Time",ylab="DDD")
lines(x,pr[1:72])
points(x,mean_DDD_insom,col="red")
lines(x,pr[73:144],col="red")
points(x_p,mean_DDD_prescpt,col="blue")
lines(x_p,pr[145:205],col="blue")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

mean_DDD_2 <- c(mean_DDD_inpsyk,mean_DDD_insom)
w2 <- c(w_inpsyk,w_insom)
S2 <- factor(c(rep("PS",72),rep("S",72)))
fit2 <- lm(mean_DDD_2~S2*Spl2,weight=w2)

object61 <- summary(fit2)
print(xtable(object61),file="fit_diagtype2.txt")

object62 <- drop1(fit2,test="F")  #signifikant vekselvirkning?? 
print(xtable(object62),file="drop1_diagtype2.txt")



#### Estimere hver for sig ####
## inpsyk
fit_inpsyk <- lm(mean_DDD_inpsyk~spl,weight=w_inpsyk)
fit0_inpsyk <- lm(mean_DDD_inpsyk~spl0,weight=w_inpsyk)

object13 <- summary(fit_inpsyk)
print(xtable(object13),file="fit_inpsyk.txt")
object13

object14 <- summary(fit0_inpsyk)
print(xtable(object14),file="fit0_inpsyk.txt")
object14

pr_inpsyk <- predict(fit_inpsyk)
pr0_inpsyk <- predict(fit0_inpsyk)

plot(x,mean_DDD_inpsyk,ylim=c(0,40),xlab="Time",ylab="DDD")
lines(x,pr_inpsyk,col="blue")
lines(x,pr0_inpsyk,col="red")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

object14a <- anova(fit0_inpsyk,fit_inpsyk)
print(xtable(object14a),file="anova_inpsyk.txt")
object14a


## insom
fit_insom <- lm(mean_DDD_insom~spl,weight=w_insom)
fit0_insom <- lm(mean_DDD_insom~spl0,weight=w_insom)

object15 <- summary(fit_insom)
print(xtable(object15),file="fit_insom.txt")
object15

object16 <- summary(fit0_insom)
print(xtable(object16),file="fit0_insom.txt")
object16

pr_insom <- predict(fit_insom)
pr0_insom <- predict(fit0_insom)

plot(x,mean_DDD_insom,ylim=c(0,40),xlab="Time",ylab="DDD")
lines(x,pr_insom,col="blue")
lines(x,pr0_insom,col="red")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

object16a <- anova(fit0_insom,fit_insom)
print(xtable(object16a),file="anova_insom.txt")
object16a

## prescpt
fit_prescpt <- lm(mean_DDD_prescpt~spl_p,weight=w_prescpt)
fit0_prescpt <- lm(mean_DDD_prescpt~spl0_p,weight=w_prescpt)

object17 <- summary(fit_prescpt)
print(xtable(object17),file="fit_prescpt.txt")
object17

object18 <- summary(fit0_prescpt)
print(xtable(object18),file="fit0_prescpt.txt")
object18

pr_prescpt <- predict(fit_prescpt)
pr0_prescpt <- predict(fit0_prescpt)

plot(x_p,mean_DDD_prescpt,ylim=c(0,40),xlim=c(0,72),xlab="Time",ylab="DDD")
lines(x_p,pr_prescpt,col="blue")
lines(x_p,pr0_prescpt,col="red")
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

object18a <- anova(fit0_prescpt,fit_prescpt)
print(xtable(object18a),file="anova_prescpt.txt")
object18a
