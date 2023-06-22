function functionValue = EvaluateParticle(particle)

X1_INDEX = 1;
X2_INDEX = 2;
x1 = particle(X1_INDEX);
x2 = particle(X2_INDEX);
functionValue = (x1^2 + x2 -11)^2 + (x1 + x2^2 - 7)^2;