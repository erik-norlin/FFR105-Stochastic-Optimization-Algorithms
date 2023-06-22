nIn = 3;
nHidden= 4;
nOut = 2;
wMax = 5;
testSet = 3;
nTestSlopes = 5;

iDataSet = testSet;
iSlope = 2;

chromosome = load("BestChromosome.m");
[wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);

plot = true;
fitness = EvaluateIndividual(wIH, wHO, iSlope, iDataSet, plot);