%% Record Movie and Play Back Movie
%% Code

for k = 1:16
	plot(fft(eye(k+16)))
	axis([-1 1 -1 1])
	M(k) = getframe;
end
%% 
% Copyright 2015 The MathWorks, Inc.
