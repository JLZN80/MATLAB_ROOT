%% Record Frames and Play Movie

% Copyright 2015 The MathWorks, Inc.


%%
% Use the |getframe| function in a loop to record frames of the |peaks|
% function vibrating. Preallocate an array to store the movie frames.

figure 
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';


loops = 40;
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    F(j) = getframe;
end

%% 
% To play the movie two times, use |movie(F,2)|.

