function [x_new, y_new, angle] = MovementValidationExecution(x, y, angle, speed, allowed, forbidden)
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
%}

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
