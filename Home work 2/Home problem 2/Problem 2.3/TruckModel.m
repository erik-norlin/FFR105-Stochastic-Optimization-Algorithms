function newVelocity = TruckModel(pressure, tempB, tempMax, alpha, gear, deltaTime, currentVelocity)

mass = 20000;
gravity = 9.82;
constantB = 3000;

forceEngineBrakes = [
    7*constantB
    5*constantB
    4*constantB
    3*constantB
    2.5*constantB
    2*constantB
    1.6*constantB
    1.4*constantB
    1.2*constantB
    constantB];

forceGravity = mass*gravity*sind(alpha);

if tempB < tempMax - 100
    forceBrakes = (1/20)*mass*gravity*pressure;
else
    forceBrakes = (1/20)*mass*gravity*pressure*exp(-(tempB-(tempMax-100))/100);
end

totalForce = forceGravity - forceBrakes - forceEngineBrakes(gear);
acceleration = totalForce/mass;
newVelocity = acceleration*deltaTime + currentVelocity;
