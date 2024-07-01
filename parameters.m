% Author: Akarawak Dima
% Project: Modeling and Simulation of an industrial FCCU
% School: University of Lagos

% This script loads or saves all the required parameters for the entire project
% as a .mat file

clc; clear;

fileName = "parameters.mat"; % Name of the file where parameters will be saved to and loaded from

% PARAMETERS BY SUBSYSTEM

%%
% VAPOURIZER SUBSYSTEM

% VGO component
cp_vgo_liquid = 9; % Specific Heat Capacity of the VGO component in the liquid phase
cp_vgo_vapour = 10; % Specific Heat Capacity of the VGO component in the vapour phase
flowrate_vgo = 1000; % Flowrate of the VGO component
temperature_vgo = 1000; % Temperature of the VGO component [K]
enthalpyVAP_vgo = 1000; % Enthalpy of vapourization of the VGO component [J/kg]
temperature_vap = 1000; % Boiling point temperature at which the VGO component vapourizes

% Catalyst component
flowrate_regen_catalyst = 1000; % Flowrate of the catalyst component
cp_regen_catalyst = 1000; % Specific Heat Capacity of the catalyst component
temperature_regen_catalyst = 1000; % Temperature of the catalyst component [K]

% Steam component
flowrate_steam = 1000; % Flowrate of the steam component
cp_steam = 4200; % Specific Heat Capacity of the steam component
temperature_steam = 1000; % Temperature of the steam component [K]

%%
% REACTOR SUBSYSTEM

dp = 1E-6; % Characteristic dimention of the catalyst
epsilon_b = 1E-4; % Void fraction of the catalyst
cat_density = 1E4; % Catalyst density
effective_diameter = 1E4; % Effective diameter
kd0 = 1E-4; 
Ed = 1E4; % Activition Energy of the catalyst deaction reaction [J/kg]
Ru = 8.314; % Universal Gas constant [J/mol K]
T = 400; % Riser reactor temperature [K]
AR = 8; % Reactor base area
HR = 5; % Reactor height
COR = 4; % Catalyst to Gas Oil Ratio
species = {"VGO", "GA", "LPG", "DG", "CK"} % Chemical species involved in reactions. These are the individual lumps in the modified kinetic model

% Specific reaction rate constant of reaction lump i generating lump j
% It is a 5x5 matrix
k0_ij = []; % Specific reaction rates constant per unit volume [s^-1]

% Activation Energy of reaction lump i generating lump j
% It is a 5x5 matrix
E_ij = []; % Specific reaction rates constant per unit volume [s^-1]

% check if the data file exists
if isfile(fileName)
    % File exists. Load it
    
    load(fileName)
else
    % File does not exist, save parameters to file
    save(fileName)
end