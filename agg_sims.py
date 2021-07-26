#!/usr/bin/python
import csv
import sys
import argparse
import pandas as pd 
import glob
import re
import json


#print(sys.argv[0])


#directory = 


#for i in
class export_data_from_sims(object):
	def __init__(self,sims, output_file_path_total, output_file_path_per_cycle=None):
		self.sims = sims
		self.output_file_path_total = output_file_path_total
		self.output_file_path_per_cycle = output_file_path_per_cycle


	def create_csv(self,fp):
		with open(fp, "w") as my_empty_csv:
			pass

	def format_experiment_label(self,exp_label):
		if len(exp_label.split("_")[1]) <= 2:
			experiment = exp_label.split("_")[0]+exp_label.split("_")[1]
		else:
			experiment = exp_label.split("_")[0]
		return experiment
		

	def overall_stats(self, sim):
		data=pd.read_csv(sim,header=None)
		data.columns = ['id','generation', 'cycle','open_pw','bush_pw','energy_score','movements','cell_id','microhabitat','snakes_in_cell','owls_in_cell']
		cycles=data['cycle'].max()
		generations=data['generation'].max()
		mean_bush_pref=data['bush_pw'].mean()
		std_bush_pref=data['bush_pw'].std()
		se_bush_pref=data['bush_pw'].sem()
		return cycles, generations, mean_bush_pref, std_bush_pref, se_bush_pref


	def extract_info(self):
		#,output_file_path
		self.create_csv(fp = self.output_file_path_total)
		for sim in self.sims:
			exp_label = sim.split("/")[-1]
			experiment = self.format_experiment_label(exp_label = exp_label)
			sim_number = re.findall(r'\d+',sim)[-1]
			cycles, generations, mean_bush_pref, std_bush_pref, se_bush_pref = self.overall_stats(sim =sim)
			if 'krat' in exp_label:
				data_type='krat'
			if 'snake' in exp_label:
				data_type='snake'
			row = [exp_label, experiment, sim_number, data_type, cycles, generations, mean_bush_pref, std_bush_pref, se_bush_pref]
			self.append_data(fp = self.output_file_path_total,d_row = row)

	def append_data(self,fp,d_row):
		with open(fp, 'a') as f:
		    writer = csv.writer(f)
		    writer.writerow(d_row)


def run(args):
    directory = args.input
    output_file_path_total = args.output_file_path_total
    sims = glob.glob(directory + "*.csv")
    edfs = export_data_from_sims(sims = sims, output_file_path_total=output_file_path_total)
    edfs.extract_info()

    #output_file_path = args.output # from dest="output"


def main():
	# python agg_sims.py -in  owl_data/sim_data/ -totals owl_data/total_sims_stats.csv
    parser=argparse.ArgumentParser(description="Aggregate the results and output a csv of them.")
    parser.add_argument("-in",help="a directory full of csvs." ,dest="input", type=str, required=True)
    parser.add_argument("-totals",help="a file path for the output csv of the stat on all simulations" ,dest="output_file_path_total", type=str, required=False, default=None)
    #parser.add_argument("-exp_config_file",help="the file of the config for the experiment" ,dest="config", type=str, required=False, default=None)
    parser.set_defaults(func=run)
    args=parser.parse_args()
    args.func(args)
    

if __name__=="__main__":
    main()