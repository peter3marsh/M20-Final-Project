function [angle] = ComputeNewAngle(x, y, ant_angle, pheromones, ...
    concentration, r_smell, sigma_1, sigma_2)
%{
ComputeNewAngle computes the angle of the ant is going to orient in the 
next time step.

outputs:
    angle: the new angle of the ant

inputs:
                x: the x coordinate of the ant
                y: the y coordinate of the ant
        ant_angle: the current orientation of the ant
       pheromones: an N-by-2 matrix to indicate the locations of the 
                   pheromone on the map. Each row is a pair of (x, y) 
                   coordinate to a point of pheromone.
    concentration: an N-by-1 array to indicate the concentration of the 
                   pheromone. concentration(i) is the concertration of the 
                   pheromone corresponds to pheromones(i, :)
          r_smell: the radius that an ant can senses
          sigma_1: the standard deviation used to control the environment 
                   noise
          sigma_2: the standard deviation used to control the orientation 
                   for an ant if there is no pheromone
%}

% First, if there is no pheromone on the map, the angle of the ant is
% changed with only the normal random number controlled by sigma_2. This
% function then terminates and returns the angle.
% NOTE: This is very unlikely to happen since the colony and the food are
%       both treated as strong pheromone to attract ants.
% HINT: To get a normal random number, use normrnd(mu, sigma).

% Compute the pheromone positions relative to the ant and the corresponding
% distances (distance between a point of pheromone and the ant)

% Compute the pheromone angles with respect to the x axis in the range of 
% [0, 2*pi]
% HINT: Instead of using atan(), which returns an angle between –pi/2 and
%       pi/2, use atan2(), which returns an angle between –pi and pi, so 
%       that the returned angle covers 360 degrees.
% HINT 2: atan2() returns an angle between –pi and pi. However, we need
%         angles between 0 and 2pi. To do so, use the mod() function with 
%         2pi as the divisor to make sure all the angles would be within 
%         the range.

% Filter out the points of pheromone that are not withing the region that 
% the ant can sense. A effective point of pheromone for the ant is:
% 1. in front of the ant. I.e., the angle between the point of pheromone 
%    and the orientation of the ant is within pi/2.
% 2. the distance between the point of pheromone and the ant is smaller 
%    than r_smell.

% If there is no effective pheromone, the angle of the ant is changed with 
% only the normal random number controlled by sigma_2. This function then 
% terminates and returns the angle.
% NOTE: The procedure is the same as the one when there is no pheromone on 
%       the map

% (UPDATED AFTER DISCUSSION ON NOV 23 TO AVOID CONFUSION)
% Compute the mean value of all the effective, relative pheromone positions 
% weighted by their concentration

% (UPDATED AFTER DISCUSSION ON NOV 23 TO AVOID CONFUSION)
% Compute the new angle the ant will face based on the mean value of all 
% the effective, relative pheromone positions.
% HINT: Use atan2() and mod() function again.
% HINT 2: This angle is affected by a normal random background noise 
%         controlled by sigma_1. Simply append this noise (angle) to the 
%         angle you computed before this function returns it.

end