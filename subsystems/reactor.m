% Author: Akarawak Dima
% Project: Modeling and Simulation of an industrial FCCU
% School: University of Lagos

% Script for the reactor subsystem of the FCCU

%% KINETIC MODELLING IN THE REACTOR

% Functions needed
cat_surface_area = ( 6 * (1-reactorParams.epsilon_b) ) / reactorParams.dp; % The catalyst specific external surface area

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
kij = @(i, j, T) k0_ij(i, j) * exp(-(E_ij(i, j))/(Ru * T))


% CATALYST DEACTIVATION MODEL

% Relation between catalyst activity (a) and time on stream <Catalyst Residence Time> (tc)
% Given by Dagde and Puyate (2012)
% kd is related to the riser reactor temperature
Qcat = flowrate_regen_catalyst * COR/cat_density; % Volumetric flowrate of catalyst
kd = @(T) (kd0) * exp(-(Ed)/(Ru * T)); % Catalyst decay coefficient
tc = (AR*HR) / Qcat; % Catalyst residence time
a = @(T) exp(-kd(T)*tc); % Catalyst deactivation model


% CATALYST POISONING (NITROGEN AND ARA)
phi_N = ( 1 + (k_N2 * yN2 * tc)/COR ); % Poisoning effect of basic nitrogen on the catalyst
phi_A = ( 1 + K_A*(yA * yR * yASP) ); % Poisoning effect of Aromatics, Resins and Asphaltenes

phi_ = phi_N*phi_A; % Combined effect of both poisoning

%% HYDRODYNAMIC MODELLING IN THE REACTOR


% NOTES
% vg is the gas interstitial velocity
% vc is the cluster phase velocity
% Phi is the slip factor
% epsilon_g is the volume fraction of the gas phase
% epsilon_c is the volume fraction of the cluster phase
% rho_c is the cluster density
% rho_i is the gas phase viscosity of the i-th component

syms Cd(Re)

% Functions needed

% This calculates the slip factor which is defined as the ratio of the gas interstitial velocity to the cluster phase velocity
slip_factor = 1; % Slip factor % TODO Check this out later

% This calculates the Archimedes number (Ar) which is used to define the boundary between flow zones.
% These zones are:
% - Stokes == Ar < 32.9
% - Intermediate == 32.9 < Ar < 106.5
% - Newton == Ar > 106.5
archimedes = gas_phase_density*(gas_phase_density - cluster_phase_density)*g*dp^3/gas_phase_viscosity^2; % Dimensionless Archimedes number
reynolds_t = archimedes/(18 + (2.3348 - 1.7439*phi)*archimedes^0.5 ); % Reynolds number based on particle terminal velocity
u_t = (reynolds_t * gas_phase_viscosity) / (gas_phase_density * dp)
molecular_weight_gas_phase = 1; % TODO Ask about this too. No idea WTF is going on here. Why does he make it so fucking confusing????

% This calculates the drag coefficient as a function of reynolds number.
% A piecewise function is used with the boundary value being 1000.
Cd(Re) = piecewise(Re < 1000, (24/Re)*(1+0.15*Re^0.687), Re > 1000, 0.44);

reynolds_ = density*epsilon_g*abs(vg); % TODO Fix this. Do not understand what is going on here
Ap = 1.5*epsilon_c/Dc;

% This calculates the viscosity of steam
% Correlation is given by Daubert and Danner (1985)
viscosity_steam = @(T) (7.6190E-8*T^0.92758)/( 1 + (211.6/T) - (4670/T^2) ); 


%% CONTINUITY MODELLING IN THE REACTOR

% NOTES
% yVGO is the yield of the VGO component
% yGA is the yield of the Gasoline component
% yLPG is the yield of the LPG component
% yDG is the yield of the Dry Gas component
% yCK is the yield of the Coke component

DEs = []

syms y_VGO(sigma) y_GA(sigma) y_LPG(sigma) y_DG(sigma) y_CK(sigma) alpha [5 5] k [5 5]

VR = reactorParams.AR*reactorParams.HR; % Volume of the reactor calculated using the base area x height
f_ = (VR*reactorParams.gas_phase_density*epsilon_g)/(Fg*phi_); % Common factor in all the component differential equations


% Create the differential equations
for i=1:length(reactorParams.species)
    temp_ = "y_" + reactorParams.species(i);
    DEs(i) = diff(eval(temp_), sigma) == -f_ * (getRate(reactorParams.species(i))) * a(T);
end


%% FORCE MODELLING IN THE REACTOR

syms fg(Re)

% NOTES

fg(Re) = 0.316*Re^-0.25;


%% ENERGY MODELLING IN THE REACTOR

% NOTES
