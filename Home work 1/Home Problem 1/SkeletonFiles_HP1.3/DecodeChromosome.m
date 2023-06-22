% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);

x = zeros(1,numberOfVariables);
nGenes = length(chromosome);
variableLength = fix(nGenes / numberOfVariables); % k = m/n
iGene = 1;

for i = 1:numberOfVariables

    x(i) = 0.0;
    for j = 1:variableLength
        x(i) = x(i) + 2^-j * chromosome(iGene);
        iGene = iGene + 1;
    end

    x(i) = -maximumVariableValue + ...
    (2*maximumVariableValue*x(i)) / (1 - 2^-variableLength);

end
    