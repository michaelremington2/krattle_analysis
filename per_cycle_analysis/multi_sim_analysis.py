#!/usr/bin/python
import pandas as pd
import numpy as np
import csv
import os
import time
import single_sim_analysis as ipc


class Experiment_Per_Cycle_Analysis(object):
    def __init__(self,per_cycle_data_file,parameter_file,output_file_csv):
        self.per_cycle = pd.read_csv(per_cycle_data_file,header = 0, index_col=None)
        self.parameters = pd.read_csv(parameter_file,header = 0, index_col=None)
        self.output_file_csv = output_file_csv
        self.per_gen_data_format()
        header = ['sim_id','org', 'mean_strategy_flip_time', 'std_strategy_flip_time', 'var_strategy_flip_time']
        if(os.path.exists(self.output_file_csv) and os.path.isfile(self.output_file_csv)):
            pass
        else:
            self.create_csv(fp=self.output_file_csv,header=header)

    def create_csv(self,fp, header=None):
        with open(fp, "w") as my_empty_csv:
            pass
        if header is not None:
           self.append_data(fp = fp, d_row = header)

    def append_data(self,fp,d_row):
        with open(fp, 'a') as f:
            writer = csv.writer(f)
            writer.writerow(d_row)

    def by_gen_filter(self,krat_reproduction_freq, snake_reproduction_freq):
        by_gen_filter_col = []
        for index,row in self.per_cycle.iterrows():
            if row['org']=='krat' and (row['cycle'] % krat_reproduction_freq==0):
                val=1
            elif row['org']=='snake' and (row['cycle'] % snake_reproduction_freq==0):
                val=1
            else:
                val=0
            by_gen_filter_col.append(val)
        return by_gen_filter_col

    def per_gen_data_format(self):
        self.krat_reproduction_freq = self.parameters['krat_reproduction_freq_per_x_cycles'].max()
        self.snake_reproduction_freq = self.parameters['snake_reproduction_freq_per_x_cycles'].max()
        self.per_cycle['by_gen_filter'] = self.by_gen_filter(krat_reproduction_freq = self.krat_reproduction_freq,
                                                             snake_reproduction_freq = self.snake_reproduction_freq)

        self.by_gen_data = self.per_cycle[self.per_cycle['by_gen_filter']==1]

    def run_classifacation_algorithm(self,sim):
        step_size=1
        sensitivity=0.01
        x = list(sim['generation'])
        y = list(sim["bush_pw_mean"])
        yx_dx = ipc.aprox_derv_central(data=y,step_size_forward=1,step_size_backward=step_size)
        smooth_yx_dx = ipc.savitzky_golay(y_list=yx_dx, window_size=3, order=1, deriv=0, rate=1)
        yx_dx2 = ipc.aprox_derv_central(data=yx_dx,step_size_forward=step_size,step_size_backward=step_size)
        smooth_yx_dx2 = ipc.savitzky_golay(y_list=yx_dx2, window_size=3, order=1, deriv=0, rate=1)
        data_tuples = list(zip(x,y,smooth_yx_dx,smooth_yx_dx2))
        df = pd.DataFrame(data_tuples, columns=['x','y','yx_dx','yx_dx2'])
        classifacation = ipc.inflection_point_classifaction(df=df,sensitivity=sensitivity)
        df['point_classifacation'] = classifacation
        dot_class = ipc.plotable_points(df=df)
        df['dot_class'] = dot_class
        df['min_max_flip'] = ipc.min_max_flip_by_gen(df=df)
        df['time_as_max_min'] = df.groupby((df['min_max_flip'] != df['min_max_flip'].shift(1)).cumsum()).cumcount()+1
        df['min_max_filter'] = ipc.min_max_filter(df=df)
        mean_strategy_flip_time = df[df['min_max_filter']==1]['time_as_max_min'].mean()
        std_strategy_flip_time = df[df['min_max_filter']==1]['time_as_max_min'].std()
        var_strategy_flip_time = df[df['min_max_filter']==1]['time_as_max_min'].var()
        sim_id = sim['sim_id'].max()
        org = sim['org'].max()
        exp = sim['experiment'].max()
        return [sim_id,exp,org, mean_strategy_flip_time, std_strategy_flip_time, var_strategy_flip_time]


    def loop_through_sims(self):
        sim_groupings = self.by_gen_data.groupby(['sim_id','org'])
        for name, sim in sim_groupings:
            data = self.run_classifacation_algorithm(sim=sim)
            self.append_data(fp = self.output_file_csv,d_row=data)



def main():
    exp_num = 6
    file_path_parameter = '/home/mremington/Documents/uumarrty_exps/owl_exp/exp{}/Data/parameters.csv'.format(exp_num)
    file_path_per_cycle = '/home/mremington/Documents/uumarrty_exps/owl_exp/exp{}/Data/per_cycle.csv'.format(exp_num)
    output_csv_file_path = '/home/mremington/Documents/krattle_analysis/krattle_analysis/per_cycle_analysis/owl_point_classifacation_exp{}.csv'.format(exp_num)
    epca = Experiment_Per_Cycle_Analysis(per_cycle_data_file=file_path_per_cycle,parameter_file=file_path_parameter,output_file_csv=output_csv_file_path)
    epca.loop_through_sims()

if __name__=="__main__":
    main()
