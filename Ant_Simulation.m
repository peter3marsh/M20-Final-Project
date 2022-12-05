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
load('map1.mat')

% Tunable parameters. The allowed ranges for these parameters are:
%  blue_decay: [0, 1]
%  red_decay: [0, 1]
%  r_smell: [0, 10]
%  sigma_1: [0, +Inf]
%  sigma_2: [0, +Inf]
blue_decay = 0.5;
red_decay = 0.5;
r_smell = 5;
sigma_1 = 10;
sigma_2 = 10;

% fixed parameters
ants_speed = 1;

% initialize the ants
%  ants_angle: an n_ants-by-1 array cantaining random orientations for all ants
%  ants_xpos: an n_ants-by-1 array cantaining the x coordinates for all ants
%  ants_ypos: an n_ants-by-1 array cantaining the y coordinates for all ants
%  ants_food: an n_ants-by-1 boolean array to indicate whether the ant 
%             carries food or not
ants_angle = zeros(n_ants,1); %.*rand(n_ants,1)*2*pi;
ants_xpos = zeros(n_ants,1) + colony_pos(1); 
ants_ypos = zeros(n_ants,1) + colony_pos(2); 
ants_food = zeros(n_ants, 1);

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
blue_pheromones = [];
red_pheromones = [];
blue_concentration = [];
red_concentration = [];

% initialize colony food counter variable
colony_food_counter = 0;

% open the video writing file
videoFile = VideoWriter('finalProject.mp4', 'MPEG-4'); % creates a file handler to the video writer
videoFile.FrameRate = 30;  % Set the video frame rate (30 is the default value)
open(videoFile) % open the video file to write data

% iterate over timestamps (i.e., for each timestamp...)
for T=1:60
    % iterate over ants (i.e., for each ant...)
    for i = n_ants
        % compute the new angle. 
        % This is where you should call ComputeNewAngle()
        if ants_food(i,1) == true
            ants_angle = ComputeNewAngle(ants_xpos(i,1), ants_ypos(i,1), ants_angle(i,1), blue_pheromones,blue_concentration, r_smell, sigma_1,sigma_2);
        else
            ants_angle = ComputeNewAngle(ants_xpos(i,1), ants_ypos(i,1), ants_angle(i,1), red_pheromones,red_concentration, r_smell, sigma_1,sigma_2);
        end
        
        % check movement validity. 
        % This is where you should call MovementValidationExecution()       
        % update ant location and angle of the ant
        MovementValidationExecution(ants_xpos(i,1), ants_ypos(i,1), ants_angle(i,1), ants_speed, map_coordinates, forbidden);
        
        % if ant is not carrying food, 
            % Check the food proximity and grab food if it's close to a 
            % source. This is where you call CheckFoodProximity()
            % Leave blue pheromone
        if ants_food == 0
            if CheckFoodProximity(ants_xpos(i,1), ants_ypos(i,1), food_sources, food_proximity_threshold)
                ants_food(i,1) = 1; 
            end
            blue_pheromones = [ blue_pheromones; [ants_xpos(i,1), ants_ypos(i,1)] ];
        % else, (the ant is carrying food)
            % Check the colony proximity and drop the food if it's close. 
            % This is where you should call CheckColonyProximity()
            % Leave red pheromone
        % end
        else
            if CheckColonyProximity(ants_xpos(i,1), ants_ypos(i,1), colony_pos, colony_proximity_threshold)
                ants_food(i,1) = 0;
            end
            red_pheromones = [ red_pheromones; [ants_xpos(i,1), ants_ypos(i,1)] ];
        end

    % end iterate over ants
    end
    
    % update pheromones. This is where you should call PheromonesUpdate()
    PheromonesUpdate(blue_pheromones, blue_concentration, blue_decay);
    PheromonesUpdate(red_pheromones, red_concentration, red_decay);

    % plot everything
    disp("Iteration " + T)

    plot(ants(:, 1), ants(:, 2), "k*", 'MarkerSize', 8)
    hold on
    grid on
    xlim([-50 100])
    ylim([-50 100])
    % Add colony
    viscircles(colony_pos,colony_proximity_threshold,'Color',"c");
    % plot the pheromones    
%     rpheromones_duration_plot = red_decay(red_decay<=1);
%     rpheromones_plot = red_pheromones(red_decay<=1, :);
% 
%     if length(rpheromones_duration_plot)>=1
        rpheromones = scatter(red_pheromones(:,1), red_pheromones(:,2), 8, "filled", "r");
%         rpheromones.AlphaData = rpheromones_duration_plot;
%         rpheromones.MarkerFaceAlpha = 'flat';
%     end

%     bpheromones_duration_plot = blue_decay(blue_decay<=1);
%     bpheromones_plot = blue_pheromones(blue_decay<=1, :);
%     
%     if length(bpheromones_duration_plot)>=1
        bpheromones = scatter(blue_pheromones(:,1), blue_pheromones(:,2), 8, "filled", "b");
%         bpheromones.AlphaData = bpheromones_duration_plot;
%         bpheromones.MarkerFaceAlpha = 'flat';
%     end

    title("Time step: " + T)
    hold off

    % Capture a frame and write into the video file
    capturedFrame = getframe(gcf);
    writeVideo(videoFile, capturedFrame)
% end iterate over timestamps
end

% Close the video writing file
close(videoFile)