% Author: Akarawak Dima
% Project: Modeling and Simulation of an industrial FCCU
% School: University of Lagos

% This script loads or saves all the required parameters for the entire project
% as a .dat file

clc; clear;

fileName = "parameters.mat"; % Name of the file where parameters will be saved to and loaded from

% PARAMETERS BY SUBSYSTEM

% VAPOURIZER SUBSYSTEM

% VGO component
cp_vgo_liquid = 9; % Specific Heat Capacity of the VGO component in the liquid phase
cp_vgo_vapour = 10; % Specific Heat Capacity of the VGO component in the vapour phase
flowrate_vgo = 1000; % Flowrate of the VGO component
temperature_vgo = 1000; % Temperature of the VGO component
enthalpyVAP_vgo = 1000; % Enthalpy of vapourization of the VGO component
temperature_vap = 1000; % Boiling point temperature at which the VGO component vapourizes

% Catalyst component
flowrate_regen_catalyst = 1000; % Flowrate of the catalyst component
cp_regen_catalyst = 1000; % Specific Heat Capacity of the catalyst component
temperature_regen_catalyst = 1000; % Temperature of the catalyst component

% Steam component
flowrate_steam = 1000; % Flowrate of the steam component
cp_steam = 4200; % Specific Heat Capacity of the steam component
temperature_steam = 1000; % Temperature of the steam component

% check if the data file exists
if isfile(fileName)
    % File exists. Load it
    
    load(fileName)
else
    % File does not exist, save parameters to file
    save(fileName)
end