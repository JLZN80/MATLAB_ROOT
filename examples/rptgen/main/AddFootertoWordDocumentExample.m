%% Add Footer to Word Document  
% This example defines first, even, and odd page footers in a Word document.
% It inserts a page number in each footer, using a different alignment for
% each page type.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','docx');
open(d);

% Create page footer objects for each type of page 
% Assign a matrix of page footer objects to the current page layout 
firstfooter = DOCXPageFooter('first');
evenfooter = DOCXPageFooter('even');
oddfooter = DOCXPageFooter('default');
d.CurrentPageLayout.PageFooters = [firstfooter,evenfooter,oddfooter];

% Add title to first page footer 
p = Paragraph('My Document Title');
p.HAlign = 'center';
append(d.CurrentPageLayout.PageFooters(1),p);

% Add page number to even page footer
% Align even page numbers left
pg2 = Page();
p2 = Paragraph();
p2.HAlign = 'left';
append(p2,pg2);
append(d.CurrentPageLayout.PageFooters(2),p2);

% Add page number to odd page footer
% Align odd page numbers right
pg3 = Page();
p3 = Paragraph();
p3.HAlign = 'right';
append(p3,pg3);
append(d.CurrentPageLayout.PageFooters(3),p3);

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