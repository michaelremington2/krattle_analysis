#!/usr/bin/python
import json

experiment_iterations = 1
experiment_name = 'owl_data/owl_exp.txt'

control_group = {"cycles_of_sim": 50000,
                 "krat_data_sample_freq": 10,
                 "snake_data_sample_freq": 10,
                 "landscape_size_x": 15,
                 "landscape_size_y": 15, 
                 "microhabitat_open_bush_proportions": [0.5, 0.5],
                 "initial_snake_pop": 20,
                 "initial_krat_pop": 180,
                 "initial_owl_pop": 0,
                 "snake_death_probability": 0.001,
                 "snake_strike_success_probability_bush": 0.21,
                 "snake_strike_success_probability_open": 0.21,
                 "krat_energy_gain_bush": 12, "krat_energy_gain_open": 12,
                 "snake_energy_gain": 1500,
                 "krat_energy_cost": 7,
                 "snake_energy_cost": 14,
                 "krat_move_range": 20,
                 "snake_move_range": 20,
                 "owl_move_range": 20,
                 "krat_movement_frequency_per_x_cycles": 1,
                 "snake_movement_frequency_per_x_cycles": 8,
                 "owl_movement_frequency_per_x_cycles": 1,
                 "owl_catch_success": 0.21,
                 "krat_mutation_std": 0.15,
                 "snake_mutation_std": 0.15,
                 "krat_mutation_probability": 0.01,
                 "snake_mutation_probability": 0.01,
                 "krat_reproduction_freq_per_x_cycles": 50,
                 "snake_reproduction_freq_per_x_cycles": 50,
                 "mixed_preference_individuals": False,
                 "prey_competition": False}

experimental_group_1 = {"cycles_of_sim": 50000,
                 "krat_data_sample_freq": 10,
                 "snake_data_sample_freq": 10,
                 "landscape_size_x": 15,
                 "landscape_size_y": 15, 
                 "microhabitat_open_bush_proportions": [0.5, 0.5],
                 "initial_snake_pop": 15,
                 "initial_krat_pop": 180,
                 "initial_owl_pop": 5,
                 "snake_death_probability": 0.001,
                 "snake_strike_success_probability_bush": 0.21,
                 "snake_strike_success_probability_open": 0.21,
                 "krat_energy_gain_bush": 12, "krat_energy_gain_open": 12,
                 "snake_energy_gain": 1500,
                 "krat_energy_cost": 7,
                 "snake_energy_cost": 14,
                 "krat_move_range": 20,
                 "snake_move_range": 20,
                 "owl_move_range": 20,
                 "krat_movement_frequency_per_x_cycles": 1,
                 "snake_movement_frequency_per_x_cycles": 8,
                 "owl_movement_frequency_per_x_cycles": 1,
                 "owl_catch_success": 0.21,
                 "krat_mutation_std": 0.15,
                 "snake_mutation_std": 0.15,
                 "krat_mutation_probability": 0.01,
                 "snake_mutation_probability": 0.01,
                 "krat_reproduction_freq_per_x_cycles": 50,
                 "snake_reproduction_freq_per_x_cycles": 50,
                 "mixed_preference_individuals": False,
                 "prey_competition": False}

experimental_group_2 = {"cycles_of_sim": 50000,
                 "krat_data_sample_freq": 10,
                 "snake_data_sample_freq": 10,
                 "landscape_size_x": 15,
                 "landscape_size_y": 15, 
                 "microhabitat_open_bush_proportions": [0.5, 0.5],
                 "initial_snake_pop": 10,
                 "initial_krat_pop": 180,
                 "initial_owl_pop": 10,
                 "snake_death_probability": 0.001,
                 "snake_strike_success_probability_bush": 0.21,
                 "snake_strike_success_probability_open": 0.21,
                 "krat_energy_gain_bush": 12, "krat_energy_gain_open": 12,
                 "snake_energy_gain": 1500,
                 "krat_energy_cost": 7,
                 "snake_energy_cost": 14,
                 "krat_move_range": 20,
                 "snake_move_range": 20,
                 "owl_move_range": 20,
                 "krat_movement_frequency_per_x_cycles": 1,
                 "snake_movement_frequency_per_x_cycles": 8,
                 "owl_movement_frequency_per_x_cycles": 1,
                 "owl_catch_success": 0.21,
                 "krat_mutation_std": 0.15,
                 "snake_mutation_std": 0.15,
                 "krat_mutation_probability": 0.01,
                 "snake_mutation_probability": 0.01,
                 "krat_reproduction_freq_per_x_cycles": 50,
                 "snake_reproduction_freq_per_x_cycles": 50,
                 "mixed_preference_individuals": False,
                 "prey_competition": False}

experimental_group_3 = {"cycles_of_sim": 50000,
                 "krat_data_sample_freq": 10,
                 "snake_data_sample_freq": 10,
                 "landscape_size_x": 15,
                 "landscape_size_y": 15, 
                 "microhabitat_open_bush_proportions": [0.5, 0.5],
                 "initial_snake_pop": 5,
                 "initial_krat_pop": 180,
                 "initial_owl_pop": 15,
                 "snake_death_probability": 0.001,
                 "snake_strike_success_probability_bush": 0.21,
                 "snake_strike_success_probability_open": 0.21,
                 "krat_energy_gain_bush": 12, "krat_energy_gain_open": 12,
                 "snake_energy_gain": 1500,
                 "krat_energy_cost": 7,
                 "snake_energy_cost": 14,
                 "krat_move_range": 20,
                 "snake_move_range": 20,
                 "owl_move_range": 20,
                 "krat_movement_frequency_per_x_cycles": 1,
                 "snake_movement_frequency_per_x_cycles": 8,
                 "owl_movement_frequency_per_x_cycles": 1,
                 "owl_catch_success": 0.21,
                 "krat_mutation_std": 0.15,
                 "snake_mutation_std": 0.15,
                 "krat_mutation_probability": 0.01,
                 "snake_mutation_probability": 0.01,
                 "krat_reproduction_freq_per_x_cycles": 50,
                 "snake_reproduction_freq_per_x_cycles": 50,
                 "mixed_preference_individuals": False,
                 "prey_competition": False}

experimental_groups = {
    "control" : control_group,
    "experiment_1": experimental_group_1,
    "experiment_2": experimental_group_2,
    "experiment_3": experimental_group_3,
}
def main(experimental_groups, file_name):
    with open(file_name, 'w') as outfile:
        json.dump(experimental_groups, outfile)

if __name__ ==  "__main__":
    main(experimental_groups, experiment_name)