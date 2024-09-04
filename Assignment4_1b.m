%% PARAMETERS

G_0 = 12;
B_0 = 0.1;
mu = 0.35;
Y = 0.2;

%% DEFINING TIME POINTS AND GLUCOSE CONCENTRATION
t = linspace (0, 20, 1000);     
G_t = G_0 - (B_0/Y)*(exp(mu*t)-1);

%% PLOTTING

figure()
plot(t, G_t, 'r');
xlabel('time (h)');
ylabel('glucose concentration (mM)');
title('Glucose concentration vs time');
yline(0,'--')



