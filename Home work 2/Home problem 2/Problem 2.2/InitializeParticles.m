function particles = InitializeParticles(nParticles,xMax,xMin,alpha,deltaTime)

particles = zeros(nParticles,4);

for i = 1:nParticles
    
    r = rand;
    xPosition1 = xMin + r*(xMax - xMin);
    r = rand;
    velocity1 = (alpha/deltaTime)*(xMin + 2*r*xMax);
    
    r = rand;
    xPosition2 = xMin + r*(xMax - xMin);
    r = rand;
    velocity2 = (alpha/deltaTime)*(xMin + 2*r*xMax);
    
    particles(i,1) = xPosition1;
    particles(i,2) = xPosition2;
    particles(i,3) = velocity1;
    particles(i,4) = velocity2;
end

    
