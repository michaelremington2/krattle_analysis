library(dplyr)
library(ggplot2)
library(forecast)
library(TTR)
library(cowplot)
library(stringr)
rm(list = ls())
#setwd("/home/mremington/Documents/krattle_analysis/krattle_analysis/pop_sizes/Data/")
#setwd("/home/mremington/Documents/krattle_analysis/krattle_analysis/test/Data/")
#setwd("/home/mremington/Documents/uumarrty_exps/pop_sizes")
#setwd("/home/mremington/Documents/uumarrty_exps/owl_exp")
setwd("/home/mremington/Documents/uumarrty_exps/mixed_owl_exp")
##########
## EXP Input Parameters
##########

owl_exp1_parameters <- read.csv("exp1/Data/parameters.csv",header=TRUE)
owl_exp2_parameters <- read.csv("exp2/Data/parameters.csv",header=TRUE)
owl_exp3_parameters <- read.csv("exp3/Data/parameters.csv",header=TRUE)
owl_exp4_parameters <- read.csv("exp4/Data/parameters.csv",header=TRUE)
owl_exp5_parameters <- read.csv("exp5/Data/parameters.csv",header=TRUE)
owl_exp6_parameters <- read.csv("exp6/Data/parameters.csv",header=TRUE)
owl_parameters <- union(owl_exp1_parameters,owl_exp2_parameters)
owl_parameters <- union(owl_parameters,owl_exp3_parameters)
owl_parameters <- union(owl_parameters,owl_exp4_parameters)
owl_parameters <- union(owl_parameters,owl_exp5_parameters)
owl_parameters <- union(owl_parameters,owl_exp6_parameters)

###########################
## Totals analysis
###########################

# exp1exp2_total <- read.csv("control_exp1/Data/totals.csv",header=FALSE)
# exp3exp4_total <- read.csv("exp2_exp3/Data/totals.csv",header=FALSE)
# exp5exp6_total <- read.csv("exp4_exp5/Data/totals.csv",header=FALSE)
exp1_total <- read.csv("exp1/Data/totals.csv",header=TRUE)
exp2_total <- read.csv("exp2/Data/totals.csv",header=TRUE)
exp3_total <- read.csv("exp3/Data/totals.csv",header=TRUE)
exp4_total <- read.csv("exp4/Data/totals.csv",header=TRUE)
exp5_total <- read.csv("exp5/Data/totals.csv",header=TRUE)
exp6_total <- read.csv("exp6/Data/totals.csv",header=TRUE)
total_data <- union(exp1_total,exp2_total)
total_data <- union(total_data,exp3_total)
total_data <- union(total_data,exp4_total)
total_data <- union(total_data,exp5_total)
total_data <- union(total_data,exp6_total)

total_data$exp_figure_label <- str_sub(total_data$experiment,-1,-1)







###
# Experimental Groups
###
exp_groups <- merge(x = owl_parameters, y = total_data, by = "sim_id", all = TRUE) %>%
  group_by(experiment) %>%
  summarise(krats = max(initial_krat_pop),
            snakes = max(initial_snake_pop),
            owls = max(initial_owl_pop)) %>%
  na.omit()
######
### Successful Sims
######
sim_counts <- total_data %>%
  group_by(experiment) %>%  
  summarise(Unique_Elements = n_distinct(sim_id))
  

## Krat
krat_info <- total_data %>% filter(data_type=="krat")
krat_bp <- krat_info %>% group_by(exp_figure_label) %>% summarise(avg_bp = mean(mean_bush_pref),
                                                            sd_bush_pref = sd(mean_bush_pref), 
                                                            se_bush_pref = sd(mean_bush_pref)/sqrt(n()))
k_anova<-aov(mean_bush_pref ~ as.factor(exp_figure_label), data = krat_info)
summary(k_anova)

krat_bpw_fig<- ggplot(krat_bp,aes(x=exp_figure_label,y=avg_bp))+
                  geom_bar(stat='identity')+
                  geom_errorbar(aes(ymin=avg_bp-sd_bush_pref, ymax=avg_bp+sd_bush_pref), width=.2,
                                position=position_dodge(.9))+
                  ggtitle('Krat AVG Bush Preference')
  
