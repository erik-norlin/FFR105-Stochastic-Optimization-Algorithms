clear all
clc

nFFNNs = 10;
nIn = 3;
nHidden = 8;
nOut = 2;
wMax = 5;
chromosomeLength = (nIn+1)*nHidden + (nHidden+1)*nOut;
mutationProb = 1/chromosomeLength;
creepProb = 0.8;
creepRate = 0.5;
creepDecay = 0.999;
crossoverProb = 0.8;
trainingSet = 1;
validationSet = 2;
nTrainingSlopes = 10;
nValidationSlopes = 5;
tournamentProbability = 0.75;
tournamentSize = 4;

bestFitnessTraining = zeros(1,2);
bestFitnessValidation = zeros(1,2);
fitnessListTraning = zeros(nFFNNs,1);
bestFitnessTrainingList = [];
fitnessListValidation = zeros(nFFNNs,1);
bestFitnessValidationList = [];
bestValidationFitnessEver = 0;
population = InitializePopulation(nFFNNs,chromosomeLength);

validationCounter = 0;
trainedCritera = 200;
trained = false;
iterations = 0;
nGenerationsList = [];

while ~trained
    
    iterations = iterations + 1;
    nGenerationsList = [nGenerationsList iterations];
    maxFitnessTraining = 0;
    maxFitnessValidation = 0;
    
    % Evaluation
    for individual = 1:nFFNNs
        
        chromosome = population(individual,:);
        [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
        
        % Evaluating training set
        
        % Averaging fitness
        totalFitness = 0;
        for iSlope = 1:nTrainingSlopes
            iDataSet = trainingSet;
            plotResult = false;
            totalFitness = totalFitness + EvaluateIndividual(wIH, wHO, iSlope, iDataSet, plotResult);
        end
        fitnessListTraning(individual) = totalFitness/nTrainingSlopes;

        % Elitism
        if fitnessListTraning(individual) > maxFitnessTraining 
            maxFitnessTraining = fitnessListTraning(individual);
            bestFitnessTraining(1) = maxFitnessTraining;
            bestFitnessTraining(2) = individual;
            bestChromosomeSoFar = chromosome;
        end
        
        % Evaluating validation set
        
        % Averaging fitness
        totalFitness = 0;
        for iSlope = 1:nValidationSlopes
            iDataSet = validationSet;
            plotResult = false;
            totalFitness = totalFitness + EvaluateIndividual(wIH, wHO, iSlope, iDataSet, plotResult);
        end
        fitnessListValidation(individual) = totalFitness/nValidationSlopes;
        
        % Elitism
        if fitnessListValidation(individual) > maxFitnessValidation
            maxFitnessValidation = fitnessListValidation(individual);
            bestFitnessValidation(1) = maxFitnessValidation;
            bestFitnessValidation(2) = individual;

            if fitnessListValidation(individual) > bestValidationFitnessEver
                bestValidationFitnessEver = fitnessListValidation(individual);
            end
        end
    end        
    
    bestFitnessTrainingList = [bestFitnessTrainingList maxFitnessTraining];
    bestFitnessValidationList = [bestFitnessValidationList maxFitnessValidation];
    
    % Calculating how many generations have passed since the maximal validation fitness got better

    if max(bestFitnessValidationList) > bestValidationFitnessEver
        validationCounter = 0;
    else
        validationCounter = validationCounter + 1
    end

    % If the maximal validation fitness hasn't gotten better for an arbitary number of generations
    if validationCounter >= trainedCritera
        trained = true;
    end
    
    if trained == false
        
        % Crossover
        tmpPopulation = population;  
        for i = 1:2:nFFNNs
            winner1 = TournamentSelect(fitnessListTraning, tournamentProbability, tournamentSize);
            winner2 = TournamentSelect(fitnessListTraning, tournamentProbability, tournamentSize);
            r = rand;
            if r < crossoverProb
                chromosome1 = population(winner1,:);
                chromosome2 = population(winner2,:);
                newIndividuals = Crossover(chromosome1, chromosome2);
                tmpPopulation(i,:) = newIndividuals(1,:);
                tmpPopulation(i+1,:) = newIndividuals(2,:);
            else
                tmpPopulation(i,:) = population(winner1,:);
                tmpPopulation(i+1,:) = population(winner2,:);     
            end
        end

        % Elitism
        bestIndividual = bestFitnessTraining(2);
        tmpPopulation(1,:) = population(bestIndividual,:);

        % Mutation
        for i = 2:nFFNNs
            chromosome = tmpPopulation(i,:);
            tempIndividual = Mutate(chromosome,mutationProb,creepProb,creepRate);
            tmpPopulation(i,:) = tempIndividual;
        end
        
        % Favouring exploration in the beginning and exploitation as time goes
        if creepRate > 0.005
            creepRate = creepRate*creepDecay;
        end

        % Overwriting previous generation
        population = tmpPopulation;
    end
end

hold on
plot(nGenerationsList,bestFitnessTrainingList,".-","LineWidth", 1.5)
plot(nGenerationsList,bestFitnessValidationList,".-","LineWidth", 1.5)
xlabel("Generation")
ylabel("Fitness value")
legend("Fitness training set","Fitness validation set",'Location','northwest')
hold off

fprintf("iterations: %d", iterations)
bestChromosome = bestChromosomeSoFar;
fileID = fopen("BestChromosome.m","w");
fprintf(fileID, "%f ", bestChromosome);
fclose(fileID);
