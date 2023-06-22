% nIn = the number of inputs
% nHidden = the number of hidden neurons
% nOut = the number of output neurons
% Weights (and biases) should take values in the range [-wMax,wMax]

function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);

wIH = zeros(nHidden,nIn+1);
wHO = zeros(nOut,nHidden+1);
weightLengthIH = width(wIH)*height(wIH);

% Rescaling genes to weights and biases in the range [-wMax,wMax]
nRows = height(wIH);
nCols = width(wIH);
iGene = 1;
for i = 1:nRows
    for j = 1:nCols
        wIH(i,j) = -wMax + 2*wMax*chromosome(iGene);
        iGene = iGene + 1;
    end
end

nRows = height(wHO);
nCols = width(wHO);
iGene = weightLengthIH + 1;
for i= 1:nRows
    for j = 1:nCols
        wHO(i,j) = -wMax + 2*wMax*chromosome(iGene);
        iGene = iGene + 1;
    end
end