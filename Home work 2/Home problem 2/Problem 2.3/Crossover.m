function newIndividuals = Crossover(chromosome1, chromosome2)

chromosomeLength = length(chromosome1);
crossoverPoint = 1 + fix(rand*(chromosomeLength - 1));
newIndividuals = zeros(2,chromosomeLength);

for j = 1:chromosomeLength
    if j <= crossoverPoint
        newIndividuals(1,j) = chromosome1(j);
        newIndividuals(2,j) = chromosome2(j);
    else
        newIndividuals(1,j) = chromosome2(j);
        newIndividuals(2,j) = chromosome1(j);
    end
end