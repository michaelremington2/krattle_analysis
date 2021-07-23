import csv
import sys
import argparse
import pandas as pd 
import glob
import re


#print(sys.argv[0])


#directory = 


#for i in
def create_csv(output_file_path):
	with open(output_file_path, "w") as my_empty_csv:
		pass

def extract_info(sims):
	#,output_file_path
	for sim in sims:
		sim_number = re.findall(r'\d+',sim)[-1]
		print(sim.split("/")[-1].split("_")[0])




def append_data(d_row,output_file_path):
	with open(output_file_path, 'a') as f:
	    writer = csv.writer(f)
	    writer.writerow(d_row)


def run(args):
    directory = args.input
    sims = glob.glob(directory + "*.csv")
    extract_info(sims = sims)

    #output_file_path = args.output # from dest="output"


def main():
    parser=argparse.ArgumentParser(description="Aggregate the results and output a csv of them.")
    parser.add_argument("-in",help="a directory full of csvs." ,dest="input", type=str, required=True)
    #parser.add_argument("-out",help="a file path for the output csv" ,dest="output", type=str, required=False, default=None)
    parser.set_defaults(func=run)
    args=parser.parse_args()
    args.func(args)
    

if __name__=="__main__":
    main()