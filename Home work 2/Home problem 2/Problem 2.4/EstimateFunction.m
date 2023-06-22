function functionEstimate = EstimateFunction(chromosome,operatorSet)

cMax = "10000000";
constantRegisters = ["1" "3" "-1" "2"];
variableRegisters = ["x" "0" "0"];
allRegisters = [variableRegisters,constantRegisters];
chromosomeLength = length(chromosome);

% Decoding the chromosome and evaluating the function of x
for iGene = 1:4:chromosomeLength

    operatorIndex = chromosome(iGene);
    destinationIndex = chromosome(iGene+1);
    operand1Index = chromosome(iGene+2);
    operand2Index = chromosome(iGene+3);

    operator = operatorSet(operatorIndex);
    operand1 = allRegisters(operand1Index);
    operand2 = allRegisters(operand2Index);

    if operator == 1
        destination = "(" + operand1 + "+" + operand2 + ")";
    elseif operator == 2
        destination = "(" + operand1 + "-" + operand2 + ")";
    elseif operator == 3
        destination = "(" + operand1 + "*" + operand2 + ")";
    elseif operator == 4
        if operand2 ~= "0"
            destination = "(" + operand1 + "/" + operand2 + ")";
        else
            destination = "(" + cMax + ")";
        end
    end

    allRegisters(destinationIndex) = destination;

end

expression = str2sym(allRegisters(1));
functionEstimate = simplify(expression);
