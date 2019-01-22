clc;
close all;
clc;

data = load('ex1data1.txt');
X = data(:, 1); y = data(:, 2);
m = length(X)
X = [ones(m, 1), data(:,1)];
theta = zeros(2, 1);

J = (X*theta - y)' * (X*theta - y)/(2*m);

J = computeCost(X, y, [-1 ; 2]);

J

iterations = 1500;
alpha = 0.01;

theta = gradientDescent(X, y, theta, alpha, iterations);

theta

%plot(X(:,2), X*theta, '-')

theta0_vals = linspace(-10, 10, 100);
theta1_vals = linspace(-1, 4, 100);
J_vals = zeros(length(theta0_vals), length(theta1_vals));

for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
	  t = [theta0_vals(i); theta1_vals(j)];
	  J_vals(i,j) = computeCost(X, y, t);
    end
end

J_vals = J_vals';

figure;
surf(theta0_vals, theta1_vals, J_vals)
xlabel('\theta_0'); ylabel('\theta_1');

contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 20))
xlabel('\theta_0'); ylabel('\theta_1');
hold on;
plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
