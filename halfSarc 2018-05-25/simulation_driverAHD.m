function [hs,data] = simulation_driverAHD
tic
% Set up the simulation time and half-sarcomere length movements
time_step = 0.001;


% THIS IS WHERE YOU DEFINE MOVEMENTS
% 0.091 nm/ms = 0.07L0/s for 1300nm half-sarcomere




    
    % Triangles
    % 0.091 nm/ms = 0.07L0/s for 1300nm half-sarcomere
    t=-5:time_step:12;
    delta_hsl = zeros(size(t));
    
    for a = 1:5
        test_dur = round(750/a);
        for i = 1:numel(t)
            % 1st stretch
            if i > 6500 - 2*test_dur && i < 6500 - test_dur
                delta_hsl(a,i) = 0.1182;
                % 1st shorten
            elseif i >= 6500 - test_dur && i < 6500
                delta_hsl(a,i) = -0.1182;
                
                
                % 2nd stretch
            elseif i >= 6501 && i < 7251
                delta_hsl(a,i) = 0.1182;
                % 2nd shorten
            elseif i >= 7251 && i < 8001
                delta_hsl(a,i) = -0.1182;
            elseif i >= 8001 && i < 8751
                delta_hsl(a,i) = 0.1182;
                % 3rd shorten
            elseif i >= 8751 && i < 9500
                delta_hsl(a,i) = -0.1182;
            end
        end
    end
        
        
% for i = 1:numel(t)
%     delta_hsl(i) = 0;
% end

% Make a half-sarcomere
hs = half_sarcomere();

% h = waitbar(0,'Please wait...');
% Loop through the time-steps
parfor a = 1:5
    for i=1:numel(t)
        
        hs.implement_time_step(time_step,delta_hsl(a,i));
        
        % Store data
        data(a).f_activated(i) = hs.f_activated;
        data(a).f_bound(i) = hs.f_bound;
        data(a).cb_force(i) = hs.cb_force;
        data(a).passive_force(i) = hs.passive_force;
        data(a).hs_force(i) = hs.hs_force;
        data(a).hs_length(i) = hs.hs_length;
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

