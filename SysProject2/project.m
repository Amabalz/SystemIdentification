% choosing the parameters
clear all; clc;
load("iddata-11.mat");
na = 3;
nb = 1;
nk = 1;
m = 4;

% generation the matrix with powers
pow_matrix = powerGen(na+nb, m);

% the input and output of the identification data
u_id = id_array(:,2);
y_id = id_array(:,3);

% the input and output of the validation data
u_val = val_array(:,2);
y_val = val_array(:,3);

% computing phi for identification data
phi_id = compPhi(na, nb, u_id, y_id, pow_matrix);

% computing theta
theta = phi_id\y_id;

% computing phi for validation data
phi_val = compPhi(na, nb, u_val, y_val, pow_matrix);

% the one step ahead prediction for identification
y_hat_id = phi_id * theta;

% the one step ahead prediction for validation
y_hat_val = phi_val * theta;

% computing the MSE for prediction
mse_prediction = compMSE(y_hat_val, y_val);

% computing the simulation for identification
y_sim_id = compYSim(na, nb, u_id, pow_matrix, theta);

% computing the simulation for validation
y_sim_val = compYSim(na, nb, u_val, pow_matrix, theta);

% computing the MSE for simulation
mse_simulation = compMSE(y_sim_val, y_val);

f1 = figure;
movegui(f1, 'northwest');
title("Prediction for identification set");
hold on
plot(y_id, 'b');
plot(y_hat_id, 'r');
hold off

f2 = figure;
movegui(f2, 'southwest');
hold on
title("Prediction for validation set");
plot(y_val, 'b');
plot(y_hat_val, 'r');
hold off

f3 = figure;
movegui(f3, 'northeast');
hold on
title("Simulation for identification set");
plot(y_id, 'b');
plot(y_sim_id, 'r');
hold off

f4 = figure;
movegui(f4, 'southeast');
hold on
title("Simulation for validation set");
plot(y_val, 'b');
plot(y_sim_val, 'r');
hold off