function [fitness, y, u, err] = ballbeam(X, A)
    kp = X(1); kd = X(2); kdd = X(3);
    B = 0.7; G = 9.81; dt = 0.001; t = 10;

    if A==1
        init_condition = 0.0564;
    elseif A==2
        init_condition = 0.1129;
    elseif A==3
        init_condition = 0.1698;
    end
    
    fitness = 0;
    yd = zeros(t/dt + 1);
    n = 0;
    for i = 0:dt:t
        n = n + 1;
        yd(n) = A*cos(pi*i/5);
    end
    x4 = 0;
    x3 = init_condition;
    x2 = 0;
    y = zeros(t/dt+1, 1);
    err = zeros(t/dt+1, 1);
    u = zeros(t/dt, 1);
    y(1) = A;
    e0 = 0;
    de0 = 0;
    for i = 1:t/dt
        e = y(i) - yd(i);
        err(i) = e;
        de = (e-e0)/dt;
        u(i) = kp*e + kd*(e-e0)/dt + kdd*(de-de0)/dt;
        if u(i) > 20
            u(i) = 20;
        elseif u(i) < -20
            u(i) = -20;
        end
        x4n = x4 + u(i)*dt;
        x3n = x3 + x4*dt;
        x2n = x2 + B*(y(i)*x4*x4 - G*sin(x3))*dt;
        y(i+1) = y(i) + x2*dt;
        x4 = x4n;
        x3 = x3n;
        x2 = x2n;
        e0 = e;
        de0 = de;
        fitness = fitness + e^2;
    end
    fitness = fitness/(t/dt);
    fitness = fitness^0.5;
    fitness = 1/(1+fitness);
end