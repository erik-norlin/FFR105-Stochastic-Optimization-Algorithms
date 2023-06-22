function visibility = GetVisibility(cityLocation)

nNodes = height(cityLocation);
visibility = zeros(nNodes);

for i = 1:nNodes
    for j = 1:nNodes
        visibility(i,j) = sqrt((cityLocation(i,1) - cityLocation(j,1))^2 + (cityLocation(i,2) - cityLocation(j,2))^2); 
        if visibility(i,j) ~= 0 
            visibility(i,j) = 1 / visibility(i,j);
        end
    end
end
