function pathLength = GetPathLength(path,cityLocation)

STARTING_NODE = path(1);
X = 1;
Y = 2;

pathLength = 0;
nPaths = height(cityLocation) - 1;
for i = 1:nPaths
    from = path(i);
    to = path(i+1);
    pathLength = pathLength + sqrt((cityLocation(to,X) - cityLocation(from,X))^2 + (cityLocation(to,Y) - cityLocation(from,Y))^2); 
end
pathLength = pathLength + sqrt((cityLocation(STARTING_NODE,X) - cityLocation(end,X))^2 + (cityLocation(STARTING_NODE,Y) - cityLocation(end,Y))^2); 