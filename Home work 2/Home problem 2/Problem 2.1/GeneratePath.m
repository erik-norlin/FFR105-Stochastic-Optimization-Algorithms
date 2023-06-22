function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

nNodes = height(visibility);
tabuList = [];
startNode = randi(nNodes);
tabuList(1) = startNode;

for i = 2:nNodes
   tabuList(i) = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta);
end
path = tabuList;