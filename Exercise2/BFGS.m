A = [2, 3, 0, 1; 0, 7, 3, 0; 1, 3, 1, 1; 1, 1, 0, 1];
c = 0.9;
objectivFunc = @(X) trace((A * X - eye(size(A, 1)))' * (A * X - eye(size(A, 1))));
gradientObj = @(X) 2 * A' * (A * X - eye(size(A, 1)));
constraint = @(b, a, h) objectivFunc(b) + a * c * (-h' * h) - objectivFunc(b + a * h); % Armijo contition

Xk = rand(4, 4);
Bk = eye(size(A, 1));
epsilon = 10e-15;
error = inf;


while norm(error) >= epsilon
    pk = - inv(Bk) * gradientObj(Xk);
	stepLength = 1;
	while constraint(Xk, stepLength, -gradientObj(Xk)) < 0 	% If Armijo condition is fulfilled
		stepLength = stepLength * 3 / 4;							  	% If not, decrease the steplength
    end
	XkPlus1 = Xk + stepLength * pk;
	Sk = stepLength * pk;
	Yk = gradientObj(XkPlus1) - gradientObj(Xk);
	BkPlus1 = Bk - (Bk * Sk * Sk' * Bk) / trace(Sk' * Bk * Sk) + (Yk * Yk') / trace(Yk' * Sk);
	Bk = BkPlus1;
	error = XkPlus1 - Xk;
	disp(norm(error));
    Xk = XkPlus1;
end

disp(Xk);