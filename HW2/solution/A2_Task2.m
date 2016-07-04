Xorg = load('A2T2x.dat');
y = load('A2T2y.dat');

% some preprocessing steps
% determine number of samples
n = size(y,1);

% add intercept variable for multivariate linear regression
X = [ones(n,1), Xorg];

% normalize data (notice that the columns of my_X have vastly different
% magnitzdes. Normalizing the data increases performance of gradient descent)

sigma = std(X); % compute standard deviation
mu = mean(X);   % compute mean

mu(1) = 0;
X = X - ones(n, 1) * mu;
sigma(1) = 1;
X = X ./ (ones(n, 1) * sigma);

%%%%%%%%%%%%%%%%%%%%%%%%%
% you code goes here:
betaNew = [0,0,0]'; 										% Starting point of beta
c = 0.9;													% c value
epsilon = 10e-6;											% Threashold value for norm comparison
fun = @(x) (X * x - y)' * (X * x - y) / (2 * n);			% Objective function
gradientBeta = @(x) X' * (X * x - y) / n;					% Gradient
constraint = @(b, a, h) fun(b) + a * c * (-h' * h) ...		% Armijo contition
			- fun(b + a * h);

count = 0;
while count < 5
	stepLength = 1;
	h = - gradientBeta(betaNew);									% Search direction
	while constraint(betaNew, stepLength, h) < 0 	% If Armijo condition is fulfilled
		stepLength = stepLength * 3 / 4;							  	% If not, decrease the steplength
	end
	betaPre = betaNew;
	betaNew = betaPre + stepLength * h;								  	% Refresh the trainning model
    Diff = norm(betaPre - betaNew);							% Check difference between the model
	if Diff < epsilon
		count = count + 1;
	else
		count = 0;
	end
end

disp('The beta is');
disp(betaNew);
%   beta is 1.0e+05 * [3.4041, 1.1063, -0.0665]'
xx = ([1 1850 3] - mu) ./ sigma;
disp('The price of the flat is');
disp(xx * betaNew);
% The price of flat is 3.2092e+05