
% Copyright 2015 The MathWorks, Inc.

function f = createFigure
f = figure;
ax = axes('Parent', f);
cylinder(ax,10)
h = findobj(ax,'Type','surface');
h.FaceColor = [1 0 0];
end