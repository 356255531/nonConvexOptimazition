p = 0.15;
epsilon = 10e-2;

%% Load Data
load('Harvard500.mat');
A = Problem.A;
A = full(A);

%% Preprocessing
matrixLength = size(A, 1);
sumColumns = sum(A);
denominater = sumColumns;
denominater(find(denominater == 0)) = 1;
denominater = ones(matrixLength, 1) * denominater;
A = A ./ denominater;

w = zeros(1, matrixLength);
w(find(sumColumns == 0)) = 1;
AStar = A + ones(matrixLength, 1) * w / matrixLength;
B = ones(matrixLength, matrixLength) / matrixLength;
M = (1 - p ) * AStar + p * B;

%% Gradient Descend
x = rand(matrixLength, 1);
x = x / norm(x);
error = inf;
while error > epsilon
	gradientSphere = get_gradient_sphere(x, M);
	searchDirection = -gradientSphere;
	stepLength = get_step_length_sphere(x, searchDirection, M);
	x = x + stepLength * searchDirection;
	error = norm(gradientSphere);
    error
end
node = Problem.aux.nodename;
[~, index] = sort(x, 'descend');
node(index(1:10), :)