function fitness = EvaluateIndividual(wIH, wHO, iSlope, iDataSet, plotResult)

horizontalDistance = 0;
startVelocity = 20;
velocity = startVelocity;
minVelocity = 1;
maxVelocity = 25;
gear = 7;
tempB = 500;
tempAmb = 283;
tempMax = 750;
tau = 30;
constantH = 40;
alphaMax = 10; 
deltaTime = 0.1;
deltaTimeInt = 1; % 1 represents 0.1 sec
timeCounter = 20;
gearTimeConstraintInt = 20; % 20 represents 2 sec
slopeLength = 1000;

alphaList = [];
pressureList = [];
gearList = [];
velocityList = [];
tempBList = [];
horizontalDistanceList = [];
horizontalDistanceGearList = [];

i = 0;
valid = false;
while ~valid
    i = i + 1;

    % Evaluating neural network for current iteration
    alpha = GetSlopeAngle(horizontalDistance, iSlope, iDataSet);
    alphaInput = alpha/alphaMax;
    velocityInput = velocity/maxVelocity;
    tempInput = tempB/tempMax;
    
    networkOutput = FeedForwardNeuralNetwork(alphaInput, velocityInput, tempInput, wIH, wHO);
    pressure = networkOutput(1);
    deltaGear = networkOutput(2);

    % Storing parameters of current iteration for plotting running RunTest.m
    alphaList = [alphaList alpha];
    pressureList = [pressureList pressure];
    gearList = [gearList gear];
    velocityList = [velocityList velocity];
    tempBList = [tempBList tempB];
    horizontalDistanceList = [horizontalDistanceList horizontalDistance];
    horizontalDistanceGearList = [horizontalDistanceGearList horizontalDistance];
    
    % Updating parameters for the next iteration
    if mod(timeCounter,gearTimeConstraintInt) == 0
        gear = gear + deltaGear;
        if gear > 10
            gear = 10;
        elseif gear < 1
            gear = 1;
        end
        timeCounter = 0;
        gearList = [gearList gear];
        horizontalDistanceGearList = [horizontalDistanceGearList horizontalDistance];
    end
    timeCounter = timeCounter + deltaTimeInt;

    velocity = TruckModel(pressure, tempB, tempMax, alpha, gear, deltaTime, velocity);
    
    deltaTempB = tempB - tempAmb;
    if pressure < 0.01
        dDeltaTempB = -deltaTempB/tau;
    else
        dDeltaTempB = constantH*pressure;
    end
    
    newDeltaTempB = deltaTempB + dDeltaTempB*deltaTime;
    tempB = newDeltaTempB + tempAmb;
    
    % Checking if the parameters fulfills the constraints
    if tempB > tempMax 
        valid = true;
    elseif velocity < minVelocity || velocity > maxVelocity
        valid = true;
    else
        if horizontalDistance >= slopeLength
            valid = true;
        else
            horizontalDistance = horizontalDistance + cosd(alpha)*velocity*deltaTime;
        end
    end
end

avgVelocity = sum(velocityList)/length(velocityList);
fitness = avgVelocity*horizontalDistance;

% Plot if this function is run from RunTest.m
if plotResult == true
    Plot(horizontalDistanceList, alphaList, pressureList, gearList, velocityList, tempBList, horizontalDistanceGearList)
end
