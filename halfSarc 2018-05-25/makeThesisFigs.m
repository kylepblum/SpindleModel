%% Plot force sweeps
% time = data(1).t;
% cbf = data(end).cb_force;
% hsf = data(end).hs_force;
% hsl = data(1).hs_length;
% cdl = data(1).cmd_length;

hfig = figure;
hfig.Color = 'white';

for a = 1:8
    plotForceDataRH(data(a));
end


%% Spindle model - General
load(['data' filesep 'DI 2018-05-25.mat']);
time = data(3).t;
dataY = data(3);
dataF = data(3);

hfig = figure;
% hfig.RendererMode = 'Painters';

haff = subplot(2,2,1:2); hold on;
set(haff,'TickDir','out','FontName','Arial','FontSize',10,...
    'xtick',[],'NextPlot','add')
ylabel('Stress (MPa)')
axis([time(1) time(end) 0 1])

hlen = subplot(2,2,3:4); hold on;
set(hlen,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
ylabel('hs length (nm)'), xlabel('time (s)')
axis([time(1) time(end) 1300 1400])

% kFs = 1.5;
% kFd = 0.5;
% kY = 0.05;

kFs = 1.0;
kFd = 1.0;
kY = 0.05;

[r,rs,rd] = sarc2spindle(dataY,dataF,kFs,kFd,kY,1);

h_r = line(time,r,'Parent',haff);
h_sC = line(time,rs,'Parent',haff,'color','c');
h_dC = line(time,rd,'Parent',haff,'color','r');

h_cdl = line(time,dataF.cmd_length,'Parent',hlen);


%% Spindle model - DI
load(['data' filesep 'DI 2018-05-25.mat']);
time = data(1).t;


kFs = 1;
kFd = 1;
kY = 0.05;

haff = subplot(2,2,1:2); hold on;
set(haff,'TickDir','out','FontName','Arial','FontSize',10,...
    'xtick',[],'NextPlot','add')
ylabel('Stress (MPa)')
axis([time(1) time(end) 0 1])

hlen = subplot(2,2,3:4); hold on;
set(hlen,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
ylabel('hs length (nm)'), xlabel('time (s)')
axis([time(1) time(end) 1300 1400])

for a = 1:numel(data)
    dataY = data(a);
    dataF = data(a);
    [r,rs,rd] = sarc2spindle(dataY,dataF,kFs,kFd,kY,0);
    h_r = line(time,r,'Parent',haff);
    h_cdl = line(time,dataF.cmd_length,'Parent',hlen);
end

%% Spindle model - THD
load(['data' filesep 'THD 2018-05-25.mat']);
time = data(1).t;


kFs = 1;
kFd = 1;
kY = 0.1;

haff = subplot(2,2,1:2); hold on;
set(haff,'TickDir','out','FontName','Arial','FontSize',10,...
    'xtick',[],'NextPlot','add')
ylabel('Stress (MPa)')
axis([time(1) time(end) 0 1])

hlen = subplot(2,2,3:4); hold on;
set(hlen,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
ylabel('hs length (nm)'), xlabel('time (s)')
axis([time(1) time(end) 1300 1400])

for a = [1:8]
    dataY = data(a);
    dataF = data(a);
    [r,rs,rd] = sarc2spindle(dataY,dataF,kFs,kFd,kY,0);
    h_r = line(time,r,'Parent',haff);
    h_cdl = line(time,dataF.cmd_length,'Parent',hlen);
%     h_sC = line(time,sC,'Parent',h1);
%     h_dC = line(time,dC,'Parent',h1);

end
%% Spindle model - ACT
clear, clc

load(['data' filesep 'ACT 2018-05-25.mat']);
time = data(1).t;


kFs = 1;
kFd = 2;
kY = 0.1;

figure;

haff = subplot(2,2,1:2); hold on;
set(haff,'TickDir','out','FontName','Arial','FontSize',10,...
    'xtick',[],'NextPlot','add')
ylabel('Stress (MPa)')
axis([-1 2 0 1])

hlen = subplot(2,2,3:4); hold on;
set(hlen,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
ylabel('hs length (nm)'), xlabel('time (s)')
axis([-1 2 1300 1400])

for a = [1 5 9]
    for b = [5]
        dataY = data(a);
        dataF = data(b);
        [r,rs,rd] = sarc2spindle(dataY,dataF,kFs,kFd,kY,1);
        h_r = line(time,r,'Parent',haff,'Color',[a/10 0 b/10]);
        h_cdl = line(time,dataF.cmd_length,'Parent',hlen);
%         h_sC = line(time,rs,'Parent',h1,'Color','c');
%         h_dC = line(time,rd,'Parent',h1,'Color','r');
    end
end

%% Spindle model - AHD
load(['data' filesep 'AHD 2018-05-25.mat']);
time = data(1).t;


kFs = 1;
kFd = 1;
kY = 0.05;

hmus = subplot(3,2,1:2); hold on;
set(hmus,'TickDir','out','FontName','Arial','FontSize',10,...
    'xticklabel',[],'NextPlot','add')
ylabel('Stress (MPa)')
axis([-2 3 0 2.5])

haff = subplot(3,2,3:4); hold on;
set(haff,'TickDir','out','FontName','Arial','FontSize',10,...
    'xticklabel',[],'NextPlot','add')
ylabel('Normalized firing rate')
axis([-2 3 0 2.5])

hlen = subplot(3,2,5:6); hold on;
set(hlen,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
ylabel('hs length (nm)'), xlabel('time (s)')
axis([-2 3 1300 1500])

% for a = [1 2 3 4 5 8]
for a = 1:8
    dataY = data(a);
    dataF = data(a);
    [r,rs,rd] = sarc2spindle(dataY,dataF,kFs,kFd,kY,0);
    h_f = line(time,dataF.hs_force/10^6 + 0.25*(a-1),'Parent',hmus);
    h_r = line(time,r+0.25*(a-1),'Parent',haff);
    h_cdl = line(time,dataF.cmd_length+10*(a-1),'Parent',hlen);
%     h_sC = line(time,sC,'Parent',h1);
%     h_dC = line(time,dC,'Parent',h1);

end

%% Supplemental - Day sinusoids

load(['data' filesep 'DaySinusoid.mat']);
time = data(1).t;


kFs = 1.8;
kFd = 2;
kY = 0.5;

% hmus = subplot(3,2,1:2); hold on;
% set(hmus,'TickDir','out','FontName','Arial','FontSize',10,...
%     'xticklabel',[],'NextPlot','add')
% ylabel('Stress (MPa)')
% axis([-1 11.5 0 2.5])

haff = subplot(1,2,1:2); hold on;
set(haff,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
ylabel('Normalized firing rate')
axis([-1 11.5 -0.5 0.5])

% hlen = subplot(2,2,3:4); hold on;
% set(hlen,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
% ylabel('hs length (nm)'), xlabel('time (s)')
% axis([-1 11.5 1300 1500])

% for a = [1 2 3 4 5 8]
    dataY = data;
    dataF = data;
    [r,rs,rd] = sarc2spindle(dataY,dataF,kFs,kFd,kY,0);
%     h_f = line(time,dataF.hs_force/10^6,'Parent',hmus);
    h_r = line(time,r,'Parent',haff);
    h_cdl = line(time,dataF.cmd_length/1300-1,'Parent',haff);
%     h_sC = line(time,sC,'Parent',h1);
%     h_dC = line(time,dC,'Parent',h1);

%% Supplemental - Haftel RR

load(['data' filesep 'Haftel2004.mat']);
time = data(1).t;


kFs = 1.5;
kFd = 1;
kY = 0.15;

% hmus = subplot(3,2,1:2); hold on;
% set(hmus,'TickDir','out','FontName','Arial','FontSize',10,...
%     'xticklabel',[],'NextPlot','add')
% ylabel('Stress (MPa)')
% axis([-1 11.5 0 2.5])

haff = subplot(1,2,1:2); hold on;
set(haff,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
ylabel('Normalized firing rate')
axis([-1 11.5 -0.5 0.5])

% hlen = subplot(2,2,3:4); hold on;
% set(hlen,'TickDir','out','FontName','Arial','FontSize',10,'NextPlot','add')
% ylabel('hs length (nm)'), xlabel('time (s)')
% axis([-1 11.5 1300 1500])

% for a = [1 2 3 4 5 8]
    dataY = data;
    dataF = data;
    [r,rs,rd] = sarc2spindle(dataY,dataF,kFs,kFd,kY,0);
%     h_f = line(time,dataF.hs_force/10^6,'Parent',hmus);
    h_r = line(time,r,'Parent',haff);
    h_cdl = line(time,dataF.cmd_length/1300-1,'Parent',haff);
%     h_sC = line(time,sC,'Parent',h1);
%     h_dC = line(time,dC,'Parent',h1);


%% Spindle model - XB Distribution
load(['data' filesep 'THD 2018-05-25.mat']);

data = data(1);
hs = hs(1);
time = data.t(1:100:end);
xbl = hs.x_bins;
pops = data.bin_pops(:,1:100:end);


plot(time,pops)



