%{
MAE 294B HW 2 Last Question - Solving a Slide Crank Mechanism numerically
Michelle Zhou
Oct 8 2026
%}

%% Parameters
tol = 1e-6;             % error tolerance
theta_1 = 0;            % radians
theta_2 = deg2rad(60);  % radians
R1 = 0.18;              % meters
R2 = 0.06;
R3 = 0.15;
R4 = 0.08;
error_3 = 10;           % random initial value
error_4 = 10;
counter = 0;            % for my own info

%% Initial guess
theta_3 = 0.2;
theta_4 = 0.5;
xy = [theta_3; theta_4;];

%% Newton-Raphson
while (error_3 > tol || error_4 > tol)
    
    % Calculations
    f1 = R4*cos(theta_4) + R3*cos(theta_3) - R2*cos(theta_2) + R1;
    f2 = R4*sin(theta_4) + R3*sin(theta_3) - R2*sin(theta_2) + 0;
    f = [f1;f2];
    J = [-R3*sin(theta_3) -R4*sin(theta_4);
        R3*cos(theta_3) R4*cos(theta_4)];

    xy_new = - J\f + xy;                 % key iterative calculation

    error_3 = abs(xy_new(1) - xy(1));   % error calc
    error_4 = abs(xy_new(2) - xy(2));
    fprintf("Errors are %2.3f and %2.3f for theta_3 and theta_4 right now. \n", error_3, error_4)

    xy = xy_new;                        % update values for next loop
    theta_3 = xy(1);
    theta_4 = xy(2);
    counter = counter + 1;
end

%% Putting angles within [0, 2pi] range
while (theta_3 > 2*pi || theta_3 < 0)
    if (theta_3 < 0)
        theta_3 = theta_3 + 2*pi;
    else
        theta_3 = theta_3 - 2*pi;
    end
end

while (theta_4 > 2*pi || theta_4 < 0)
    if (theta_4 < 0)
        theta_4 = theta_4 + 2*pi;
    else
        theta_4 = theta_4 - 2*pi;
    end
end

xy = [theta_3; theta_4]

fprintf("Theta 3 is %2.2f degrees and Theta 4 is %2.2f degrees. \n", rad2deg(theta_3), rad2deg(theta_4))
fprintf("This took %2.0f iterations of Newton-Raphson to solve. \n", counter)