krat_bpw_fig
## Snake
snake_info <- total_data %>% filter(data_type=="snake")
snake_bp <- snake_info %>% group_by(exp_figure_label) %>% summarise(avg_bp = mean(mean_bush_pref),
                                                              sd_bush_pref = sd(mean_bush_pref), 
                                                              se_bush_pref = sd(mean_bush_pref)/sqrt(n()))
snake_bpw_fig<-ggplot(snake_bp,aes(x=experiment,y=avg_bp))+
                      geom_bar(stat='identity')+
                      geom_errorbar(aes(ymin=avg_bp-sd_bush_pref, ymax=avg_bp+sd_bush_pref), width=.2,
                                    position=position_dodge(.9))+
                      ggtitle('Snake AVG bush Preference')

s_anova<-aov(mean_bush_pref ~ as.factor(exp_figure_label), data = snake_info)
summary(s_anova)
####
# Totals resuts
####
org_info <- total_data %>% group_by(data_type,exp_figure_label) %>% summarise(avg_bp = mean(mean_bush_pref),
                                       sd_bush_pref = sd(mean_bush_pref), 
                                       se_bush_pref = sd(mean_bush_pref)/sqrt(n()))

###########################
#### Figure by EXP
###########################


ggplot(org_info,aes(fill=data_type,x=exp_figure_label,y=avg_bp))+
  geom_bar(stat='identity',position=position_dodge(.9))+
  geom_errorbar(aes(ymin=avg_bp-sd_bush_pref, ymax=avg_bp+sd_bush_pref), width=.2,
                position=position_dodge(.9))+
  scale_fill_manual("Organism", values = c("krat" = "#FFC20A", "snake" = "#0C7BDC"))+
  ylab("Bush Preference")+
  xlab("Experimental Group")+
  ggtitle('Continuous Bush Preference by Organism')+
  theme(plot.title = element_text(size = 18, face = "bold"))+
  theme(text=element_text(size=14, face = "bold"))

ggsave('/home/mremington/Documents/uumarrty_exps/figures/totals_owl_exp.png')




# comb
krat_snake <- merge(krat_info, snake_info, by = c("sim_id"))
ggplot(krat_snake, aes(x=mean_bush_pref.y, y=mean_bush_pref.x,color=experiment.x)) +
  geom_point()+
  xlab("Snake_avg_pref")+
  ylab("Krat_avg_pref")

ggplot(krat_snake, aes(x=mean_bush_pref.x, y=mean_bush_pref.y,color=experiment.x)) +
  geom_point()+
  ylab("Snake_avg_pref")+
  xlab("Krat_avg_pref")


#########################
##### Per cycle Analysis
#########################
# exp1exp2_per_cycle <- read.csv("control_exp1/Data/per_cycle.csv",header=TRUE)
# exp3exp4_per_cycle <- read.csv("exp2_exp3/Data/per_cycle.csv",header=TRUE)
# exp5exp6_per_cycle <- read.csv("exp4_exp5/Data/per_cycle.csv",header=TRUE)
exp1_per_cycle <- read.csv("exp1/Data/per_cycle.csv",header=TRUE)
exp2_per_cycle <- read.csv("exp2/Data/per_cycle.csv",header=TRUE)
exp3_per_cycle <- read.csv("exp3/Data/per_cycle.csv",header=TRUE)
exp4_per_cycle <- read.csv("exp4/Data/per_cycle.csv",header=TRUE)
exp5_per_cycle <- read.csv("exp5/Data/per_cycle.csv",header=TRUE)
exp6_per_cycle <- read.csv("exp6/Data/per_cycle.csv",header=TRUE)
# exp1_per_cycle_krat <- exp1_per_cycle %>% filter(org=="krat")
# exp2_per_cycle_krat <- exp2_per_cycle %>% filter(org=="krat")
# exp3_per_cycle_krat <- exp3_per_cycle %>% filter(org=="krat")
# exp4_per_cycle_krat <- exp4_per_cycle %>% filter(org=="krat")
# krat_per_cycle <- union(exp1exp2_per_cycle_krat,exp1exp2_per_cycle_krat)
# krat_per_cycle <- union(krat_per_cycle,exp5exp6_per_cycle_krat)


