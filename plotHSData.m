function plotHSData(hs)
f = hs.f;
g = hs.g;
bins = hs.x_bins;

h = fig;
set(gca,'FontName','Arial','FontSize',10)
yyaxis left
plot(bins,f), ylabel('k_f (s^{-1} m^{-1})')
yyaxis right
plot(bins,g), ylabel('k_g (s^{-1})')
xlabel('distortion (nm)')
set(h,'Units','Inches');
set(h,'PaperPosition',[0 0 6.5 4],'Position',[0 0 6.5 4])


end