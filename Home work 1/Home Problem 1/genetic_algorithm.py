import numpy as np

def tournament_select(fitness_list, tournament_probability, tournament_size):
    most_fit = 0
    fitness_index = 0
    individual_index = 1

    population_size = len(fitness_list)
    tour_fitness_and_individual = np.zeros((tournament_size, 2))

    for i in range(tournament_size):
        i_tmp = np.random.randint(0, population_size)
        tour_fitness_and_individual[i, fitness_index] = fitness_list[i_tmp]
        tour_fitness_and_individual[i, individual_index] = i_tmp

    tour_fitness_and_individual = tour_fitness_and_individual[tour_fitness_and_individual[:, fitness_index].argsort()[::-1]]

    while True:
        r = np.random.rand()
        if r < tournament_probability:
            selected_individual_index = int(tour_fitness_and_individual[most_fit, individual_index])
            return selected_individual_index
        else:
            remaining_participants = tour_fitness_and_individual.shape[0]
            if remaining_participants > 1:
                tour_fitness_and_individual = np.delete(tour_fitness_and_individual, most_fit, axis=0)
            else:
                selected_individual_index = int(tour_fitness_and_individual[most_fit, individual_index])
                return selected_individual_index


def crossover(individual1, individual2):
    n_genes = len(individual1)
    crossover_point = np.random.randint(1, n_genes)
    new_individuals = np.zeros((2, n_genes))

    for j in range(n_genes):
        if j < crossover_point:
            new_individuals[0, j] = individual1[j]
            new_individuals[1, j] = individual2[j]
        else:
            new_individuals[0, j] = individual2[j]
            new_individuals[1, j] = individual1[j]

    return new_individuals


def decode_chromosome(chromosome, number_of_variables, maximum_variable_value):
    x = np.zeros(number_of_variables)
    n_genes = len(chromosome)
    variable_length = int(np.floor(n_genes / number_of_variables))
    i_gene = 0

    for i in range(number_of_variables):
        x[i] = 0.0
        for j in range(variable_length):
            x[i] += 2**-j * chromosome[i_gene]
            i_gene += 1

        x[i] = -maximum_variable_value + (2 * maximum_variable_value * x[i]) / (1 - 2**-variable_length)

    return x


def evaluate_individual(x): # objective funtion
    g_numerator_1 = (1.5 - x[0] + x[0] * x[1])**2
    g_numerator_2 = (2.25 - x[0] + x[0] * x[1]**2)**2
    g_numerator_3 = (2.625 - x[0] + x[0] * x[1]**3)**2
    g = g_numerator_1 + g_numerator_2 + g_numerator_3

    fitness = 1 / (g + 1)
    return fitness


def initialize_population(population_size, number_of_genes):
    population = np.zeros((population_size, number_of_genes), dtype=int)

    for i in range(population_size):
        for j in range(number_of_genes):
            r = np.random.rand()
            if r < 0.5:
                population[i, j] = 0
            else:
                population[i, j] = 1

    return population


def mutate(individual, mutation_probability):
    n_genes = len(individual)
    mutated_individual = np.copy(individual)

    for i in range(n_genes):
        r = np.random.rand()
        if r < mutation_probability:
            mutated_individual[i] = 1 - individual[i]

    return mutated_individual



def run_function_optimization(population_size, number_of_genes, number_of_variables, maximum_variable_value,
                              tournament_size, tournament_probability, crossover_probability, mutation_probability,
                              number_of_generations):
    maximum_fitness = 0
    population = initialize_population(population_size, number_of_genes)

    for generation in range(number_of_generations):
        maximum_fitness = 0.0
        fitness_list = np.zeros(population_size)
        for i in range(population_size):
            chromosome = population[i, :]
            variable_values = decode_chromosome(chromosome, number_of_variables, maximum_variable_value)
            fitness_list[i] = evaluate_individual(variable_values)
            if fitness_list[i] > maximum_fitness:
                maximum_fitness = fitness_list[i]
                i_best_individual = i
                best_variable_values = variable_values

        temporary_population = population
        for i in range(0, population_size, 2):
            i1 = tournament_select(fitness_list, tournament_probability, tournament_size)
            i2 = tournament_select(fitness_list, tournament_probability, tournament_size)
            r = np.random.rand()
            if r < crossover_probability:
                individual1 = population[i1, :]
                individual2 = population[i2, :]
                new_individual_pair = crossover(individual1, individual2)
                temporary_population[i, :] = new_individual_pair[0, :]
                temporary_population[i+1, :] = new_individual_pair[1, :]
            else:
                temporary_population[i, :] = population[i1, :]
                temporary_population[i+1, :] = population[i2, :]

        temporary_population[0, :] = population[i_best_individual, :]
        for i in range(1, population_size):
            temp_individual = mutate(temporary_population[i, :], mutation_probability)
            temporary_population[i, :] = temp_individual

        population = temporary_population

    return maximum_fitness, best_variable_values


population_size = 100
maximum_variable_value = 5
number_of_genes = 50
number_of_variables = 2

tournament_size = 3
tournament_probability = 0.782
crossover_probability = 0.8
mutation_probability = 0.02
number_of_generations = 2000

# Run optimization
maximum_fitness, best_variable_values = run_function_optimization(
    population_size, number_of_genes, number_of_variables, maximum_variable_value,
    tournament_size, tournament_probability, crossover_probability, mutation_probability,
    number_of_generations
)
