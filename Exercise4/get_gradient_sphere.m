function [ gradientSphere ] = get_gradient_sphere(x, M)
%GET_GRADIENT_SPHERE Summary of this function goes here
%   Detailed explanation goes here
matrixLength = size(M, 1);
gradient = @(x) (M - eye(matrixLength))' * (M - eye(matrixLength)) * x;
gradientSphere = (eye(length(x)) - x * x') * gradient(x);

end