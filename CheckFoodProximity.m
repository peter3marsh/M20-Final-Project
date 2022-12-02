function [food_sources, indicator] = CheckFoodProximity(x, y, food_sources, food_proximity_threshold)
%{
CheckFoodProximity returns the updated food_sources matrix and true/false 
for whether a food is close enough for an ant to pick it up.

outputs:
    food_sources: the (probably) updated matrix of food sources.
    indicator: true (logical 1) if the ant is close a food source, and 
               false (logical 0) if it's not.

inputs:
    x: the x coordinate of the ant
    y: the y coordinate of the ant
    food_sources: An N-by-2 matrix to indicate the locations of 
               food. Each row is a pair of (x, y) coordinate 
               to a food.
    food_proximity_threshold: The range to determine whether an ant is 
               close to the food enough to take it out.
%}

% Compute the distances from the ant to all the points of food
distances = zeros(1,length(food_sources));
for i = 1:length(food_sources)
    distance = sqrt(( x - food_sources(i,1) )^2 + ( y - food_sources(i,2) )^2);
    distances(1,i) = distance;
end

% Get the distance and the corresponding index of the closest point of food
% HINT: min() function can return multiple variables. Use the following:
% [min_value, min_index] = min(distances);
[min_value, min_index] = min(distances);

% If the closest distance is within the proximity threshold
%   Remove the closest food from the map
%   Return true (logical 1) for the indicator
if min_value <= food_proximity_threshold
    food_sources(min_index, :) = [];
    indicator = 1; 
% Else
%   Return false (logical 0) for the indicator
%   HINT: in this case, the food_sources variable is not changed.
else 
    indicator = 0;

end