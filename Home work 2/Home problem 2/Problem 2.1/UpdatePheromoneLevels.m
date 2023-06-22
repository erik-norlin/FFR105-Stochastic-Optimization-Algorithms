function  pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)

TOLERANCE = 10^-15;
nEdges = length(pheromoneLevel);
pheromoneLevel = (1-rho)*pheromoneLevel + deltaPheromoneLevel;

for i = 1:nEdges
   for j = nEdges
      if pheromoneLevel(i,j) < TOLERANCE
          pheromoneLevel(i,j) = TOLERANCE;
      end
   end
end