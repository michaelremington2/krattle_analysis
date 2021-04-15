#!/usr/bin/python
import json

experiment_iterations = 5

control_group = {
    "cycles_of_sim": 10000, 
    "krat_data_sample_freq": 50,
    "snake_data_sample_freq": 50, 
    "landscape_size_x": 150,
    "landscape_size_y": 150,
    "microhabitat_open_bush_proportions": [0.5,0.5],
    "initial_snake_pop": 40,
    "initial_krat_pop": 250,
    "initial_owl_pop": 0,
    "snake_death_probability":0.001,
    "snake_strike_success_probability_bush":0.21, #0.032, #from bouskila 
    "snake_strike_success_probability_open":0.21, #0.009, #from bouskila
    "krat_energy_gain_bush": 12, #from bouskila
    "krat_energy_gain_open": 12, #from bouskila
    "snake_energy_gain": 1500, ## estimate numerical approximationkrat total reproduction death cost 
    "krat_energy_cost":7, # alpha from bouskila
    "snake_energy_cost":14, # beta value not reported by bouskila, using 14 for now because it is twice as much as the krat. it might be worth trying to make this proportional to body size.
    "krat_move_range":20,
    "snake_move_range":20,
    "owl_move_range":20,
    "krat_movement_frequency_per_x_cycles":1, # once per cycle
    "snake_movement_frequency_per_x_cycles":8, # once per 8 cycles
    "owl_movement_frequency_per_x_cycles":1, # once per 8 cycles
    "owl_catch_success":0.21, #from bouskila
    "move_preference_algorithm":False,
    "memory_length_krat":20,
    "memory_length_snake":20,
    "krat_mutation_std":0.15,
    "snake_mutation_std":0.15,
    "krat_mutation_probability":0.01,
    "snake_mutation_probability":0.01,
    "krat_reproduction_freq_per_x_cycles": 50,
    "snake_reproduction_freq_per_x_cycles": 50,
    "mixed_preference_individuals": False
    # 1000 reproduction events
    }

experimental_group_1 = {
    "cycles_of_sim": 10000, 
    "krat_data_sample_freq": 50,
    "snake_data_sample_freq": 50, 
    "landscape_size_x": 150,
    "landscape_size_y": 150,
    "microhabitat_open_bush_proportions": [0.5,0.5],
    "initial_snake_pop": 30,
    "initial_krat_pop": 250,
    "initial_owl_pop": 10,
    "snake_death_probability":0.001,
    "snake_strike_success_probability_bush":0.21, #0.032, #from bouskila 
    "snake_strike_success_probability_open":0.21, #0.009, #from bouskila
    "krat_energy_gain_bush": 12, #from bouskila
    "krat_energy_gain_open": 12, #from bouskila
    "snake_energy_gain": 1500, ## estimate numerical approximationkrat total reproduction death cost 
    "krat_energy_cost":7, # alpha from bouskila
    "snake_energy_cost":14, # beta value not reported by bouskila, using 14 for now because it is twice as much as the krat. it might be worth trying to make this proportional to body size.
    "krat_move_range":20,
    "snake_move_range":20,
    "owl_move_range":20,
    "krat_movement_frequency_per_x_cycles":1, # once per cycle
    "snake_movement_frequency_per_x_cycles":8, # once per 8 cycles
    "owl_movement_frequency_per_x_cycles":1, # once per 8 cycles
    "owl_catch_success":0.21, #from bouskila
    "move_preference_algorithm":False,
    "memory_length_krat":20,
    "memory_length_snake":20,
    "krat_mutation_std":0.15,
    "snake_mutation_std":0.15,
    "krat_mutation_probability":0.01,
    "snake_mutation_probability":0.01,
    "krat_reproduction_freq_per_x_cycles": 50,
    "snake_reproduction_freq_per_x_cycles": 50,
    "mixed_preference_individuals": False
    # 1000 reproduction events
    }

