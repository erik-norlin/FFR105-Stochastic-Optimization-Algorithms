%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = 100;  %% Changes allowed
alpha = 3;        %% Changes allowed
beta = 4.5;         %% Changes allowed
rho = 0.11;          %% Changes allowed
tau0 = 0.08;         %% Changes allowed

targetPathLength = 99.9999999; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To do: Add plot initialization
range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0); 
visibility = GetVisibility(cityLocation);                         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;
pathCollection = zeros(numberOfAnts, numberOfCities);
pathLengthCollection = zeros(numberOfAnts,1);

while (minimumPathLength > targetPathLength)
 iIteration = iIteration + 1;

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Generate paths:
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 for k = 1:numberOfAnts
  path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   
  pathLength = GetPathLength(path,cityLocation);                  
  if (pathLength < minimumPathLength)
    bestPath = path;  
    minimumPathLength = pathLength;
    disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength));
    PlotPath(connection,cityLocation,path);
  end
  pathCollection(k,:) = path;  
  pathLengthCollection(k) = pathLength;
 end

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Update pheromone levels
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);  
 pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);          
end

fileID = fopen("BestResultFound.m","w");
fprintf(fileID, "%f ", bestPath);
fclose(fileID);
matlab.io.saveVariablesToScript("BestResultFound.m","bestPath")







