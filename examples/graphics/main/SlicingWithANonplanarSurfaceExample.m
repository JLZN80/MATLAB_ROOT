%% Slicing with a Nonplanar Surface
% You can slice the volume with any surface. This example probes the volume 
% created in the previous example by passing a spherical slice surface through 
% the volume.
% 
% Starting in R2014b, you can use dot notation to set and query properties. 
% If you are using an earlier release, use the |get| and |set| functions instead, 
% such as |xd = get(hsp,'XData')|.

[x,y,z] = meshgrid(-2:.2:2,-2:.25:2,-2:.16:2);
v = x.*exp(-x.^2-y.^2-z.^2);
[xsp,ysp,zsp] = sphere;
slice(x,y,z,v,[-2,2],2,-2)
colormap hsv

for i = -3:.2:3
   hsp = surface(xsp+i,ysp,zsp);
   rotate(hsp,[1 0 0],90)
   xd = hsp.XData;
   yd = hsp.YData;
   zd = hsp.ZData;
   delete(hsp)
   hold on
   hslicer = slice(x,y,z,v,xd,yd,zd);
   axis tight 
   xlim([-3,3])
   view(-10,35)
   drawnow
   delete(hslicer)
   hold off
end

%% 
% Copyright 2012 The MathWorks, Inc.