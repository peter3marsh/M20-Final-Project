% Cache clearing
% Assign the random seed using rng() based on your group number

% load the map (a given .mat file)
% NOTE: Load the .mat file would include the following parameters:
%                 colony_pos: The (x, y) of the colony center
% colony_proximity_threshold: The range to determine whether an ant is 
%                             close to colony enough to put down the food
%   food_proximity_threshold: The range to determine whether an ant is 
%                             close to the food enough to take it out
%               food_sources: An N-by-2 matrix to indicate the locations of 
%                             food. Each row is a pair of (x, y) coordinate 
%                             to a food.
%            map_coordinates: A 1-by-4 array to indicate the size of the 
%                             map. The first two elements are (x, y) of the 
%                             bottom-left corner of the map, and the last 
%                             two are (x, y) of the top-right corner.
%                     n_ants: The number of ants
%                          T: The number of time increments

% Tunable parameters. The allowed ranges for these parameters are:
% blue_decay: [0, 1]
%  red_decay: [0, 1]
%    r_smell: [0, 10]
%    sigma_1: [0, +Inf]
%    sigma_2: [0, +Inf]

% fixed parameters
ants_speed = 1;

% initialize the ants
% ants_angle: an n_ants-by-1 array cantaining random orientations for all ants
%  ants_xpos: an n_ants-by-1 array cantaining the x coordinates for all ants
%  ants_ypos: an n_ants-by-1 array cantaining the y coordinates for all ants
%  ants_food: an n_ants-by-1 boolean array to indicate whether the ant 
%             carries food or not

% initialize pheromones
%    blue_pheromones: an N-by-2 matrix to indicate the locations of the 
%                     blue pheromone on the map. Each row is a pair of 
%                     (x, y) coordinate to a point of pheromone.
%     red_pheromones: an N-by-2 matrix to indicate the locations of the red 
%                     pheromone on the map. Each row is a pair of (x, y) 
%                     coordinate to a point of pheromone.
% blue_concentration: an N-by-1 array to indicate the concentration of the 
%                     blue pheromone. concentration(i) is the concertration 
%                     of the pheromone corresponds to pheromones(i, :)
%  red_concentration: an N-by-1 array to indicate the concentration of the 
%                     red pheromone. concentration(i) is the concertration 
%                     of the pheromone corresponds to pheromones(i, :)

% initialize colony food counter variable

% open the video writing file
videoFile = VideoWriter('finalProject.mp4', 'MPEG-4'); % creates a file handler to the video writer
videoFile.FrameRate = 30;  % Set the video frame rate (30 is the default value)
open(videoFile) % open the video file to write data

% iterate over timestamps (i.e., for each timestamp...)
    % iterate over ants (i.e., for each ant...)
        % compute the new angle. 
        % This is where you should call ComputeNewAngle()
        
        % check movement validity. 
        % This is where you should call MovementValidationExecution()
        
        % update ant location and angle of the ant
        
        % if ant is not carrying food, 
            % Check the food proximity and grab food if it's close to a 
            % source. This is where you call CheckFoodProximity()
            % Leave blue pheromone
        % else, (the ant is carrying food)
            % Check the colony proximity and drop the food if it's close. 
            % This is where you should call CheckColonyProximity()
            % Leave red pheromone
        % end
    % end iterate over ants
    
    % update pheromones. This is where you should call PheromonesUpdate()
    
    % plot everything
    
    % Capture a frame and write into the video file
    capturedFrame = getframe(gcf);
    writeVideo(videoFile, capturedFrame)
% end iterate over timestamps

% Close the video writing file
close(videoFile)