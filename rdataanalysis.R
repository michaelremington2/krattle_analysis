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
ggplot(snake_bp,aes(x=experiment,y=avg_bp))+geom_bar(stat='identity')+ggtitle('snake AVG bush Preference')
