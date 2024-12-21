clear all; close all; clc
%% INPUT DATA


aoe3 = importdata('pcoeff_aoa3.txt');
aoe6 = importdata('pcoeff_aoa6.txt');
aoe9 = importdata('pcoeff_aoa9.txt');


Cl_alpha3 = 0.53425753; 
Cl_alpha6 = 0.8440304;
Cl_alpha9 = 1.1279936;
Cl_alpha10 = 1.2111097;
Cl_alpha12 = 1.3526398 ;
Cl_alpha16 = 1.3115294 ;


%% PRESSURE COEFFICIENT PLOT
figure('units','normalized','outerposition',[0 0 1 1])
hold on
grid on
grid minor
scatter(aoe3.data(:,1), aoe3.data(:,2),37, 'ob','MarkerFaceColor', 'b', 'MarkerFaceAlpha', 0.5)
scatter(aoe6.data(:,1), aoe6.data(:,2),37, 'ok','MarkerFaceColor', 'k', 'MarkerFaceAlpha', 0.5)
scatter(aoe9.data(:,1), aoe9.data(:,2),37, 'or', 'MarkerFaceColor', 'r', 'MarkerFaceAlpha', 0.5)
xlabel('$Chord$ $lenght(m)$', 'fontsize', 22, 'interpreter', 'latex')
ylabel('$C_p$', 'fontsize', 22, 'interpreter', 'latex')
title('Airfoil coordinate vs Pressure coefficient ($C_p$)', 'fontsize', 22, 'interpreter', 'latex')
legend('$\alpha=3^{\circ}$', '$\alpha=6^{\circ}$', '$\alpha=9^{\circ}$', 'fontsize', 14, 'interpreter', 'latex')
saveas(figure(1), 'PressureCoefficientPlot.jpg')

xfoilData5e5 = importdata('xf-naca2410-il-50000-n5.txt');
xfoilData1e6 = importdata('xf-naca2410-il-100000-n5.txt');
xfoilData1e7 = importdata('T2_Re0.686_M0.03_N9.0.txt');

%%
figure('units','normalized','outerposition',[0 0 1 1])
grid on
grid minor
hold on
plot(xfoilData5e5.data(:,1),xfoilData5e5.data(:,2), 'b', 'LineWidth', 2)
plot(xfoilData1e6.data(:,1),xfoilData1e6.data(:,2), '--k', 'LineWidth', 2)
plot(xfoilData1e7.data(:,1),xfoilData1e7.data(:,2), 'g', 'LineWidth', 2)
plot(3, Cl_alpha3, 'ro', 'MarkerFaceColor', 'r')
plot(6, Cl_alpha6, 'r^', 'MarkerFaceColor', 'r')
plot(9, Cl_alpha9, 'rv' , 'MarkerFaceColor', 'r')
plot(10, Cl_alpha10, 'rp', 'MarkerFaceColor', 'r')
plot(12, Cl_alpha12, 'rs', 'MarkerFaceColor', 'r')
plot(16, Cl_alpha16, 'rd', 'MarkerFaceColor', 'r')
legend('XFOIL $C_L$ polar for NACA2410 at $Re=5e5($Re = 5e4$)$',...
    'XFOIL $C_L$ polar for NACA2410 at $Re=1e6$($Re=1e5$)','XFOIL $C_L$ polar for NACA2410 at $Re=6.8e5$', '$C_L$ at $\alpha=3^{\circ}$',...
    '$C_L$ at $\alpha=6^{\circ}$', '$C_L$ at $\alpha=9^{\circ}$', ...
    '$C_L$ at $\alpha=10^{\circ}$','$C_L$ at $\alpha=12^{\circ}$', '$C_L$ at $\alpha=16^{\circ}$', ...
     'fontsize', 14, 'interpreter', 'latex', 'Location', 'northwest')
xlabel('$\alpha (^{\circ})$', 'fontsize', 22, 'interpreter', 'latex')
ylabel('$C_L$', 'fontsize', 22, 'interpreter', 'latex')
title('Study of $C_L$ polar for different Re and $\alpha$', 'fontsize', 22, 'interpreter', 'latex')
saveas(figure(2), 'PolarPlot.jpg')




