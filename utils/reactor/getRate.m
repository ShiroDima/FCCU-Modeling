function rate = getRate(specie)
    % getK - Returns the correct combination of k (specific reaction rate constant) given the specie
    %
    % Syntax: rate = getRate(species)
    %
    % This function returns the symbolic rate for a given species in the form:
    % rate = (k1,2 + k1,3 + k1,4 + k1,5)yVGO^2


    switch specie
        case 'VGO'
            rate = (k1_2 + k1_3 + k1_4 + k1_5)*y_VGO^2;
        case 'GA'
            rate = (alpha1_2*k1_2*y_VGO^2) - (k2_3 + k2_4 + k2_5)*y_GA;
        case 'LPG'
            rate = (alpha1_3*k1_3*y_VGO^2) + (alpha2_3*k3_3*y_GA) - (k3_4 + k3_5)*y_LPG;
        case 'DG'
            rate = (alpha1_4*k1_4*y_VGO^2) + (alpha2_4*k2_4*y_GA) + (alpha3_4*k3_4*y_LPG);
        case 'CK'
            rate = (alpha1_5*k1_5*y_VGO^2) + (alpha2_5*k2_5*y_GA) + (alpha3_5*k3_5*y_LPG);
    end
    
end