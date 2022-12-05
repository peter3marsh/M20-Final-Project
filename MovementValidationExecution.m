function [x_new, y_new, angle] = MovementValidationExecution(x, y, angle, speed, allowed)
%{
MovementValidationExecution returns new location and the orientation of an
ant.
If the new location is valid, return the new location and angle. If not, 
keep the current location and reverse the orientation of the ant.

outputs:
    x_new: new x coordinate of the ant
    y_new: new y coordinate of the ant
    angle: new angle of the ant

inputs:
            x: the x coordinate of the ant
            y: the y coordinate of the ant
        angle: the planned orientation of the ant for the next step
        speed: the distance that an ant can move in a time step
      allowed: A 1-by-4 array to indicate the size of the map. The first 
               two elements are (x, y) of the bottom-left corner of the 
               map, and the last two are (x, y) of the top-right corner.
    forbidden: An N-by-4 matrix to indicate the size of the wall. For each 
               row, the first two elements are (x, y) of the bottom-left 
               corner of the wall, and the last two are (x, y) of the 
               top-right corner.
. . .
. x .
. . . 

8 possible moves
360/8 = 45
right point from x is -22.5 to 22.5 deg
each other point 45 deg window

%}

%Check to make sure angle is good
valid = false;
while valid == false
    if angle < 0
        angle = angle + 2*pi;
    elseif angle > 2*pi
        angle = angle - 2*pi;
    else
        valid = true;
    end
end


% find new location
if (angle <= pi/8) || (angle > 15*pi/8)
    x_new = x+speed;
    y_new = y;
elseif (angle <= 3*pi/8) && (angle > pi/8)
    x_new = x+speed;
    y_new = y+speed;
elseif (angle <= 5*pi/8) && (angle > 3*pi/8)
    x_new = x;
    y_new = y+speed;
elseif (angle <= 7*pi/8) && (angle > 5*pi/8)
    x_new = x-speed;
    y_new = y+speed;
elseif (angle <= 9*pi/8) && (angle > 7*pi/8)
    x_new = x-speed;
    y_new = y;
elseif (angle <= 11*pi/8) && (angle > 9*pi/8)
    x_new = x-speed;
    y_new = y-speed;
elseif (angle <= 13*pi/8) && (angle > 11*pi/8)
    x_new = x;
    y_new = y-speed;
elseif (angle <= 15*pi/8) && (angle > 13*pi/8)
    x_new = x+speed;
    y_new = y-speed;
else
    error("rip");
end

% Make sure new location is valid
if (x_new < allowed(1)) || (y_new < allowed(2)) || (x_new > allowed(3)) || (y_new > allowed(4))
    x_new = x;
    y_new = y;
    angle = angle+pi;
else
    angle = ComputeNewAngle(x_new, y_new, angle, pheromones, concentration, r_smell, sigma_1, sigma_2);
end
return;
% First, compute the new location that we are going to validate

% Check whether the new location is within the map (allowed)
% If it's not within the map, the new location is invalid

% Check whether the new location is within the walls (forbidden, extra 
% credit)
% If it's within the walls, the new location is invalid
% HINT: Before you do the extra credit problem, you can pass an empty array
% [] to this function for the `forbidden` variable.

% If the new location is within the map and is not within the walls, the
% new location is valid and the new location and angle are returned.
% (Else) if the new location is invalid, return the current location and 
% reversed orientation.

end
