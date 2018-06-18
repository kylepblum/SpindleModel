function plotForceDataRH(data)
time = data.t;
cbf = data.cb_force;
hsf = data.hs_force;
pf = data.passive_force;
hsl = data.hs_length;

fig;


h1 = subplot(2,2,1:2); hold on;
set(h1,'TickDir','out','FontName','Helvetica','FontSize',10,...
    'xtick',[])
ylabel('Stress (MPa)')
axis([time(1) time(end) min(cbf)/10^6 max(hsf)/10^6])

h2 = subplot(2,2,3:4); hold on;
set(gca,'TickDir','out','FontName','Helvetica','FontSize',10)
ylabel('hs length (nm)'), xlabel('time (s)')
axis([time(1) time(end) min(hsl) max(hsl)])


h_cbf = [];  % Cross-bridge force handle
h_hsf = [];  % Half-sarcomere force handle
h_pf = [];   % Passive force handle
h_cbl = [];  % Cross-bridge length handle





% h_cbf = line(time,cbf/10^6,'Parent',h1);
h_hsf = line(time,hsf/10^6,'Parent',h1);
% h_pf = line(time,pf/10^6,'Parent',h1);

% h_legend = legend(h1,'X-b force','Half-Sarc. force',...
%     'Pas. force','location','southeast');

h_cbl = line(time,hsl,'Parent',h2);


drawnow
end