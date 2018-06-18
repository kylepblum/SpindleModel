function series_force = return_series_force(obj,series_extension,time_step)
% Function returns force in series element

if (time_step<eps)
    series_force = obj.series_k_linear * series_extension;
else
    
    series_velocity = (series_extension - obj.last_series_extension)/time_step;
    series_acceleration = ((series_extension - obj.last_series_extension)/time_step - ...
        (obj.last_series_extension - obj.last_series_extension2)/time_step)/time_step;
    
    series_force = (obj.series_k_linear * series_extension) + ...
        (obj.series_viscosity * series_velocity) + ...
        (obj.series_mass * series_acceleration);
end