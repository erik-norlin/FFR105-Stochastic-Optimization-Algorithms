% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)

FIRST_ORDER_DERIVATIVE = 1;
SECOND_ORDER_DERIVATIVE = 2;

% Differentiating f to f' and f''
fPrime = DifferentiatePolynomial(polynomialCoefficients, FIRST_ORDER_DERIVATIVE);
fDoublePrime = DifferentiatePolynomial(polynomialCoefficients, SECOND_ORDER_DERIVATIVE);

i = 1;
x = startingPoint;
iterationValues = [];

while true
    % Executing Newton-Raphsons method
    fPrimeValue = GetPolynomialValue(x, fPrime);
    fDoublePrimeValue = GetPolynomialValue(x, fDoublePrime);
    xNext = StepNewtonRaphson(x, fPrimeValue, fDoublePrimeValue);
    
    if isnan(xNext) % Returns to Wrapper.m if f'' is zero (zero division error)
        return
    end
    
    % Computing and storing vector of current iteration value
    fValue = GetPolynomialValue(x, polynomialCoefficients);
    iterationValues(i,:) = [x, fValue]; 
    
    % Checking for convergence
    if abs(xNext - x) < tolerance
        break
    end
    i = i + 1;
    x = xNext;
end