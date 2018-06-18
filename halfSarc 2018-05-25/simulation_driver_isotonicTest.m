function [hs,data] = simulation_driver_isotonicTest
tic
% Set up the simulation time and half-sarcomere length movements
time_step = 0.001;


% THIS IS WHERE YOU DEFINE MOVEMENTS
% Ramp and hold
% 0.091 nm/ms = 0.07L0/s for 1300nm half-sarcomere

    t=-5:time_step:6;

    delta_cdl = zeros(10,numel(t));
    
    for a = 1
        for i = 1:numel(t)
            if i > 5000 && i < 5000 + 750/a
                delta_cdl(a,i) = 0.1182*a;
            elseif i > 5000 + 750/a + 1000 && i < 5000 + 750/a + 1000 + 750/a
                delta_cdl(a,i) = -0.1182*a;
            end
        end
    end



  CHECK_SLACK = 1;  

% Make a half-sarcomere
hs = halfSarc();

% Loop through the time-steps
for a = 1
    for i=1:numel(t)
        
        
        
        if CHECK_SLACK  
            %CHECK IF SLACK
            %ADJUST HS LENGTH SO FORCE IS BACK TO 0
            hs.hs_force = 0;
            x = find_hsl_from_force(hs,0.0);
            
            if hs.cmd_length<x
                slack_mode = 1;
                new_length = max(x,hs.cmd_length);
                adj_length = new_length - hs.hs_length;
                hs.forwardStep(0.0,adj_length,0,0,1);
            else
                slack_mode = 0;
            end
            
            if slack_mode
               %CROSS BRIDGE EVOLUTION TAKES UP SLACK  
               % Any cb cycling here must be applied to shortening
               % against zero load.
                
               % First, we evolve the distribution
                hs.forwardStep(time_step,0.0,0.0,1,0)
                
               % Next, we iteratively search for the sarcomere length
               % that would give us zero load
                x = find_hsl_from_force(hs,0);
                
               % We then compute the new hs length applied to the
               % sarcomere based on whether the command length is now
               % greater than the sarcomere length (back into
               % length-control) or not (still in isotonic mode). The
               % length adjustment is the the calculated new length - the 
               % current measurement of hs length. 
               
                new_length = max(x,hs.cmd_length);
                adj_length = new_length - hs.hs_length;
                
               % Finally, we shift the distribution by the adjusted length
                hs.forwardStep(time_step,adj_length,delta_cdl(a,i),0,1);
                
            else %length control
                delta_hsl = delta_cdl(a,i);
                hs.forwardStep(time_step,delta_hsl,delta_cdl(a,i),1,1);
            end
        end
        
        % Store data
        
        data(a).f_activated(i) = hs.f_activated;
        data(a).f_bound(i) = hs.f_bound;
        data(a).cb_force(i) = hs.cb_force;
        
        
        data(a).passive_force(i) = hs.passive_force;
        data(a).hs_force(i) = hs.hs_force;
        data(a).hs_length(i) = hs.hs_length;
        data(a).cmd_length(i) = hs.cmd_length;
        data(a).slack(i) = hs.slack;
        data(a).bin_pops(:,i) = hs.bin_pops;
        data(a).no_detached(i) = hs.no_detached;
        
    end
    data(a).t = t;
end

toc;

