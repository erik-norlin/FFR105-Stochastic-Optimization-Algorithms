function chromosome = EncodeNetwork(wIH, wHO, wMax)

weightLengthIH = width(wIH)*height(wIH);
weightLengthHO = width(wHO)*height(wHO);
chromosomeLength = weightLengthIH + weightLengthHO;
chromosome = zeros(1,chromosomeLength);

% Rescaling weights and biases to genes in the range [0,1]
nRows = height(wIH);
nCols = width(wIH);
iGene = 1;
for i = 1:nRows
    for j = 1:nCols
        chromosome(iGene) = (wIH(i,j) + wMax)/(2*wMax);
        iGene = iGene + 1;
    end
end

nRows = height(wHO);
nCols = width(wHO);
iGene = weightLengthIH;
for i= 1:nRows
    for j = 1:nCols
        iGene = iGene + 1;
        chromosome(iGene) = (wHO(i,j) + wMax)/(2*wMax);
    end
end