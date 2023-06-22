function pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0)

pheromoneLevel = zeros(numberOfCities);
pheromoneLevel(:,:) = tau0;