function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)

nAnts = height(pathCollection);
nEdges = width(pathCollection);
deltaPheromoneLevel = zeros(nEdges,nEdges);

for k = 1:nAnts
    for m = 1:nEdges-1
        j = pathCollection(k,m);
        i = pathCollection(k,m+1);
        deltaPheromoneLevel(i,j) = deltaPheromoneLevel(i,j) + 1/pathLengthCollection(k);
    end
end 