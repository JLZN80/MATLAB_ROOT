%% Slice at Arbitrary Angles
% Create slices that are oriented in arbitrary planes. To do this:
%%
% 
% * Create a slice surface in the domain of the volume.
% * Orient this surface with respect to the axes.
% * Get the |XData|, |YData|, and |ZData| of the surface.
% * Use this data to draw the slice plane within the volume.
% 
% Starting in R2014b, you can use dot notation to set and query
% properties. If you are using an earlier release, use the |set| and |get|
% functions instead, such as |xd = get(hsp,'XData')|.

[x,y,z] = meshgrid(-2:.2:2,-2:.25:2,-2:.16:2);
v = x.*exp(-x.^2-y.^2-z.^2);
figure
colormap hsv

for k = -2:.05:2
   hsp = surf(linspace(-2,2,20),linspace(-2,2,20),...
      zeros(20) + k);
   rotate(hsp,[1,-1,1],30)
   xd = hsp.XData;
   yd = hsp.YData;
   zd = hsp.ZData;
   delete(hsp)
   
   slice(x,y,z,v,[-2,2],2,-2) 
   hold on
   slice(x,y,z,v,xd,yd,zd)
   hold off
   view(-5,10)
   axis([-2.5 2.5 -2 2 -2 4])
   drawnow
end

%% 
% Copyright 2012 The MathWorks, Inc.