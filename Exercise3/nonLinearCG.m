function [xk]
	xK = xStart;
	gradientK = grad(x0);
	pK = -gradientK;
	k = 0;
	epsilon = 10e-6;

	while error > epsilon
		tk = armijo(objFun, pK);
		xKPlus1 = xK + pK * tk;
		gradientKPlus1 = grad(xKPlus1);
		beta = (gradientKPlus1' * gradientKPlus1) / (gradientK' * gradientK);
		pK = -gradientKPlus1 + beta * pK;
		k = k + 1;
		error
	end
end