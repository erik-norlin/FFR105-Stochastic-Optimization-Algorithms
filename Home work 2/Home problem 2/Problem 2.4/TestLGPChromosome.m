clear all
clc

nVariableRegisters = 3;
operatorSet = [1,2,3,4]; % + - * /
constantRegisters = [1,3,-1,2];
variableRegisters = zeros(1,nVariableRegisters);
maxChromosomeLength = 150;
minChromosomeLength = 25;
test = true;
chromosome = load("BestChromosome.m");

evaluation = EvaluateIndividual(chromosome,operatorSet,variableRegisters,constantRegisters,maxChromosomeLength,minChromosomeLength,test);
rootMeanSquareError = evaluation(1).Evaluation;
rootMeanSquareErrorPercent = rootMeanSquareError*100;
xPoints = evaluation(2).Evaluation;
yApprox = evaluation(3).Evaluation;
yTrue = evaluation(4).Evaluation;

hold on
plot(xPoints,yTrue,"-","Linewidth",1.5);
plot(xPoints,yApprox,"--","Linewidth",1.5);
xlabel("x")
ylabel("y")
legend("g(x)","Approximation of g(x)")

functionEstimate = EstimateFunction(chromosome,operatorSet);
fprintf("Estimated function: %s\n", functionEstimate)
fprintf("Root mean square error: %.2f%%\n", rootMeanSquareErrorPercent)
