function mutatedIndividual = Mutate(chromosome, mutationProb, creepProb, creepRate)

chromosomeLength = length(chromosome);
mutatedIndividual = chromosome;

for i = 1:chromosomeLength
    r = rand;
    if r < mutationProb
        % Using creep mutation due to real number encoding
        r = rand;
        if r < creepProb
            mutatedIndividual(i) = mutatedIndividual(i) - creepRate/2 + creepRate*r;
        else
            mutatedIndividual(i) = r;
        end
    end
end