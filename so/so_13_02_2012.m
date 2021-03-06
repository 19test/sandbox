% Small unit test with feature based registration
%
% Maurits Diephuis, Fokko Beekhof	
%
% Uses code and functions from	
%
% P. D. Kovesi.   MATLAB and Octave Functions for Computer Vision and Image Processing.
% Centre for Exploration Targeting
% School of Earth and Environment
% The University of Western Australia.
% Available from:
% http://www.csse.uwa.edu.au/~pk/research/matlabfns/. 
%
% VLFEAT toolbox, by A. Vedaldi and B. Fulkerson
% www.vlfeat.org
%
%

close all;
clear all;
clc;

% Read in images
% im1 = imread('images/ruaa_1.png');
% im2 = imread('images/ruaa_2.png');
im1 = imread('images/hoca_bw.png');
im2 = imread('images/ogrenci_bw.png');

	
% VLFEAT sift point determination
[f1, d1] = vl_sift(single(im1), 'PeakThresh', 0, 'edgethresh', 150);
[f2, d2] = vl_sift(single(im2), 'PeakThresh', 0, 'edgethresh', 150);

% Match the descriptor vectors via exhaustive nearest neighbor search
threshold = 1.5;
[match, scores] = vl_ubcmatch(d1, d2, threshold);

% Show the intial matches between the two images
m_plotMatchLines(im1, im2, f1, f2, match);

% Build a new dataset from initial matches
M1 = [f1(1, match(1, :)); f1(2, match(1, :)); ones(1, length(match))];
M2 = [f2(1, match(2, :)); f2(2, match(2, :)); ones(1, length(match))];

% Apply RANSAC to find the affine transformation
t = 0.01;											%	Distance threshold for deciding outliers  
[H, inliers] = ransacfithomography(M2, M1, t);		%	RANSAC

% RANSAC results
inPercentage = round(100*length(inliers)/length(M1));
fprintf('Number of inliers is %d (%d%%) \n', length(inliers), inPercentage);

% Show RANSAC results
m_plotMatchLines(im1, im2, [M1(1:2, :)], [M2(1:2, :)], repmat(inliers, [2 1]));

% Determine scale and rotation
[scale theta] = f_estimate_scaling_rotation(M2(1:2, inliers)', M1(1:2, inliers)');

fprintf('Found scale: %2.4f\n', scale);
fprintf('Found angle: %2.4f\n', theta);

% Optimization
scale_cos_theta = scale*cos(theta);
scale_sin_theta = scale*sin(theta);

% Build affine matrix
M_correct = [scale_cos_theta, -scale_sin_theta; scale_sin_theta,  scale_cos_theta];		
A2 = [scale*cos(theta) scale*sin(theta) 0; -scale*sin(theta) scale*cos(theta) 0; 0 0 1];
TFORM = maketform('affine', A2);

% Correct scaling and rotation		
transIm	= imtransform(im2, TFORM, 'nearest', 'XData', [1 size(im1, 2)], 'YData', [1 size(im1, 1)]);	

% Correct translation, this not done based on features
[y_offset, x_offset] = m_translation_offset(im1, transIm);
fprintf('Found y-x offset is %d by %d\n', y_offset, x_offset);
	
% Final translation correction
transIm = circshift(transIm, [-y_offset -x_offset]);

% Show and tell
figure;imagesc(im2-im1);title('original');
figure;imagesc(im1-transIm);title('registered');
