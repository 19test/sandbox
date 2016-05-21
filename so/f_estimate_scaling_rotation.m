%------------------------------------------------------------------------------
% Determines scale and translation between point sets x and x', ie x = Ax
%
%
function [scale theta] = f_estimate_scaling_rotation(reference_points, observed_points)

	% Get sizes and verify input sanity
	[Npts   two] = size(reference_points);  assert(two == 2);
	[NObpts two] = size(observed_points );  assert(two == 2);

	assert(Npts == NObpts);

	if (numel(find(reference_points == observed_points)) == Npts*2)
	    scale = 1;
	    theta = 0;
	    return;
	end

	M = zeros(2*Npts, 2);
	y = zeros(2*Npts, 1);
	for i=1:Npts

		% Two equations per pair of points
		M(2*i-1, 1) = reference_points(i, 2);
		M(2*i-1, 2) = reference_points(i, 1);
		y(2*i-1)    =  observed_points(i, 2);
		
		M(2*i,   1) =  reference_points(i, 1);
		M(2*i,   2) = -reference_points(i, 2);
		y(2*i)      =   observed_points(i, 1);

	end


	% params(1) = scale * cos(theta); params(2) = scale * sin(theta); 
	params = inv(M'*M)*M'*y;

	% Verify 
	[two one] = size(params);
	assert(two == 2); assert(one == 1);

	% Extract scaling using (cos^2 t + sin^2 t == 1)
	scale = 1/sqrt(params(1)^2 + params(2)^2);

	% See wikipedia
	tan_theta = params(2) / params(1);
	theta = atan(tan_theta);