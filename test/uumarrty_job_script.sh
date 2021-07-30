#! /bin/bash

FP_CONFIG="test_config.txt"
DATA_FOLDER="/home/mremington/Documents/krattle_analysis/krattle_analysis/test/Data/"
python make_config.py -file_name $FP_CONFIG 
python "/home/mremington/Documents/uumarrty/bin/simulate_uumarrty.py" -in $FP_CONFIG -out $DATA_FOLDER -iter 2 -burn_in 50
python "/home/mremington/Documents/uumarrty/bin/aggregate_info_from_sims.py" -in $DATA_FOLDER -totals totals.csv -per_cycle per_cycle.csv