function dp = force(t, p)
    % force - ODE resulting from a force balance on the riser reactor
    %
    % Syntax: dp = force(t, p)
    %
    % Differential equation resulting from a force balance
    % Components resulting from the balance are:
    % - Pressure drop due to hydrostatic head
    % - Pressure drop due to solids acceleration
    % - Pressure drop due to solid friction

    hh_ = HR*cluster_phase_density*g*(1-epsilon_); % Hydrostatic head term
    sa_ = cluster_phase_density*(1-epsilon_); % Solid acceleration term % TODO Check this too. No idea WTF is going on here. Try looking for Konno and Saito (1969) paper
    sf_ = 2*HR*fs*cluster_phase_density*(1-epsilon_)/DR; % Solids friction term % TODO Check this too. No idea WTF is going.
    gf_ = (HR*fg*gas_phase_density*vg^2)/DR



    dp = -(1/pressure_in) * (hh_ + sa_ + sf_ + gf_)
    
end