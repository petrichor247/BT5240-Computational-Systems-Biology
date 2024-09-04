%% INITIAL CONDITIONS 

A_0 = 0.01;
B_0 = 10;
C_0 = 0.1;
D_0 = 10;
E_0 = 0.1;

%% TIME INTERVALS

tlast2a = 1000;
tlast2b = 1000;
tlast2c = 5000;

%% ODE SOLVER

[t2a, y2a] = ode45(@system2a, [0 tlast2a], [A_0; B_0; C_0]);
[t2b, y2b] = ode45(@system2b, [0 tlast2b], [A_0; B_0; C_0; D_0]);
[t2c, y2c] = ode45(@system2c, [0 tlast2c], [A_0; B_0; C_0; D_0; E_0]);

%% PLOTS

figure()
plot(t2a, y2a, 'r');
title('Three node repressilator simulated for 1000 points')
xlabel('time points')
ylabel('gene expression levels')

figure()
plot(t2b, y2b, 'b');
title('Four node repressilator simulated for 1000 points')
xlabel('time points')
ylabel('gene expression levels')

figure()        
plot(t2c, y2c, 'g');
title('Five node repressilator simulated for 5000 points')
xlabel('time points')
ylabel('gene expression levels')

%% SYSTEM OF EQUATIONS 2(a)

function diff = system2a(t, x) 

    g = 50;
    k = 0.05;

    A = x(1);
    B = x(2);
    C = x(3);
    
    dA_dt = g*hills(C) - k*A;
    dB_dt = g*hills(A) - k*B;
    dC_dt = g*hills(B) - k*C;

    diff = [dA_dt; dB_dt; dC_dt];
end

%% SYSTEM OF EQUATIONS 2(b)

function diff = system2b(t, x)

    g = 50;
    k = 0.05;

    A = x(1);
    B = x(2);
    C = x(3);
    D = x(4);

    dA_dt = g*hills(D) - k*A;
    dB_dt = g*hills(A) - k*B;
    dC_dt = g*hills(B) - k*C;
    dD_dt = g*hills(C) - k*D;

    diff = [dA_dt; dB_dt; dC_dt; dD_dt];
end

%% SYSTEM OF EQUATIONS 2(c)

function diff = system2c(t, x)    

    g = 50;
    k = 0.05;

    A = x(1);
    B = x(2);
    C = x(3);
    D = x(4);
    E = x(5);

    dA_dt = g*hills(E) - k*A;
    dB_dt = g*hills(A) - k*B;
    dC_dt = g*hills(B) - k*C;
    dD_dt = g*hills(C) - k*D;
    dE_dt = g*hills(D) - k*E;

    diff = [dA_dt; dB_dt; dC_dt; dD_dt; dE_dt];
end

%% HILL EQUATION

function eq = hills(M)
    lambda = 0.001;
    M_0 = 10;
    n = 2;
    eq = (lambda * (M^n) + (M_0^n))/((M^n)+(M_0^n));
end


