function population = InitializePopulation(populationSize, chromosomeLength)

population = zeros(populationSize,chromosomeLength);

for i = 1:populationSize
    for j = 1:chromosomeLength
        r = rand;
        population(i,j) = r;
    end
end