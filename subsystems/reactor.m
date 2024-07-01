% Author: Akarawak Dima
% Project: Modeling and Simulation of an industrial FCCU
% School: University of Lagos

% Script for the reactor subsystem of the FCCU

%% KINETIC MODELING IN THE REACTOR

% Functions needed
cat_surface_area = ( 6 * (1-epsilon_b) ) / dp; % The catalyst specific external surface area

%   This function calculates the thiele modulus.
%   The thiele modulus is a measure of the intrinsic reaction rate to diffusion rate
%   It provides a yardstick for determining the rate determining step in heterogenous catalysis in an n-th order reaction.
%   
%   Parameters
%   n - Order of the reaction
thiele_modulus = @(n) (1/cat_surface_area) * sqrt(((n+1)/2) * ((k(n)*cat_density*y_a0^(n-1))/effective_diameter));

%   This function calculates the effectiveness factor.
%   The effectiveness factor is a measure of the extent to which diffusion resistance reduces the rate of chemical reactions in heterogenous catalysis
%   
%   Parameters
%   phi - Thiele module of a n-th order reaction
effectiveness_factor = @(phi) (3/phi) * (phi*coth(phi) - 1);

% This function calculates the specific reaction rate constant of reaction lump i generating lump j
kij = @(i, j) k0_ij(i, j) * exp(-(E_ij(i, j))/(Ru * T))


% CATALYST DEACTIVATION MODEL

% Relation between catalyst activity (a) and time on stream <Catalyst Residence Time> (tc)
% Given by Dagde and Puyate (2012)
% kd is related to the riser reactor temperature
Qcat = flowrate_regen_catalyst * COR/cat_density;
kd = (kd0) * exp(-(Ed)/(Ru * T)); % Catalyst decay coefficient
tc = (AR*HR) / Qcat; % Catalyst residence time
a = exp(-kd*tc); % Catalyst deactivation model


% CATALYST POISONING (NITROGEN AND ARA)
phi_N = 1 / ( 1 + (k_N2 * yN2 * tc)/COR ); % Poisoning effect of basic nitrogen on the catalyst
phi_A = 1 / ( 1 + K_A*(yA * yR * yASP) ); % Poisoning effect of Aromatics, Resins and Asphaltenes

%% HYDRODYNAMIC MODELLING IN THE REACTOR

% Functions needed
