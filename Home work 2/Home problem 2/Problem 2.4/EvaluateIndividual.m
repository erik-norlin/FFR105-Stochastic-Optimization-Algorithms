function evaluation = EvaluateIndividual(chromosome,operatorSet,variableRegisters,constantRegisters,maxChromosomeLength,minChromosomeLength,test)

cMax = 10000000;
functionData = LoadFunctionData;
nPoints = height(functionData);
chromosomeLength = length(chromosome);
rootMeanSquareError = 0;

yApprox = zeros(1,nPoints);
yTrue = zeros(1,nPoints);
xPoints = zeros(1,nPoints);

% Decoding the chromosome and evaluating every point
for iPoint = 1:nPoints
    xPoints(iPoint) = functionData(iPoint,1);
    variableRegisters(1) = xPoints(iPoint);
    variableRegisters(2:end) = 0;
    allRegisters = [variableRegisters,constantRegisters];
    
    for iGene = 1:4:chromosomeLength
        
        operatorIndex = chromosome(iGene);
        destinationIndex = chromosome(iGene+1);
        operand1Index = chromosome(iGene+2);
        operand2Index = chromosome(iGene+3);
        
        operator = operatorSet(operatorIndex);
        operand1 = allRegisters(operand1Index);
        operand2 = allRegisters(operand2Index);
        
        if operator == 1
            destination = operand1 + operand2;
        elseif operator == 2
            destination = operand1 - operand2;
        elseif operator == 3
            destination = operand1 * operand2;
        elseif operator == 4
            if operand2 ~= 0
                destination = operand1 / operand2;
            else
                destination = cMax;
            end
        end
        
        allRegisters(destinationIndex) = destination;
        
    end
    
    yApprox(iPoint) = allRegisters(1);
    yTrue(iPoint) = functionData(iPoint,2);
    rootMeanSquareError = rootMeanSquareError + (yTrue(iPoint) - yApprox(iPoint))^2;
    
end

rootMeanSquareError = sqrt(rootMeanSquareError/nPoints);
fitness = 1/rootMeanSquareError;

if chromosomeLength < minChromosomeLength || chromosomeLength > maxChromosomeLength
    fitness = fitness/cMax;
end

if test == true
    rootMeanSquareErrorStruct = struct('Evaluation',rootMeanSquareError);
    xPointsStruct = struct('Evaluation',xPoints);
    yApproxStruct = struct('Evaluation',yApprox);
    yTrueStruct = struct('Evaluation',yTrue);
    evaluation = [rootMeanSquareErrorStruct xPointsStruct yApproxStruct yTrueStruct];
else
    evaluation = fitness;
end

