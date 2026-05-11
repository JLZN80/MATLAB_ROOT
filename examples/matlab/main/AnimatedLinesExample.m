%% Creating Line Animations
% This example shows how to use |animatedline| to create an animation of a line 
% that gets longer in every frame.
% 
% Copyright 2014-2017 The MathWorks, Inc.
%% Create an Animated Line
% The |animatedline| function creates an object that is designed specifically 
% for line animations. Initially, the animated line object is empty, so MATLAB® 
% does not plot the line.
%%
N = 30;
x = linspace(0,20,N);
y = x - 0.05*x.^2;

figure
l = animatedline
%% Add Points to Animated Line
% Use |addpoints| to add an additional point or vector of points to the animated 
% line. MATLAB adds the additional points onto your animated line making your 
% line longer.
%%
addpoints(l,x(1:5),y(1:5))    % add first 5 points to the line
%% Create Line Animation
% Use |addpoints| within a loop to create a line animation. To control the speed 
% of your line animation, use |pause| after you add a point or a set of points. 
% To prevent the limits of the axes from changing with each added set of points, 
% set the x and y limits before the loop.
%%
xlim([0 20])    % set x limits
ylim([0 5])     % set y limits

for ix = 5:5:N-5
    addpoints(l,x(ix+1:ix+5),y(ix+1:ix+5))    % add the next 5 points
    drawnow                                   % refresh the image on screen
    pause(0.2)                                % control animation speed
    snapnow                                   % (required for published document only)
end
%% Customize Animated Line Appearance
% The |animatedline| function accepts optional input arguments to specify the 
% properties of the line, such as |Color|, |Marker|, and |LineStyle|. To change 
% the properties of the animated line after its created, use dot notation syntax 
% |object.PropertyName|.
%%
l2 = animatedline('Color','r');
addpoints(l2,x(1:5),y(1:5))
l2.Marker = '*';
%% Get Points from Animated Line
% Use the function |getpoints| to return the coordinates of all the points in 
% the animated line.
%%
[x,y] = getpoints(l2)
%% Get All Properties of Animated Line
% Graphics objects in MATLAB have many properties. To see all the properties 
% of an animated line object, use the |get| command.
%%
get(l2)

