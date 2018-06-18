function plotForceDataRR(data)
time = data.t;
cbf = data.cb_force;
hsf = data.hs_force;
pf = data.passive_force;
hsl = data.hs_length;

fig;


h1 = subplot(4,3,[1:2 4:5 7:8]); hold on;
set(h1,'TickDir','out','FontName','Helvetica','FontSize',16,...
    'xtick',[])
ylabel('Stress (MPa)')
axis([time(1) time(end) min(cbf)/10^6 max(hsf)/10^6])

h2 = subplot(4,3,[10:11]); hold on;
set(gca,'TickDir','out','FontName','Helvetica','FontSize',16)
ylabel('hs length (nm)'), xlabel('time (s)')
axis([time(1) time(end) min(hsl) max(hsl)])

h3 = subplot(4,4,[8 12]); hold on;
set(gca,'TickDir','out','FontName','Helvetica','FontSize',16)
ylabel('hs Stress (MPa)'), xlabel('hs Length')
axis([min(hsl) max(hsl) min(hsf)/10^6 max(hsf)/10^6])

% h4 = subplot(5,3,6); hold on;
% set(gca,'TickDir','out','FontName','Helvetica','FontSize',10)
% ylabel('cb Stress (MPa)'), xlabel('hs Length')
% axis([min(hsl) max(hsl) min(cbf)/10^6 max(cbf)/10^6])

h_cbf = [];  % Cross-bridge force handle
h_hsf = [];  % Half-sarcomere force handle
h_pf = [];   % Passive force handle
h_cbl = [];  % Cross-bridge length handle





h_cbf = line(time,cbf/10^6,'color',[1 0 0],'Parent',h1);
h_hsf = line(time,hsf/10^6,'color',[0 0 1],'Parent',h1);
h_pf = line(time,pf/10^6,'color',[1 0 1],'Parent',h1);

h_legend = legend(h1,'X-b force','Half-Sarc. force',...
    'Pas. force','location','southeast');

h_cbl = line(time,hsl,'Parent',h2);

h_cbfHyst = line(hsl,hsf/10^6,'color',[0 0 1],'Parent',h3);
% h_hsfHyst = line(hsl,cbf/10^6,'color',[1 0 0],'Parent',h4);

drawnow
end