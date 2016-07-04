function [stepLength] = get_step_length_sphere(x, searchDirection, M)
%GET_STEP_LENGTH_SPHERE Summary of this function goes here
%   Detailed explanation goes here
	stepLength = 1;
	while ~ifAmijoSatisfied(x, searchDirection, stepLength, M)
	    stepLength = stepLength * 0.75;
	end
end
function amijoSatisfied = ifAmijoSatisfied(x, h, stepLength, M)
	c = 0.9;
	matrixLength = size(M, 1);
	objFunc = @(x) 0.5 * ((M - eye(matrixLength)) * x)' * ((M - eye(matrixLength)) * x);
	amijo_condition = @(x, a, h) objFunc(x) + a * c * (-h' * h) >= objFunc(x + a * h);
	amijoSatisfied = amijo_condition(x, stepLength, h);
end