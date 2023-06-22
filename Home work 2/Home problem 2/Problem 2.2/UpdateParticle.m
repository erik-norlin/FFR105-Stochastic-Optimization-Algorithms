function newPositionAndVelocity = UpdateParticle(xPosition,xPositionPB,xPositionSB,velocity,inertiaWeight,c1,c2,deltaTime,vMax,vMin)

q = rand;
r = rand;

velocityNew = inertiaWeight*velocity + c1*q*((xPositionPB - xPosition)/deltaTime) + c2*r*((xPositionSB - xPosition)/deltaTime);
            
if velocityNew > vMax
    velocityNew = vMax;
elseif velocityNew < vMin
    velocityNew = vMin;
end

xPositionNew = xPosition + velocityNew*deltaTime;

newPositionAndVelocity = [xPositionNew,velocityNew];