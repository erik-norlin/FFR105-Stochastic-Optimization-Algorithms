X1_INDEX = 1;
X2_INDEX = 2;

nParticles = 40;
nVariables = 2;
inertiaTolerance = 0.35;
deltaTime = 1;
alpha = deltaTime;
beta = 0.99;
c1 = 2;
c2 = c1;

xMax = 5;
xMin = -5;
vMax = (xMax - xMin)/deltaTime;
vMin = -vMax;

% Plotting the objective function
x1 = linspace(-xMax,xMax);
x2 = linspace(-xMax,xMax);
[x1,x2] = meshgrid(x1,x2);
y = (x1.^2 + x2 - 11).^2 + (x1 + x2.^2 - 7).^2;
a = 0.01;
yLog = log(a + y);
contour(x1,x2,yLog)
xlabel("x")
ylabel("y")
xticks(-xMax:1:xMax)

% From plotting the objective function we know that there are 4 minima.
% Therefore we iterate over a while loop until the PSO has found all four
% of these.

nMinima = 4;
minima = [];
minimaCounter = 0;
nIterations = 200;
valid = false;

while ~valid
    
    inertiaWeight = 1.4;

    functionValues = zeros(nParticles,1);

    functionValuesPB = 1000.*ones(nParticles,1);
    positionsPB = zeros(nParticles,nVariables);

    functionValueSB = 1000;
    positionSB = zeros(1,nVariables);

    % Initializing swarm
    particles = InitializeParticles(nParticles,xMax,xMin,alpha,deltaTime);

    for i = 1:nIterations
    
        % Evaluating every particle
        for iParticle = 1:nParticles

            particle = particles(iParticle,:);
            functionValues(iParticle) = EvaluateParticle(particle);     

            if functionValues(iParticle) < functionValuesPB(iParticle)
                positionsPB(iParticle,:) = particle(1:2);
                functionValuesPB(iParticle) = functionValues(iParticle);
            end

            if functionValues(iParticle) < functionValueSB
                positionSB = particle(1:2);
                functionValueSB = functionValues(iParticle);
            end

            if inertiaWeight > inertiaTolerance
                inertiaWeight = inertiaWeight*beta;
            end
        end

        % Updating every particle
        for iParticle = 1:nParticles
            for iVariable = 1:nVariables

                xPosition = particles(iParticle,iVariable);
                xPositionPB = positionsPB(iParticle,iVariable);
                xPositionSB = positionSB(iVariable);

                iVelocity = iVariable+2;
                velocity = particles(iParticle,iVelocity);

                newPositionAndVelocity = UpdateParticle(xPosition,xPositionPB,xPositionSB,velocity,inertiaWeight,c1,c2,deltaTime,vMax,vMin);
                particles(iParticle,iVariable) = newPositionAndVelocity(1);
                particles(iParticle,iVelocity) = newPositionAndVelocity(2);

            end 
        end
    end
    
    % Storing minima and breaks out of main loop if 4 different minima are found
    if ~ismember(positionSB,minima)
        newMinima = [positionSB,functionValueSB];
        minima = [minima;newMinima];
        minimaCounter = minimaCounter + 1;
        if minimaCounter == nMinima
            valid = true;
        end
    end
end

% Plotting the obtained minima on top of the contour plot
hold on
x1 = minima(:,X1_INDEX)';
x2 = minima(:,X2_INDEX)';
plot(x1,x2,"or","Linewidth",2);
legend("Contour of log(a+f(x,y))","Minima obtained from PSO")
