% Author: Akarawak Dima
% Project: Modeling and Simulation of an industrial FCCU
% School: University of Lagos

% This script is the starting point for the entire project.
% It runs all the code for the solution

% Add current working directory to path
addpath(pwd);
addpath(fullfile(pwd, 'subsystems'));

% Load or save parameters
parameters

% Solve the vapourizer subsystem for the temperature of the feed into the riser reactor
vapouriser