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
vgo_term_num = vapourizerParams.flowrate_vgo * ((vapourizerParams.cp_vgo_liquid * (vapourizerParams.temperature_vgo - vapourizerParams.temperature_vap)) + (vapourizerParams.cp_vgo_vapour * vapourizerParams.temperature_vap) - vapourizerParams.enthalpyVAP_vgo);
cat_term_num = vapourizerParams.flowrate_regen_catalyst * vapourizerParams.cp_regen_catalyst * vapourizerParams.temperature_regen_catalyst;
steam_term_num = vapourizerParams.flowrate_steam * vapourizerParams.cp_steam * vapourizerParams.temperature_steam;

% Denominator terms
vgo_term_den = vapourizerParams.flowrate_vgo * vapourizerParams.cp_vgo_vapour;
cat_term_den = vapourizerParams.flowrate_regen_catalyst * vapourizerParams.cp_regen_catalyst;
steam_term_den = vapourizerParams.flowrate_steam * vapourizerParams.cp_steam;

% Calculate the temperature of the feed into the riser reactor with the following equation
temperature_in = (vgo_term_num + cat_term_num + steam_term_num) / (vgo_term_den + cat_term_den + steam_term_den);

fprintf('Feed temperature into riser reactor = %.2f C\n', temperature_in)


