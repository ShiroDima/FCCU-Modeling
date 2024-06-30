% Author: Akarawak Dima
% Project: Modeling and Simulation of an industrial FCCU
% School: University of Lagos

% This script loads or saves all the required parameters for the entire project
% as a .dat file

clc

fileName = "parameters.mat" % Name of the file where parameters will be saved to and loaded from

% PARAMETERS BY SUBSYSTEM

% VAPOURISER SUBSYSTEM
cp_vgo_liquid = 9;
cp_vgo_vapour = 10;


% first check if the data file exists
if isfile(fileName)
    % File exists. Load it
    clear
    load(fileName)
else
    % File does not exist, save parameters to file
    save(fileName)
end