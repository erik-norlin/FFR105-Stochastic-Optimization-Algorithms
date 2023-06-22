% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)

ORGANIZE_POLYNOMIAL_ORDER = 1;

if derivativeOrder == 1 || derivativeOrder == 2
    for i = 1:derivativeOrder
        nCoefficients = length(polynomialCoefficients);
        for j = 1:nCoefficients
            polynomialOrder = j - 1;
            polynomialCoefficients(j) = polynomialCoefficients(j) * polynomialOrder;
            
            % Assigning an empty array to polynomialCoefficients if it's equal to zero to avoid error
            if polynomialCoefficients == 0 
                polynomialCoefficients = [];
                break
            end
        end
        
        % Getting rid of the first zero in polynomialCoefficients if it contains any values
        if ~isempty(polynomialCoefficients) 
            polynomialCoefficients(ORGANIZE_POLYNOMIAL_ORDER) = [];
        end
    end
    derivativeCoefficients = polynomialCoefficients;
elseif derivativeOrder == 0
    derivativeCoefficients = polynomialCoefficients;
else 
    derivativeCoefficients = [];
end

