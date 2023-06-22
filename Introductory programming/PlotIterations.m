% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)

X_INDEX = 1;
Y_INDEX = 2;
MARGIN = 0.2;
NUMBER_OF_NODES = 100;

% Returning to Wrapper.m without a plot if f'' = 0
if isempty(iterationValues) 
    return
end

% Defining x and y values in order to plot the function f
xMin = min(iterationValues(:, X_INDEX));
xMax = max(iterationValues(:, X_INDEX));
xMinMargin = xMin - MARGIN;
xMaxMargin = xMax + MARGIN;

xNodes = linspace(xMinMargin, xMaxMargin, NUMBER_OF_NODES);
yNodes = zeros(NUMBER_OF_NODES, 1);
for iNode = 1:length(yNodes)
    yNodes(iNode) = GetPolynomialValue(xNodes(iNode), polynomialCoefficients);
end

% Plotting function f and iterationValues
hold on
plot(xNodes, yNodes, "-");
plot(iterationValues(:, X_INDEX), iterationValues(:, Y_INDEX), 'o');

