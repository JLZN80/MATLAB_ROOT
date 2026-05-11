%% Insert Total Number of Pages  
% This example inserts the total number of document pages in a page footer.
% Use this class to display the current page number along with the total
% number of pages, such as Page 1 of 3.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','docx');
open(d);

% Create page footer
footer = DOCXPageFooter('default');
d.CurrentPageLayout.PageFooters = footer;

% Define page number and add to footer.
d.CurrentPageLayout.FirstPageNumber = 1;
t = Text('Page ');
t.WhiteSpace = 'preserve';
t1 = Text(' of ');
t1.WhiteSpace = 'preserve';
pageinfo = Paragraph();
pageinfo.HAlign = 'center';
append(pageinfo,t);
append(pageinfo,Page());
append(pageinfo,t1);
append(pageinfo,NumPages());
append(footer,pageinfo);

% Create several pages.
p = Paragraph('Hello World');
append(d,p);
p = Paragraph('Another page');
p.Style = {PageBreakBefore(true)};
append(d,p);
append(d,clone(p));

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.