exp1_per_cycle_1_sim <- exp1_per_cycle %>% filter(sim_number==0, cycle>=490000) %>% group_by(org,cycle) %>% summarise(avg_bp = max(bush_pw_mean),
                                                                                                       sd_bush_pref = max(bush_pw_std))
exp2_per_cycle_1_sim <- exp2_per_cycle %>% filter(sim_number==0, cycle>=490000)%>% group_by(org,cycle) %>% summarise(avg_bp = max(bush_pw_mean),
                                                                                                      sd_bush_pref = max(bush_pw_std))
exp3_per_cycle_1_sim <- exp3_per_cycle %>% filter(sim_number==0, cycle>=490000)%>% group_by(org,cycle) %>% summarise(avg_bp = max(bush_pw_mean),
                                                                                                      sd_bush_pref = max(bush_pw_std))
exp4_per_cycle_1_sim <- exp4_per_cycle %>% filter(sim_number==0, cycle>=490000)%>% group_by(org,cycle) %>% summarise(avg_bp = max(bush_pw_mean),
                                                                                                      sd_bush_pref = max(bush_pw_std))
exp5_per_cycle_1_sim <- exp5_per_cycle %>% filter(sim_number==0, cycle>=490000)%>% group_by(org,cycle) %>% summarise(avg_bp = max(bush_pw_mean),
                                                                                                      sd_bush_pref = max(bush_pw_std))
exp6_per_cycle_1_sim <- exp6_per_cycle %>% filter(sim_number==0, cycle>=490000)%>% group_by(org,cycle) %>% summarise(avg_bp = max(bush_pw_mean),
                                                                                                      sd_bush_pref = max(bush_pw_std))

owl_sim_per_cycle <- union(exp1_per_cycle_1_sim,exp2_per_cycle_1_sim)
owl_sim_per_cycle <- union(owl_sim_per_cycle,exp3_per_cycle_1_sim)
owl_sim_per_cycle <- union(owl_sim_per_cycle,exp4_per_cycle_1_sim)
owl_sim_per_cycle <- union(owl_sim_per_cycle,exp5_per_cycle_1_sim)
owl_sim_per_cycle <- union(owl_sim_per_cycle,exp6_per_cycle_1_sim)

## Krat
krat_info_per_cycle <- krat_per_cycle %>% filter(experiment== "experiment5")
krat_bp_per_cycle <- krat_info_per_cycle %>% group_by(experiment,cycle) %>% summarise(avg_bp = mean(bush_pw_mean))
krat_temp <- krat_bp_per_cycle %>%
  ungroup() %>% select(c("cycle","avg_bp"))
krat_bp_per_cycle <- krat_info_per_cycle %>% group_by(experiment,cycle) %>% summarise(avg_bp = mean(bush_pw_mean))
#https://robjhyndman.com/hyndsight/tscharacteristics/
krat_ts <- ts(krat_temp$avg_bp,start = min(krat_temp$cycle), end = max(krat_temp$cycle), frequency = 365)
# frequency generations
# mentally think of the cycle as 24 hour
# cycles would be a pulse
# cycle is 24 hour period
# ggridge ridgline
# Periodicity
SMA3 <- SMA(krat_ts,n=3)
plot.ts(SMA3)
fit <- tslm(krat_ts ~ trend)
krat_dec <- decompose(krat_ts)
plot(myds_month)
summary(fit)
plot(forecast(fit, h=20))
#plot.ts(krat_ts)
#, group=experiment, color=experiment
krat_temp <-exp2_per_cycle_1_sim  %>% group_by(generation) %>% summarise(avg_bp = mean(bush_pw_mean))%>% filter(cycle>=400000)
ggplot(krat_temp, aes(x=cycle, y=avg_bp)) +
  geom_line()+ggtitle('Krat AVG bush Preference')

## Snake
snake_info_per_cycle <- per_cycle %>% filter(org=="snake", experiment== "control")
snake_bp_per_cycle <- snake_info_per_cycle %>% group_by(experiment,cycle) %>% summarise(avg_bp = mean(avg_bush_pref))
ggplot(snake_bp_per_cycle, aes(x=cycle, y=avg_bp, group=experiment, color=experiment))+
  geom_line()+ggtitle('Snake AVG bush Preference')

