function [pheromones, concentration] = PheromonesUpdate(pheromones, concentration, decay)
%{
PheromonesUpdate returns the updated pheromones matrix and concentration 
array.

outputs:
    pheromones: the updated pheromones matrix
    concentration: the updated concentration matrix

inputs:
   pheromones: an N-by-2 matrix to indicate the locations of the pheromone 
               on the map. Each row is a pair of (x, y) coordinate to a 
               point of pheromone.
concentration: an N-by-1 array to indicate the concentration of the 
               pheromone. concentration(i) is the concentration of the 
               pheromone corresponds to pheromones(i, :)
        decay: the decay amount of pheromone after a time step
%}

for i=1:length(concentration)
    concentration(i) = concentration(i)-decay;
    if concentration(i) < 0
        pheromones(i,:) = [];
    end
end
concentration(concentration < 0) = [];

% Compute the new concentration (with decay)

% Eliminate points of pheromone that the corresponding concentration are
% less than 0.
% HINT: You can take advantage of logical indexing to get the slice quickly

% Eliminate the elements in `concentration` that are less than or equal to
% zero.
% HINT: Again, logical indexing is your good friend.

end