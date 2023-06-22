% This function should return the value of the polynomial f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.

function value = GetPolynomialValue(x, polynomialCoefficients)

nPolynomialOrders = length(polynomialCoefficients) - 1;
value = 0;
for iOrder = 0:nPolynomialOrders
    iArrIndex = iOrder + 1;
    value = value + polynomialCoefficients(iArrIndex) * x^iOrder;
end