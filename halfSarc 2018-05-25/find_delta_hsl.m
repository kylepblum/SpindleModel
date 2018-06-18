function x_new = find_delta_hsl(obj)
x_new = fsolve(@(x) tempForce(x,obj), 0,...
    optimoptions('fsolve','Display','off'));

    function hsF = tempForce(x,obj)
        % Adjust for filament compliance
        delta_x = x * obj.compliance_factor;
        % Shift populations by interpolation
        interp_positions = obj.x_bins - delta_x;
        % THIS IS WHERE YOU SOLVE FOR BIN POPULATIONS ITERATIVELY %
        temp_bin_pops = interp1(obj.x_bins,obj.bin_pops,interp_positions, ...
            'linear',0)';
        hsF = obj.cb_number_density * obj.k_cb * 1e-9 * ...
            sum((obj.x_bins + obj.power_stroke).* temp_bin_pops');
    end

end