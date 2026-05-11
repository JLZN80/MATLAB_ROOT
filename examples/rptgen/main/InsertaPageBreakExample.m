%% Insert a Page Break  
% This example shows how to force a page break by inserting a |PageBreak|
% object into a PDF report.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','pdf');
open(d);

% Create first page
h = Heading1('My First Head');
p = Paragraph('Here are some paragraphs.');
append(d,h);
append(d,p);
append(d,clone(p));
append(d,clone(p));
append(d,clone(p));
append(d,clone(p));
append(d,clone(p));

% Create and append the page break object
br = PageBreak();
append(d,br);

% Create paragraphs that appear on the page after the break
p2 = Paragraph('Here are some paragraphs after the forced page break.');
append(d,p2);
append(d,clone(p2));
append(d,clone(p2));
append(d,clone(p2));
append(d,clone(p2));

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.