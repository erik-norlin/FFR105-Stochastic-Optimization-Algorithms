function networkOutput = FeedForwardNeuralNetwork(alphaInput, velocityInput, tempInput, wIH, wHO)

c = 2;
inputNeurons = [alphaInput;velocityInput;tempInput];
nInputNeurons = height(inputNeurons);
nHiddenNeurons = height(wIH);
nOutputNeurons = height(wHO);
hiddenNeurons = zeros(nHiddenNeurons,1);
ouputNeurons = zeros(nOutputNeurons,1);

for jNeuron = 1:nHiddenNeurons
    weight = wIH(jNeuron,1:nInputNeurons);
    bias = wIH(jNeuron,end);
    localField = weight*inputNeurons - bias;
    hiddenNeurons(jNeuron,1) = 1/(1 + exp(-c*localField));
end

for iNeuron = 1:nOutputNeurons
    weight = wHO(iNeuron,1:nHiddenNeurons);
    bias = wHO(iNeuron,end);
    localField = weight*hiddenNeurons - bias;
    ouputNeurons(iNeuron,1) = 1/(1 + exp(-c*localField));
end

pressure = ouputNeurons(1);
deltaGear = ouputNeurons(2);
if deltaGear > 2/3
    deltaGear = 1;
elseif deltaGear < 1/3
    deltaGear = -1;
else
    deltaGear = 0;
end
networkOutput = [pressure deltaGear];
