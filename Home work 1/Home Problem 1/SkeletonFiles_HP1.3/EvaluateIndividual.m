% First compute the function value, then compute the fitness
% value; see also the problem formulation.

function fitness = EvaluateIndividual(x);

gNumerator1 = (1.5 - x(1) + x(1)*x(2))^2;
gNumerator2 = (2.25 - x(1) + x(1)*x(2)^2)^2;
gNumerator3 = (2.625 - x(1) + x(1)*x(2)^3)^2; 
g = gNumerator1 + gNumerator2 + gNumerator3;

fitness = (g + 1)^-1;