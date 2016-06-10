#### Plotte mean_DDD over time NY
alldata = read.table("means_DDD_comma_NY.csv",header=TRUE,sep=",")

library(base)
library(stats)
library(plotrix)

time=1:72
mean_DDD_NEW=alldata$mean_DDD
CI_min=alldata$CI_min
CI_max=alldata$CI_max

plot(time,mean_DDD_NEW,type="p", ylim=c(5,43), xlim=c(0,73), xlab="Time",ylab="DDD")
plotCI(time,mean_DDD_NEW, ui=CI_max, li=CI_min, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(v=37, untf=FALSE, lwd=2.5, col=3)
abline(v=53, untf=FALSE, lwd=2.5, col=3)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)

#### Plotte mean_DDD_female
alldata_female = read.table("means_DDD_female_comma_NY.csv",header=TRUE,sep=",")

mean_DDD_female_NEW=alldata_female$mean_DDD
CI_min_female=alldata_female$CI_min
CI_max_female=alldata_female$CI_max

plot(time,mean_DDD_female_NEW,type="p", ylim=c(5,45), xlim=c(0,73), xlab="Time from first quarter of 1995 to fourth quarter of 2012", ylab="Mean DDD - Females NEW")
plotCI(time,mean_DDD_female_NEW, ui=CI_max_female, li=CI_min_female, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
abline(v=53, untf=FALSE, lwd=2.5, col=3)

#### Plotte mean_DDD_male
alldata_male = read.table("means_DDD_male_comma_NY.csv",header=TRUE,sep=",")

mean_DDD_male_NEW=alldata_male$mean_DDD
CI_min_male=alldata_male$CI_min
CI_max_male=alldata_male$CI_max

plot(time,mean_DDD_male_NEW,type="p", ylim=c(5,45), xlim=c(0,73), xlab="Time from first quarter of 1995 to fourth quarter of 2012", ylab="Mean DDD - Males NEW")
plotCI(time,mean_DDD_male_NEW, ui=CI_max_male, li=CI_min_male, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
abline(v=53, untf=FALSE, lwd=2.5, col=3)

#### Plotte mean_DDD_inpsyk
alldata_inpsyk = read.table("means_DDD_inpsyk_comma_NY.csv",header=TRUE,sep=",")

mean_DDD_inpsyk_NEW=alldata_inpsyk$mean_DDD
CI_min_inpsyk=alldata_inpsyk$CI_min
CI_max_inpsyk=alldata_inpsyk$CI_max

plot(time,mean_DDD_inpsyk_NEW,type="p", ylim=c(5,45), xlim=c(0,73), xlab="Time from first quarter of 1995 to fourth quarter of 2012", ylab="Mean DDD - inpsyk NEW")
plotCI(time,mean_DDD_inpsyk_NEW, ui=CI_max_inpsyk, li=CI_min_inpsyk, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
abline(v=53, untf=FALSE, lwd=2.5, col=3)

#### Plotte mean_DDD_insom
alldata_insom = read.table("means_DDD_insom_comma_NY.csv",header=TRUE,sep=",")

mean_DDD_insom_NEW=alldata_insom$mean_DDD
CI_min_insom=alldata_insom$CI_min
CI_max_insom=alldata_insom$CI_max

plot(time,mean_DDD_insom_NEW,type="p", ylim=c(5,45), xlim=c(0,73), xlab="Time from first quarter of 1995 to fourth quarter of 2012", ylab="Mean DDD - insom NEW")
plotCI(time,mean_DDD_insom_NEW, ui=CI_max_insom, li=CI_min_insom, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
abline(v=53, untf=FALSE, lwd=2.5, col=3)

#### Plotte mean_DDD_prescpt
alldata_prescpt = read.table("means_DDD_prescpt_comma_NY.csv",header=TRUE,sep=",")

mean_DDD_prescpt_NEW=alldata_prescpt$mean_DDD
CI_min_prescpt=alldata_prescpt$CI_min
CI_max_prescpt=alldata_prescpt$CI_max

plot(time,mean_DDD_prescpt_NEW,type="p", ylim=c(5,45), xlim=c(0,73), xlab="Time from first quarter of 1995 to fourth quarter of 2012", ylab="Mean DDD - prescpt NEW")
plotCI(time,mean_DDD_prescpt_NEW, ui=CI_max_prescpt, li=CI_min_prescpt, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
abline(v=53, untf=FALSE, lwd=2.5, col=3)

#### Plotte mean_DDD_before
alldata_before = read.table("means_DDD_before_comma_NY.csv",header=TRUE,sep=",")

mean_DDD_before_NEW=alldata_before$mean_DDD
CI_min_before=alldata_before$CI_min
CI_max_before=alldata_before$CI_max

plot(time,mean_DDD_before_NEW,type="p", ylim=c(5,45), xlim=c(0,73), xlab="Time from first quarter of 1995 to fourth quarter of 2012", ylab="Mean DDD - Before NEW")
plotCI(time,mean_DDD_before_NEW, ui=CI_max_before, li=CI_min_before, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
abline(v=53, untf=FALSE, lwd=2.5, col=3)

#### Plotte mean_DDD_after
alldata_after = read.table("means_DDD_after_comma_NY.csv",header=TRUE,sep=",")

mean_DDD_after_NEW=alldata_after$mean_DDD
CI_min_after=alldata_after$CI_min
CI_max_after=alldata_after$CI_max

plot(time,mean_DDD_after_NEW,type="p", ylim=c(5,45), xlim=c(0,73), xlab="Time from first quarter of 1995 to fourth quarter of 2012", ylab="Mean DDD - After NEW")
plotCI(time,mean_DDD_after_NEW, ui=CI_max_after, li=CI_min_after, gap=0.005, add=TRUE, err="y", sfrac=0.002)
abline(h=21, untf=FALSE, lwd=2.5, col=7)
abline(h=7, untf=FALSE, lwd=2.5, col=5)
abline(v=53, untf=FALSE, lwd=2.5, col=3)


#### Plotte number of patients using vs not using medication per quarter
prevalens <- read.table("prevalens_comma_NY.csv",header=TRUE,sep=",")
counts <- rbind(prevalens$uden_medicin,prevalens$med_medicin)

barplot(counts, xlab="Time", ylab="Number of patients", col=c("blue","red"))
abline(v=53, untf=FALSE, lwd=2.5, col=3) 
abline(v=37, untf=FALSE, lwd=2.5, col=3)
