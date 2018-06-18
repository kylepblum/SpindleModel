function [hs,data] = simulation_driverRR
tic
% Set up the simulation time and half-sarcomere length movements
time_step = 0.001;


% THIS IS WHERE YOU DEFINE MOVEMENTS
% 0.091 nm/ms = 0.07L0/s for 1300nm half-sarcomere


    
    % Triangles
    % 0.091 nm/ms = 0.07L0/s for 1300nm half-sarcomere
    t=-5:time_step:20;
    delta_hsl = zeros(10,numel(t));
    
    for a = 1 %How many seconds after the last stretch is the test stretch?
        testTime = (a-1)/time_step;
        for i = 1:numel(t)
            % 1st stretch
            if i > 5000 && i < 5751
                delta_hsl(a,i) = 0.1182;
                % 1st shorten
            elseif i >= 5751 && i < 6501
                delta_hsl(a,i) = -0.1182;
                % 2nd stretch
            elseif i >= 6501 && i < 7251
                delta_hsl(a,i) = 0.1182;
                % 2nd shorten
            elseif i >= 7251 && i < 8001
                delta_hsl(a,i) = -0.1182;
                % 3rd stretch
            elseif i >= 8001 && i < 8751
                delta_hsl(a,i) = 0.1182;
                % 3rd shorten
            elseif i >= 8751 && i < 9501
                delta_hsl(a,i) = -0.1182;
                % Test stretch
            elseif i >= 9501+testTime && i < 10251+testTime
                delta_hsl(a,i) = 0.1182;
                % Test shorten
            elseif i >= 10251+testTime && i < 11001+testTime
                delta_hsl(a,i) = -0.1182;
            end
        end
    end



% Make a half-sarcomere
hs = half_sarcomere();

% Loop through the time-steps
parfor a = 1
    for i=1:numel(t)
        
        hs.implement_time_step(time_step,delta_hsl(a,i));
        
        % Store data
        data(a).f_activated(i) = hs.f_activated;
        data(a).f_bound(i) = hs.f_bound;
        data(a).cb_force(i) = hs.cb_force;
        data(a).passive_force(i) = hs.passive_force;
        data(a).hs_force(i) = hs.hs_force;
        data(a).hs_length(i) = hs.hs_length;
        data(a).sl_length(i) = hs.slacked_length;
        data(a).im_length(i) = hs.imposed_length;
        data(a).bin_pops(:,i) = hs.bin_pops;
        data(a).no_detached(i) = hs.no_detached;
        
%         h = waitbar(i/numel(t));
    end
    data(a).t = t;
end
% close(h)

% data.f_activated = f_activated;
% data.f_bound = f_bound;
% data.cb_force = cb_force;
% data.passive_force = passive_force;
% data.hs_force = hs_force;
% data.hs_length = hs_length;
% data.bin_pops = bin_pops;
% data.no_detached = no_detached;
% data.t = t; 
toc;

