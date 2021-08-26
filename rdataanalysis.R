library(dplyr)
library(ggplot2)
library(forecast)
library(TTR)

setwd("/home/mremington/Documents/krattle_analysis/krattle_analysis/pop_sizes/Data/")
###########################
## Totals analysis
###########################
total_data <- read.csv("totals.csv",header=FALSE)
total_data <- total_data %>% 
  rename(
    file = V1,
    experiment = V2,
    sim = V3,
    org = V4,
    end_cycle = V5,
    end_gen = V6,
    avg_bush_pref = V7,
    std_bush_pref = V8,
    se_bush_pref = V9
  )

krat_counts <-c(60,90,120,150)
snake_counts <-c(20,30,40,50)

## Krat
krat_info <- total_data %>% filter(org=="krat")
krat_bp <- krat_info %>% group_by(experiment) %>% summarise(avg_bp = mean(avg_bush_pref),
                                                            sd_bush_pref = sd(avg_bush_pref), 
                                                            se_bush_pref = sd(avg_bush_pref)/sqrt(n()))
k_anova<-aov(avg_bush_pref ~ as.factor(experiment), data = krat_info)
summary(k_anova)

ggplot(krat_bp,aes(x=experiment,y=avg_bp))+
  geom_bar(stat='identity')+
  geom_errorbar(aes(ymin=avg_bp-sd_bush_pref, ymax=avg_bp+sd_bush_pref), width=.2,
                position=position_dodge(.9))+
  ggtitle('Krat AVG bush Preference')
  

## Snake
snake_info <- total_data %>% filter(org=="snake")
snake_bp <- snake_info %>% group_by(experiment) %>% summarise(avg_bp = mean(avg_bush_pref),
                                                              sd_bush_pref = sd(avg_bush_pref), 
                                                              se_bush_pref = sd(avg_bush_pref)/sqrt(n()))
ggplot(snake_bp,aes(x=experiment,y=avg_bp))+
  geom_bar(stat='identity')+
  geom_errorbar(aes(ymin=avg_bp-sd_bush_pref, ymax=avg_bp+sd_bush_pref), width=.2,
                position=position_dodge(.9))+
  ggtitle('Snake AVG bush Preference')

s_anova<-aov(avg_bush_pref ~ as.factor(experiment), data = snake_info)
summary(s_anova)

# comb
krat_snake <- merge(krat_info, snake_info, by = c("experiment", "sim"))
ggplot(krat_snake, aes(x=avg_bush_pref.y, y=avg_bush_pref.x,color=experiment)) +
  geom_point()+
  xlab("Snake_avg_pref")+
  ylab("Krat_avg_pref")


#########################
##### Per cycle Analysis
#########################

per_cycle <-read.csv("per_cycle.csv", header=FALSE)
per_cycle <- per_cycle %>% 
  rename(
    file = V1,
    experiment = V2,
    sim = V3,
    org = V4,
    cycle = V5,
    avg_bush_pref= V6
  )

## Krat
krat_info_per_cycle <- per_cycle %>% filter(org=="krat", experiment== "control")
krat_bp_per_cycle <- krat_info_per_cycle %>% group_by(experiment,cycle) %>% summarise(avg_bp = mean(avg_bush_pref))
krat_temp <- krat_bp_per_cycle %>%
  ungroup() %>% select(c("cycle","avg_bp"))
#https://robjhyndman.com/hyndsight/tscharacteristics/
krat_ts <- ts(krat_temp$avg_bp,start = min(krat_temp$cycle), end = max(krat_temp$cycle), frequency = 1)
SMA3 <- SMA(krat_ts,n=3)
plot.ts(SMA3)
fit <- tslm(krat_ts ~ trend)
krat_dec <- decompose(krat_ts)
plot(myds_month)
summary(fit)
plot(forecast(fit, h=20))
#plot.ts(krat_ts)
ggplot(krat_bp_per_cycle, aes(x=cycle, y=avg_bp, group=experiment, color=experiment)) +
  geom_line()+ggtitle('Krat AVG bush Preference')

## Snake
snake_info_per_cycle <- per_cycle %>% filter(org=="snake", experiment== "control")
snake_bp_per_cycle <- snake_info_per_cycle %>% group_by(experiment,cycle) %>% summarise(avg_bp = mean(avg_bush_pref))
ggplot(snake_bp_per_cycle, aes(x=cycle, y=avg_bp, group=experiment, color=experiment))+
  geom_line()+ggtitle('Snake AVG bush Preference')
