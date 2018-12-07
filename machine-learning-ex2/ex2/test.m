clc;

data = load('ex2data1.txt');
X = data(:, [1, 2]); y = data(:, 3);



%plotData(X, y);

%xlabel('Exam 1 score')
%ylabel('Exam 2 score')

%legend('Admitted', 'Not admitted')

[m, n] = size(X);

X = [ones(m, 1) X];

initial_theta = zeros(n + 1, 1);

[cost, grad] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);

fprintf(' %f \n', grad);

options = optimset('GradObj', 'on', 'MaxIter', 400);

[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
  
fprintf('Cost at theta found by fminunc: %f\n', cost);

fprintf(' %f \n', theta);

plotDecisionBoundary(theta, X, y);
hold on;
% Labels and Legend
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% Specified in plot order
legend('Admitted', 'Not admitted')
hold off;