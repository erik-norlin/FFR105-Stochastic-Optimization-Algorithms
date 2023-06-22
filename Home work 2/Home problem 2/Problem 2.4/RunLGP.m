clear all
clc

nGenerations = 3000000;
populationSize = 100;
maxChromosomeLength = 150;
minChromosomeLength = 25;
tournamentProbability = 0.75;
tournamentSize = 5;
crossoverProb = 0.8;
mutationRate = 80;
mutationDecay = 0.9999;

nVariableRegisters = 3;
operatorSet = [1,2,3,4]; % + - * /
constantRegisters = [1,3,-1,2];
variableRegisters = zeros(1,nVariableRegisters);
allRegisters = [variableRegisters,constantRegisters];

fitnessList = zeros(populationSize,1);
bestFitness = zeros(1,2);

% Initialization
population = InitializePopulation(populationSize,maxChromosomeLength,minChromosomeLength,operatorSet,variableRegisters,allRegisters);

for iGeneration = 1:nGenerations
    
    % Evaluation
    maxFitness = 0;
    for individual = 1:populationSize
        
        chromosome = population(individual).Chromosome;
        test = false;
        fitnessList(individual) = EvaluateIndividual(chromosome,operatorSet,variableRegisters,constantRegisters,maxChromosomeLength,minChromosomeLength,test);
        
        % Elitism
        if fitnessList(individual) > maxFitness
            maxFitness = fitnessList(individual);
            bestFitness(1) = maxFitness;
            bestFitness(2) = individual;
        end
    end
    
    
    tempPopulation = [];
    
    % Tournamnet selection
    for individual = 1:2:populationSize
        winner1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        winner2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
        
        % Two-point crossover 
        newIndividuals = TwoPointCrossover(winner1,winner2,population,crossoverProb);
        tempPopulation = [tempPopulation newIndividuals];

    end
    
    % Elitism
    bestIndividualIndex = bestFitness(2);
    bestIndividual = population(bestIndividualIndex);
    tempPopulation(1) = bestIndividual;
    
    % Mutation
    for i = 2:populationSize
        chromosome = tempPopulation(i).Chromosome;
        mutatedIndividual = Mutate(chromosome,operatorSet,variableRegisters,allRegisters,mutationRate);
        tempPopulation(i) = mutatedIndividual;
    end
    
    % Favouring exploration in the beginning and exploitation as time goes
    if mutationRate > 1
        mutationRate = mutationRate*mutationDecay;
    end
    
    % Overwriting old generation
    population = tempPopulation;
    
    % Saving file every 1000 generations
    if mod(iGeneration,1000) == 0
        bestChromosome = population(1).Chromosome;
        fileID = fopen("BestChromosome.m","w");
        fprintf(fileID, "%f ", bestChromosome);
        fclose(fileID);
        disp(iGeneration)
        e = 1/maxFitness;
        fprintf("RMS: %f",e);
    end
end

sort = sortrows(fitnessList, "descend");
bestChromosome = population(1).Chromosome;
fileID = fopen("BestChromosome.m","w");
fprintf(fileID, "%f ", bestChromosome);
fclose(fileID);