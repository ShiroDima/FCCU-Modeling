% Author: Akarawak Dima
% Project: Modeling and Simulation of an industrial FCCU
% School: University of Lagos

% Script for the Vapouriser subsystem of the FCCU
% The vapouriser components are:
% - The Vacuum Gas Oil (VGO)
% - The Regenerated catalyst
% - The Steam

% This script solves an energy balance equation for the temperature of the feed into the reactor (temperature_in)

% First check if parameters have been loaded into the MATLAB workspace
fileName = "parameters.mat";

if ~isfile(fileName)
    % File was not found and the parameters.m file should be run to load parameters into workspace
    parameters
end

% Numerator terms
vgo_term_num = flowrate_vgo * ((cp_vgo_liquid * (temperature_vgo - temperature_vap)) + (cp_vgo_vapour * temperature_vap) - enthalpyVAP_vgo);
cat_term_num = flowrate_regen_catalyst * cp_regen_catalyst * temperature_regen_catalyst;
steam_term_num = flowrate_steam * cp_steam * temperature_steam;

% Denominator terms
vgo_term_den = flowrate_vgo * cp_vgo_vapour
cat_term_den = flowrate_regen_catalyst * cp_regen_catalyst
steam_term_den = flowrate_steam * cp_steam

% Calculate the temperature of the feed into the riser reactor with the following equation
temperature_in = (vgo_term_num + cat_term_num + steam_term_num) / (vgo_term_den + cat_term_den + steam_term_den);


