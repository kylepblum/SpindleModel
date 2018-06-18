function implement_time_step(obj,time_step,delta_sl,Ca_conc)
% Function implements a time-step on a spindle

obj.spindle_length = obj.spindle_length + delta_sl;

% Implement time_step on components
obj.m_static.implement_time_step(time_step,delta_sl,Ca_conc);
obj.m_dynamic.implement_time_step(time_step,delta_sl,Ca_conc);

% Calculate force
obj.static_force = obj.m_static.muscle_force;
obj.static_hs_length = obj.m_static.hs(1).hs_length;
obj.static_series_length = obj.m_static.series_extension;

obj.dynamic_force = obj.m_dynamic.muscle_force;
obj.dynamic_hs_length = obj.m_dynamic.hs(1).hs_length;
obj.dynamic_series_length = obj.m_dynamic.series_extension;

obj.spindle_force = obj.static_force + obj.dynamic_force;