###
# Stacked per cycle figures
###
pc1<-ggplot(exp1_per_cycle_1_sim, aes(x=cycle, y=avg_bp, group=org, color=org))+
            geom_line(size=2)+
            ylab("Bush Preference")+
            #xlab("Cycle")+
            xlab("")+
            ggtitle('Exp1')+
            theme(plot.title = element_text(size = 14, face = "bold"))+
            theme(text=element_text(size=10, face = "bold"),
                  axis.text.x = element_text(angle = 45, vjust = 0.5))+
            ylim(0,1)+
            scale_color_manual("Organism", values = c("krat" = "#FFC20A", "snake" = "#0C7BDC"))

pc1

pc2<-ggplot(exp2_per_cycle_1_sim, aes(x=cycle, y=avg_bp, group=org, color=org))+
  geom_line(size=2)+
  ylab("Bush Preference")+
  xlab("")+
  ggtitle('Exp2')+
  theme(plot.title = element_text(size = 14, face = "bold"))+
  theme(text=element_text(size=10, face = "bold"),
        axis.text.x = element_text(angle = 45, vjust = 0.5))+
  ylim(0,1)+
  scale_color_manual("Organism", values = c("krat" = "#FFC20A", "snake" = "#0C7BDC"))

pc3<-ggplot(exp3_per_cycle_1_sim, aes(x=cycle, y=avg_bp, group=org, color=org))+
  geom_line(size=2)+
  ylab("Bush Preference")+
  xlab("Cycle")+
  ggtitle('Exp 3')+
  theme(plot.title = element_text(size = 14, face = "bold"))+
  theme(text=element_text(size=10, face = "bold"),
        axis.text.x = element_text(angle = 45, vjust = 0.5))+
  ylim(0,1)+
  scale_color_manual("Organism", values = c("krat" = "#FFC20A", "snake" = "#0C7BDC"))

pc4<-ggplot(exp4_per_cycle_1_sim, aes(x=cycle, y=avg_bp, group=org, color=org))+
  geom_line(size=2)+
  ylab("")+
  xlab("")+
  ggtitle('Exp 4')+
  theme(plot.title = element_text(size = 14, face = "bold"))+
  theme(text=element_text(size=10, face = "bold"),
        axis.text.x = element_text(angle = 45, vjust = 0.5))+
  ylim(0,1)+
  scale_color_manual("Organism", values = c("krat" = "#FFC20A", "snake" = "#0C7BDC"))

pc5<-ggplot(exp5_per_cycle_1_sim, aes(x=cycle, y=avg_bp, group=org, color=org))+
  geom_line(size=2)+
  ylab("")+
  xlab("")+
  ggtitle('Exp 5')+
  theme(plot.title = element_text(size = 14, face = "bold"))+
  theme(text=element_text(size=10, face = "bold"),
        axis.text.x = element_text(angle = 45, vjust = 0.5))+
  ylim(0,1)+
  scale_color_manual("Organism", values = c("krat" = "#FFC20A", "snake" = "#0C7BDC"))

pc6<-ggplot(exp6_per_cycle_1_sim, aes(x=cycle, y=avg_bp, group=org, color=org))+
  geom_line(size=2)+
  ylab("")+
  xlab("Cycle")+
  ggtitle('Exp 6')+
  theme(plot.title = element_text(size = 14, face = "bold"))+
  theme(text=element_text(size=10, face = "bold"),
        axis.text.x = element_text(angle = 45, vjust = 0.5))+
  ylim(0,1)+
  scale_color_manual("Organism", values = c("krat" = "#FFC20A", "snake" = "#0C7BDC"))

pc1
#ggsave('/home/mremington/Documents/uumarrty_exps/figures/single_sim_owl_exp.png')
# can arrange plots on the grid by column as well as by row.
plot_grid(
  pc1,  pc4,
  pc2,  pc5,
  pc3,  pc6,
  ncol = 2,
  byrow = TRUE
)
ggsave('/home/mremington/Documents/krattle_analysis/krattle_analysis/test/mixed_owl_single_sim.png')
