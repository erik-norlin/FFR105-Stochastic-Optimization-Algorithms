function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);

MOST_FIT = 1;
FITNESS = 1;
INDIVIDUAL = 2;

populationSize = length(fitnessList);
tourFitnessAndIndividual = zeros(tournamentSize,2);

for i = 1:tournamentSize
    iTmp = 1 + fix(rand*populationSize);
    tourFitnessAndIndividual(i,FITNESS) = fitnessList(iTmp);
    tourFitnessAndIndividual(i,2) = iTmp;
end

tourFitnessAndIndividual = sortrows(tourFitnessAndIndividual, 'descend');

while true
    r = rand;
    if r < tournamentProbability
        selectedIndividualIndex = tourFitnessAndIndividual(MOST_FIT,INDIVIDUAL);
        return
    else
        % If number of participants left are more than one, otherwise 
        % choosing last individual as the "winner"
        remainingParticipants = height(tourFitnessAndIndividual);
        if remainingParticipants > 1
            tourFitnessAndIndividual(MOST_FIT,:) = [];
        else
            selectedIndividualIndex = tourFitnessAndIndividual(MOST_FIT,INDIVIDUAL);
            return
        end
    end
end