function rate = getRate(specie)
    % getK - Returns the correct combination of k (specific reaction rate constant) given the specie
    %
    % Syntax: rate = getRate(species)
    %
    % This function returns the symbolic rate for a given species in the form:
    % rate = (k1,2 + k1,3 + k1,4 + k1,5)yVGO^2

    % The following functions calculates the specific reaction rate constant taking into consideration 
    % the mass transfer resistances

    % NOTES
    % kg specific reaction resistances
    % eta is the effectiveness factor
    % kij is the specific reaction rate of lump i to lump j
    % rate_i = ko_i*y_i for a first order reaction
    % rate_i = ko_i*y_i for a second order reaction

    ko_1_order = @(i, j) (1/k_g - 1/(effectiveness_factor * kij(i, j)))^-1;
    term_ = @(i, j) 1 + ( 0.5 * (k_g)/(effectiveness_factor * kij(i, j) * y_VGO) );
    ko_2_order = @(i, j) k_g * ( term_(i, j) - sqrt(term_^2 - 1) );

    syms k_o(n, ii, jj)

    % This a function that calculates the ko given the order of the reaction, lump i and j
    % It is a piecewise function that determines the correct function to calculate the 
    % ko for a given i and j and the order
    k_o(n, ii, jj) = piecewise(n==1, ko_1_order(ii, jj), n==2, ko_2_order(ii, jj));




    % Rate equations have mass transfer resistances incorporated
    switch specie
        case 'VGO'
            % rate = (k1_2 + k1_3 + k1_4 + k1_5)*y_VGO^2
            rate = (k_o(2, 1, 2) + k_o(2, 1, 3) + k_o(2, 1, 4) + k_o(2, 1, 5)) * y_VGO;
        case 'GA'
            % rate = (alpha1_2*k1_2*y_VGO^2) - (k2_3 + k2_4 + k2_5)*y_GA;
            rate = (alpha1_2 * k_o(2, 1, 2) * y_VGO) - (k_o(1, 2, 3) + k_o(1, 2, 4) + k_o(1, 2, 5)) * y_GA;
        case 'LPG'
            % rate = (alpha1_3*k1_3*y_VGO^2) + (alpha2_3*k3_3*y_GA) - (k3_4 + k3_5)*y_LPG;
            rate = (alpha1_3 * k_o(2, 1, 3) * y_VGO) + (alpha2_3 * k_o(1, 3, 3) * y_GA) - (k_o(1, 3, 4) + k_o(1, 3, 5)) * y_LPG;
        case 'DG'
            % rate = (alpha1_4 * k1_4 * y_VGO^2) + (alpha2_4 * k2_4 * y_GA) + (alpha3_4 * k3_4 * y_LPG);
            rate = (alpha1_4 * k_o(2, 1, 4) * y_VGO) + (alpha2_4 * k_o(1, 2, 4) * y_GA) + (alpha3_4 * k_o(1, 3, 4) * y_LPG);
        case 'CK'
            % rate = (alpha1_5*k1_5*y_VGO^2) + (alpha2_5*k2_5*y_GA) + (alpha3_5*k3_5*y_LPG);
            rate = (alpha1_5 * k_o(2, 1, 5) * y_VGO) + (alpha2_5 * k_o(1, 2, 5) * y_GA) + (alpha3_5 * k_o(1, 3, 5) * y_LPG);
    end
    
end