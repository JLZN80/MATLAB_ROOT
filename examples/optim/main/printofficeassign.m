function printofficeassign(x)
%PRINTOFFICEASSIGN creates a figure with the result of the assignment problem.
% This is a helper function for the demo officeassign.

%   Copyright 1990-2015 The MathWorks, Inc.

offices = [.1,.73;
    .35 .73;
    .60 .73;
    .85 .73;
    .35 .42;
    .60 .42;
    .85 .42];

xoffset = -.07;yoffset = -.1;
figure
hold on
axis off
axis([0.03,1.03,0.1806,0.9694]) % equivalent to axis equal
set(gcf,'color','w');
title('Office layout: windows are red lines'); 

for ii = 1:size(offices,1)
    rectangle('Position',[offices(ii,1)+xoffset,offices(ii,2)+yoffset,.25,.2],...
    'Clipping','off')
    text(offices(ii,1),offices(ii,2),x{ii})
end

line([offices(5,1)+xoffset+.12,offices(5,1)+xoffset+.2],...
    [offices(5,2)+yoffset,offices(5,2)+yoffset],'LineWidth',3,'Color','r')
line([offices(6,1)+xoffset+.05,offices(6,1)+xoffset+.2],...
    [offices(6,2)+yoffset,offices(6,2)+yoffset],'LineWidth',3,'Color','r')
line([offices(7,1)+xoffset+.05,offices(7,1)+xoffset+.2],...
    [offices(7,2)+yoffset,offices(7,2)+yoffset],'LineWidth',3,'Color','r')
hold off