% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)

x = xStart;
while true
    gradF = ComputeGradient(x,mu);
    normL2 = sqrt(gradF(1)^2 + gradF(2)^2);
    if normL2 < gradientTolerance
        return
    end
    x = x - eta*gradF;
end