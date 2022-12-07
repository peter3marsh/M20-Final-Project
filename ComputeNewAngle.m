function [angle] = ComputeNewAngle(x, y, ant_angle, pheromones, concentration, r_smell, sigma_1, sigma_2)
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
if isempty(pheromones)
    angle = ant_angle + normrnd(0,sigma_2);
    return
end

% Compute the pheromone positions relative to the ant and the corresponding
% distances (distance between a point of pheromone and the ant)
relative_pheromones(:,1) = pheromones(:,1) - x; 
relative_pheromones(:,2) = pheromones(:,2) - y;
distances = sqrt(sum(relative_pheromones.^2,2));

% Compute the pheromone angles with respect to the x axis in the range of 
% [0, 2*pi]
% HINT: Instead of using atan(), which returns an angle between –pi/2 and
%       pi/2, use atan2(), which returns an angle between –pi and pi, so 
%       that the returned angle covers 360 degrees.
% HINT 2: atan2() returns an angle between –pi and pi. However, we need
%         angles between 0 and 2pi. To do so, use the mod() function with 
%         2pi as the divisor to make sure all the angles would be within 
%         the range.
relative_angles = mod(atan2(relative_pheromones(:,2), relative_pheromones(:,1)), 2*pi);

% Filter out the points of pheromone that are not within the region that 
% the ant can sense. A effective point of pheromone for the ant is:
% 1. in front of the ant. I.e., the angle between the point of pheromone 
%    and the orientation of the ant is within pi/2.
% 2. the distance between the point of pheromone and the ant is smaller 
%    than r_smell.
mask = distances<r_smell & abs(relative_angles-ant_angle) < pi/2;
valid_pheromones = relative_pheromones(mask, :);
valid_concentrations = concentration(mask);

if isempty(valid_pheromones)
    angle = ant_angle + normrnd(0,sigma_2);
    return
end

valid_pheromones(:,1) = valid_pheromones(:,1) .* valid_concentrations';
valid_pheromones(:,2) = valid_pheromones(:,2) .* valid_concentrations';

m = mean(valid_pheromones,1);
angle = mod(atan2(m(2), m(1)), 2*pi) + normrnd(0,sigma_1);
end
