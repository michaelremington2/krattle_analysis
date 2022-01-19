#!/usr/bin/python
import pandas

####################
#### Total Data ####
####################

## Tests ##
# Anova

## Figures ##
# bar chart of experimental groups
# x krat preference, y snake preference color coded


###################
#### Per Cycle ####
###################

## Tests ##
# Granger Causality
# optimum flipping 
# Percent time on 1 strategy.

## Figures ##
# 1 simulation by generation
# 1 simulation by cycle
# Grid of generations
# Ridgeline plot of variance
# 

class summerize_per_cycle_data(object):
	def __init__(self,per_cycle_file_path, parameter_file_path=None):
		per_cycle = pd.read_csv(per_cycle_file_path,header = 0, index_col=None)
		parameters = pd.read_csv(file_path_parameter,header = 0, index_col=None)