% ----------------------------------------------------------------------------
% Shows the tho images side by side with lines between matching feature points
%
%
function m_plotMatchLines(im1, im2, f1, f2, match)
	
	%	Make composite image
	im3 = m_appendImages(im1, im2);

	%	Show a figure with lines joining the matching features f1 and f2 as detemined by the indices
	% 	in the 2xn array match.
	%
	figure('Position', [100 100 size(im3, 2) size(im3, 1)]);
	colormap('gray');
	imshow(im3, []);
	hold on;
	cols1 = size(im1, 2);
	for i = 1: size(match, 2)
	    line([f1(1, match(1, i)) f2(1, match(2, i))+cols1], ...
	         [f1(2, match(1, i)) f2(2, match(2, i))], 'color', [0 0 1]);
		plot(f1(1, match(1, i)), f1(2, match(1, i)), 'g+'); hold on;
		plot(f2(1, match(2, i))+cols1, f2(2, match(2, i)), 'r+');

	end
	hold off;
