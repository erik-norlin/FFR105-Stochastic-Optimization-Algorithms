%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...

mutationProbability = [0.0, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.2, 0.3, 0.4, 0.5];
nMutationProbabilities = length(mutationProbability);
maximumFitnessList = zeros(numberOfRuns,nMutationProbabilities);

for i = 1:nMutationProbabilities
    sprintf('Mutation rate = %0.5f', mutationProbability(i))
    for j = 1:numberOfRuns 
     [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability(i), numberOfGenerations);
     sprintf('Run: %d, Score: %0.10f', j, maximumFitness)
     maximumFitnessList(j,i) = maximumFitness;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...
average = zeros(1,nMutationProbabilities);
medianPerformance = zeros(1,nMutationProbabilities);
std = zeros(1,nMutationProbabilities);

for i = 1:nMutationProbabilities
    average(i) = mean(maximumFitnessList(:,i));
    medianPerformance(i) = median(maximumFitnessList(:,i));
    std(i) = sqrt(var(maximumFitnessList(:,i)));
    sprintf('PMut = %.2f: Median: %0.10f, Average: %0.10f, STD: %0.10f', mutationProbability(i), medianPerformance(i), average(i), std(i))
end

% ... and here (pMut > 0.02)

figure
plot(mutationProbability, medianPerformance, "-", "LineWidth", 1.5);
xlabel("Mutation probability")
ylabel("Median performance")
grid on
 
