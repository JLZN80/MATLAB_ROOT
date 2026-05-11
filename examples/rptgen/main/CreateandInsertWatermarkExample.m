%% Create and Insert Watermark  
% This example shows how to create a watermark programmatically and then
% apply it to the current layout. Creating the watermark programmatically
% simplifies files management, because you do not need to store the image
% file and keep track of its location.   

%% 
% Using MATLAB(R) commands, create an image file programmatically. Using
% an |SVG| image file maintains the resolution as the image scales. After
% you write the image to a file, you can delete the figure. 
 wmname = 'wm';
 wmtype =  'svg';
 wmfilename = [wmname '.' wmtype];
 
 subplot('Position',[0, 0, 1, 1]);
 axis('off');
 text(0.25, 0.25,'Draft', ...
   'Rotation', 45, ...
   'Color', [0.85, 0.85, 0.85], ...
   'FontSize',72);
  
  print(wmfilename, ['-d' wmtype]);
  delete(gcf);  

%% 
% Create the watermark object |wm| and apply it to the current page layout.
% After you generate the report, you can delete the image file specified
% by the variable |wmfilename|. 
import mlreportgen.dom.*;

d = Document('myreport','pdf');
open(d);

wm = Watermark(wmfilename);
wm.Width = '12in';
wm.Height = [];

d.CurrentPageLayout.Watermark = wm;

append(d,'Hello');
append(d, PageBreak);
append(d,'World');

close(d);
rptview(d.OutputPath);
delete(wmfilename);   



%% 
% Copyright 2012 The MathWorks, Inc.