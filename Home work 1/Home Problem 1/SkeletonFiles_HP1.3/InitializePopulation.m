function population = InitializePopulation(populationSize,numberOfGenes);

population = zeros(populationSize, numberOfGenes);

for i = 1:populationSize
    for j = 1:numberOfGenes
        r = rand;
        if r < 0.5
            population(i,j) = 0;
        else
            population(i,j) = 1;
        end
    end
end

