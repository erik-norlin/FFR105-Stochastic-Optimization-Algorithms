function nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta)

nNodes = height(visibility);
jNode = tabuList(end);
p = zeros(1,2);

sumDenominator = 0;
for iNode = 1:nNodes
    if ~ismember(iNode,tabuList)
        tauAlpha = pheromoneLevel(iNode,jNode)^alpha;
        etaBeta = visibility(iNode,jNode)^beta;
        sumDenominator = sumDenominator + tauAlpha*etaBeta;
    end
end

iNodeCounter = 0;
for iNode = 1:nNodes
    if ~ismember(iNode,tabuList)
        iNodeCounter = iNodeCounter + 1;
        tauAlpha = pheromoneLevel(iNode,jNode)^alpha;
        etaBeta = visibility(iNode,jNode)^beta;
        p(iNodeCounter,1) = (tauAlpha*etaBeta) / sumDenominator;
        p(iNodeCounter,2) = iNode;
    end
end

% Roulette wheel selection
pSorted = sortrows(p,1);
pProbs = pSorted(:,1);
pNodes = pSorted(:,2);
pRws = cumsum(pProbs);
r = rand;
winningPoint = find(r <= pRws, 1, "first");
nextNode = pNodes(winningPoint);