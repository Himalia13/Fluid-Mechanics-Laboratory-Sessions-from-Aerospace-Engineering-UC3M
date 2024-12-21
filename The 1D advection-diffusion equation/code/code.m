
% set the size of the ticks on the axes
set(groot, 'defaultLegendFontSize', 12);
% set the default size of the text
set(groot, 'defaultTextFontSize', 12);
% set the default axes font size.
set(groot, 'defaultAxesFontSize', 12);

% set the width of the axes
set(groot, 'defaultAxesLineWidth', 1);
% activate the minor ticks of the axes
set(groot, 'defaultAxesXMinorTick', 'on');
set(groot, 'defaultAxesYMinorTick', 'on');
% deactivate the legend by default
set(groot, 'defaultLegendBox', 'off');
% define the default line width in the plots
set(groot, 'defaultLineLineWidth', 1);
% define the default line marker size
set(groot, 'defaultLineMarkerSize', 5);
% set the font of the axes ticks to Latex
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
% define the font for the default text for the rest of
% objects (labels, titles, legend, etc...)
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

clear all
close all
clc



%% Initialise simulation variables
 
index = 2;
switch index
    case 1
        U = 2;  
        alpha = 3;
    case 2
          U = -0.6;  
        alpha = 1.2;
    case 3
        U = -0.7;  
        alpha = 0.2;
    case 4
         U = 0.1;  
        alpha = 70;
        case 5
         U = 70;  
        alpha = 0.1;
end

k = 0.5;
tmax = 20;	% Maximum simulation time

% Boundary condition: choose from 'Dirichlet', 'Neumann' and 'Periodic'
BC = 'N';               

Nx = 201;       % Grid size (number of points)
Dx = 20/(Nx-1);	% Spacing between points
x = -10:Dx:10;	% Space array (contains position of grid points)

% Maximum timestep that satisfies stability conditions
Dt1 = 2*alpha/U^2;
Dt2 = 0.5*Dx^2/alpha;
Dt = min([Dt1, Dt2]);	% Timestep 

t = 0:Dt:tmax;	% Time array (from 0 to tmax)
Nt = length(t);                     

% Initialise f
f = zeros(Nx, Nt);                  
f(:,1) = sech(k*(x+2)).^2;        

%% Finite differences simulation 
for n = 1:Nt-1
    
    % Inner points (from i = 2 to i = Nx-1)
    for i = 2:Nx-1
        f(i,n+1) = f(i,n) - U*Dt*((f(i+1,n)- f(i-1,n))/(2*Dx)) + alpha*Dt*((f(i+1,n)- 2*f(i,n) + f(i-1,n))/(Dx^2));  % INCOMPLETE! EDIT ACCORDING TO EQ (10)
        
    end
    
    % Points at boundary (at i = 1 and i = Nx)
    switch BC
        case 'D'               
            % Dirichlet Boundary Conditions
                f(1,n+1) = 0.0;
                f(Nx,n+1) = 0.0;                   
    
        case 'N'
            % Neumann Boundary Condtions
                f(1,n+1) =  f(1,n) - U*Dt*((f(2,n)- f(2,n))/(2*Dx)) + alpha*Dt*((f(2,n)- 2*f(1,n) + f(2,n))/(Dx^2));
                f(Nx,n+1) = f(Nx,n) - U*Dt*((f(Nx-1,n)- f(Nx-1,n))/(2*Dx)) + alpha*Dt*((f(Nx-1,n)- 2*f(Nx,n) + f(Nx-1,n))/(Dx^2));
                %alpha*Dt*(2*f(1,n))/(Dx^2); 
                %f(Nx,n) - alpha*Dt*(2*f(Nx,n))/(Dx^2)
        case 'P'
            % Periodic Boundary Conditions
               f(1,n+1) = f(1,n) - U*Dt*((f(Nx,n)- f(Nx-2,n))/(2*Dx)) + alpha*Dt*((f(Nx,n)- 2*f(Nx-1,n) + f(Nx-2,n))/(Dx^2));
               f(Nx,n+1) = f(Nx,n) - U*Dt*((f(3,n)- f(1,n))/(2*Dx)) + alpha*Dt*((f(3,n)- 2*f(2,n) + f(1,n))/(Dx^2));
                    
            otherwise
                return   
                
    end 
end

%% Plot dynamic graph
% % Initialise plot
% fig=figure(1); 
% clf
% axfig = gca;
% axfig.FontSize = 16;
% hold on
% box on
% grid on
% axfig.XLim = [-10 10];
% axfig.YLim = [-0.5 1.0];
% axfig.TickLabelInterpreter = 'latex';
% xlabel('$x$', 'Interpreter', 'latex');
% ylabel('$f$', 'Interpreter', 'latex', 'rotation', 0);
% p = plot(0,0);      % Dummy plot (gets deleted afterwards)
% 
% % Plot curves
% for n = 1:30:Nt
%     delete(p);	% Delete previous curve
%     p = plot(x, f(:,n), '.k-');	% Plot the wave
%     title(['$t = \ $'  num2str(t(n), '%2.2f')] , 'Interpreter', 'latex')	% Update title with the time
%     pause(0.1)	% Pause time (secs) between consecutive graphs
% end

%% Plot graph for report (COMPLETE)
figure(2)
hold on

set(gcf, 'PaperPositionMode', 'auto'); % Hace que la figura ocupe toda la página
set(gca, 'LooseInset', get(gca, 'TightInset')); % Ajusta los márgenes de los ejes

n0 = find(t>= 0, 1);
n1 = find(t>= 1, 1);
n2 = find(t>= 5, 1);
n3 = find(t>= 15, 1);

plot(x, f(:,n0))
plot(x, f(:,n1))
plot(x, f(:, n2))
plot(x, f(:,n3))

legend({'t = 0', ' t = 1', ' t = 5', '  t = 15'}, 'Interpreter', 'latex'); 
grid on;

xlabel('$x$');
ylabel('$f$');

title('Periodic Boundary Conditions, [$\alpha = 1.2$, $\vec U = -0.6$]', 'Interpreter', 'latex');



% print(2, 'Periodic', '-dpng', '-r600');%, '-0r60'