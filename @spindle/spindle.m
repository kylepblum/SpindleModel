classdef spindle < handle
    
    properties
        % These are properties that can be accessed from outside the
        % spindle class
        
        spindle_length;
        spindle_force = 0;
        
        %static_fiber
        static_force = 0;
        static_hs_length;
        static_series_length;
        
        %dynamic_fiber
        dynamic_force = 0;
        dynamic_hs_length;
        dynamic_series_length;
        
        % Muscle objects - which are really a half-sarcomere in
        % series with a spring
        m_static = [];
        m_dynamic = [];
        
        
    end
    
    properties (SetAccess = private)
        % These are properties that can only be accessed from within
        % the spindle class
        
    end
    
    methods
        
        % Constructor
        function obj = spindle(varargin)
            
            % Set up spindle
            static_props.no_of_half_sarcomeres = 1;
            static_props.series_k_linear = 1e6;
            static_props.series_viscosity = 0;
            static_props.series_mass = 0;
        
            dynamic_props.no_of_half_sarcomeres = 1;
            dynamic_props.series_k_linear = 1e6;
            dynamic_props.series_viscosity = 0;
            dynamic_props.series_mass = 0;
            
            % Start by creating the dynamic and static
            obj.m_static = muscle(static_props);
            impose_force_balance(obj.m_static,0);
            
            obj.m_dynamic = muscle(dynamic_props);
            impose_force_balance(obj.m_dynamic,0);
            
            obj.spindle_length = obj.m_static.muscle_length;
        end
        
        % Other methods
        implement_time_step(obj,time_step,delta_hs,Ca_concentration);
    end
    
end
    
            
        