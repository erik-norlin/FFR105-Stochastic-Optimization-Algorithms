function newIndividuals = TwoPointCrossover(winner1,winner2,population,crossoverProb)

newIndividuals = [];

r = rand;
if r < crossoverProb
    
    chromosome1 = population(winner1).Chromosome;
    chromosome2 = population(winner2).Chromosome;
    lengthChromosome1 = length(chromosome1);
    lengthChromosome2 = length(chromosome2);
    chromosomeLength = [lengthChromosome1,lengthChromosome2];
    crossoverPoints = [];
    
    for i = 1:2
        valid = false;
        while ~valid
            r1 = randi(chromosomeLength(i));
            r2 = randi(chromosomeLength(i));
            if mod(r1,4) == 0 && mod(r2,4) == 0 && r1 ~= r2
                if r1 > r2
                    temp = r1;
                    r1 = r2;
                    r2 = temp;
                end
                crossoverPoints(i,:) = [r1,r2];
                valid = true;
            end
        end
    end
    
    chromosome1_crossPoint1 = crossoverPoints(1,1);
    chromosome1_crossPoint2 = crossoverPoints(1,2);
    chromosome2_crossPoint1 = crossoverPoints(2,1);
    chromosome2_crossPoint2 = crossoverPoints(2,2);
    
    length1 = chromosome1(1:chromosome1_crossPoint1);
    length2 = chromosome2(chromosome2_crossPoint1+1:chromosome2_crossPoint2);
    if chromosome1_crossPoint2 < chromosomeLength(1)
        length3 = chromosome1(chromosome1_crossPoint2+1:end);
    else
        length3 = [];
    end
    newIndividual1 = [length1,length2,length3];
    
    length1 = chromosome2(1:chromosome2_crossPoint1);
    length2 = chromosome1(chromosome1_crossPoint1+1:chromosome1_crossPoint2);
    if chromosome2_crossPoint2 < chromosomeLength(2)
        length3 = chromosome2(chromosome2_crossPoint2+1:end);
    else
        length3 = [];
    end
    newIndividual2 = [length1,length2,length3];
    
else
    newIndividual1 = population(winner1).Chromosome;    
    newIndividual2 = population(winner2).Chromosome;
end

newIndividual1 = struct('Chromosome',newIndividual1);
newIndividual2 = struct('Chromosome',newIndividual2);
newIndividuals = [newIndividual1 newIndividual2];
