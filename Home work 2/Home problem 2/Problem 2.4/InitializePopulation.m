function population = InitializePopulation(populationSize,maxChromosomeLength,minChromosomeLength,operatorSet,variableRegisters,allRegisters)

OPERATOR = 1;
DESTINATION = 2;
OPERAND_1 = 3;
OPERAND_2 = 4;
NUMBER_OF_INSTRUCTION_VARIABLES = 4;

population = [];
nOperators = length(operatorSet);
nRegisters = length(allRegisters);
nVariableRegisters = length(variableRegisters);

for i = 1:populationSize
    
    valid = false;
    while ~valid 
        chromosomeLength = minChromosomeLength + fix(rand*(maxChromosomeLength-minChromosomeLength+1));
        if mod(chromosomeLength,NUMBER_OF_INSTRUCTION_VARIABLES) == 0
            valid = true;
        end
    end
    
    nInstructions = chromosomeLength/NUMBER_OF_INSTRUCTION_VARIABLES;
    tmpChromosome = zeros(NUMBER_OF_INSTRUCTION_VARIABLES,nInstructions);
    
    for j = 1:nInstructions
        tmpChromosome(OPERATOR,j) = randi(nOperators); 
    end
    
    for j = 1:nInstructions
        tmpChromosome(DESTINATION,j) = randi(nVariableRegisters);
    end
    
    for j = 1:nInstructions
        tmpChromosome(OPERAND_1,j) = randi(nRegisters);
        tmpChromosome(OPERAND_2,j) = randi(nRegisters);
    end
    
    chromosome = zeros(1,chromosomeLength);
    for j = 1:chromosomeLength
        chromosome(j) = tmpChromosome(j);
    end
    individual = struct('Chromosome',chromosome);
    population = [population individual];
    
end

