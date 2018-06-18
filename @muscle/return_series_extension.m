function series_extension = return_series_extension(obj,muscle_force,time_step)
% Function returns force in series element

if ((time_step<eps))
    series_extension = muscle_force / obj.series_k_linear;
else
%     series_extension = ...
%         ((muscle_force * time_step / obj.series_viscosity) + ...
%                 obj.last_series_extension) / ...
%         (1 + (time_step * obj.series_k_linear / obj.series_viscosity));
    
    series_extension = ...
        ((muscle_force * time_step^2) + ...
            (obj.last_series_extension * (obj.series_viscosity * time_step + 2 * obj.series_mass)) - ...
            (obj.last_series_extension2 * obj.series_mass)) / ...
        ((obj.series_k_linear * time_step^2 + obj.series_viscosity * time_step + ...
            obj.series_mass));
        
end
