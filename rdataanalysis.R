library(dplyr)
library(ggplot2)
ls()
setwd("/home/mremington/Documents/krattle_analysis/krattle_analysis/owl_data/")
total_data <- read.csv("total_sims_stats.csv",header=FALSE)
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
## Krat
krat_info <- total_data %>% filter(org=="krat")
krat_bp <- krat_info %>% group_by(experiment) %>% summarise(avg_bp = mean(avg_bush_pref))
ggplot(krat_bp,aes(x=experiment,y=avg_bp))+geom_bar(stat='identity')+ggtitle('Krat AVG bush Preference')

## Snake
snake_info <- total_data %>% filter(org=="snake")
snake_bp <- snake_info %>% group_by(experiment) %>% summarise(avg_bp = mean(avg_bush_pref))
ggplot(snake_bp,aes(x=experiment,y=avg_bp))+geom_bar(stat='identity')+ggtitle('Snake AVG bush Preference')


#########################
##### Per cycle Analysis
#########################

per_cycle <-read.csv("owl_sim_stats_per_cycle.csv", header=FALSE)
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
ggplot(krat_bp_per_cycle, aes(x=cycle, y=avg_bp, group=experiment, color=experiment)) +
  geom_line()+ggtitle('Krat AVG bush Preference')

## Snake
snake_info_per_cycle <- per_cycle %>% filter(org=="snake")
snake_bp_per_cycle <- snake_info_per_cycle %>% group_by(experiment,cycle) %>% summarise(avg_bp = mean(avg_bush_pref))
ggplot(snake_bp_per_cycle, aes(x=cycle, y=avg_bp, group=experiment, color=experiment))+
  geom_line()+ggtitle('Snake AVG bush Preference')