experimental_group_2 = {
    "cycles_of_sim": 10000, 
    "krat_data_sample_freq": 50,
    "snake_data_sample_freq": 50, 
    "landscape_size_x": 150,
    "landscape_size_y": 150,
    "microhabitat_open_bush_proportions": [0.5,0.5],
    "initial_snake_pop": 20,
    "initial_krat_pop": 250,
    "initial_owl_pop": 20,
    "snake_death_probability":0.001,
    "snake_strike_success_probability_bush":0.21, #0.032, #from bouskila 
    "snake_strike_success_probability_open":0.21, #0.009, #from bouskila
    "krat_energy_gain_bush": 12, #from bouskila
    "krat_energy_gain_open": 12, #from bouskila
    "snake_energy_gain": 1500, ## estimate numerical approximationkrat total reproduction death cost 
    "krat_energy_cost":7, # alpha from bouskila
    "snake_energy_cost":14, # beta value not reported by bouskila, using 14 for now because it is twice as much as the krat. it might be worth trying to make this proportional to body size.
    "krat_move_range":20,
    "snake_move_range":20,
    "owl_move_range":20,
    "krat_movement_frequency_per_x_cycles":1, # once per cycle
    "snake_movement_frequency_per_x_cycles":8, # once per 8 cycles
    "owl_movement_frequency_per_x_cycles":1, # once per 8 cycles
    "owl_catch_success":0.21, #from bouskila
    "move_preference_algorithm":False,
    "memory_length_krat":20,
    "memory_length_snake":20,
    "krat_mutation_std":0.15,
    "snake_mutation_std":0.15,
    "krat_mutation_probability":0.01,
    "snake_mutation_probability":0.01,
    "krat_reproduction_freq_per_x_cycles": 50,
    "snake_reproduction_freq_per_x_cycles": 50,
    "mixed_preference_individuals": False
    # 1000 reproduction events
    }

experimental_group_3 = {
    "cycles_of_sim": 10000, 
    "krat_data_sample_freq": 50,
    "snake_data_sample_freq": 50, 
    "landscape_size_x": 150,
    "landscape_size_y": 150,
    "microhabitat_open_bush_proportions": [0.5,0.5],
    "initial_snake_pop": 10,
    "initial_krat_pop": 250,
    "initial_owl_pop": 30,
    "snake_death_probability":0.001,
    "snake_strike_success_probability_bush":0.21, #0.032, #from bouskila 
    "snake_strike_success_probability_open":0.21, #0.009, #from bouskila
    "krat_energy_gain_bush": 12, #from bouskila
    "krat_energy_gain_open": 12, #from bouskila
    "snake_energy_gain": 1500, ## estimate numerical approximationkrat total reproduction death cost 
    "krat_energy_cost":7, # alpha from bouskila
    "snake_energy_cost":14, # beta value not reported by bouskila, using 14 for now because it is twice as much as the krat. it might be worth trying to make this proportional to body size.
    "krat_move_range":20,
    "snake_move_range":20,
    "owl_move_range":20,
    "krat_movement_frequency_per_x_cycles":1, # once per cycle
    "snake_movement_frequency_per_x_cycles":8, # once per 8 cycles
    "owl_movement_frequency_per_x_cycles":1, # once per 8 cycles
    "owl_catch_success":0.21, #from bouskila
    "move_preference_algorithm":False,
    "memory_length_krat":20,
    "memory_length_snake":20,
    "krat_mutation_std":0.15,
    "snake_mutation_std":0.15,
    "krat_mutation_probability":0.01,
    "snake_mutation_probability":0.01,
    "krat_reproduction_freq_per_x_cycles": 50,
    "snake_reproduction_freq_per_x_cycles": 50,
    "mixed_preference_individuals": False
    # 1000 reproduction events
    }

experimental_groups = {
    "control" : control_group,
    "experiment_1": experimental_group_1,
    "experiment_2": experimental_group_2,
    "experiment_3": experimental_group_3,
}
def main(experimental_groups):
    with open('owl_exp.txt', 'w') as outfile:
        json.dump(experimental_groups, outfile)

if __name__ ==  "__main__":
    main(experimental_groups)