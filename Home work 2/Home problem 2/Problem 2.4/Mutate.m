function mutatedIndividual = Mutate(chromosome,operatorSet,variableRegisters,allRegisters,mutationRate)

OPERATOR = 1;
DESTINATION = 2;
OPERAND_1 = 3;
OPERAND_2 = 4;
NUMBER_OF_INSTRUCTION_VARIABLES = 4;

chromosomeLength = length(chromosome);
mutationProb = (1/chromosomeLength)*mutationRate;
nOperators = length(operatorSet);
nVariableRegisters = length(variableRegisters);
nRegisters = length(allRegisters);

nInstructions = chromosomeLength/NUMBER_OF_INSTRUCTION_VARIABLES;
tempMutatedIndividual = zeros(NUMBER_OF_INSTRUCTION_VARIABLES,nInstructions);

for i = 1:chromosomeLength
    tempMutatedIndividual(i) = chromosome(i);
end

for i = 1:nInstructions
    r = rand;
    if r < mutationProb
        tempMutatedIndividual(OPERATOR,i) = randi(nOperators);
    end
end

for i = 1:nInstructions
    r = rand;
    if r < mutationProb
        tempMutatedIndividual(DESTINATION,i) = randi(nVariableRegisters);
    end
end

for i = 1:nInstructions
    r = rand;
    if r < mutationProb
        tempMutatedIndividual(OPERAND_1,i) = randi(nRegisters);
    end
    r = rand;
    if r < mutationProb
        tempMutatedIndividual(OPERAND_2,i) = randi(nRegisters);
    end
end

mutatedIndividual = zeros(1,chromosomeLength);
for i = 1:chromosomeLength
    mutatedIndividual(i) = tempMutatedIndividual(i);
end

mutatedIndividual = struct('Chromosome',mutatedIndividual);