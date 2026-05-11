%% Insert Current Page Number  
% This example uses |mlreportgen.dom.Page| to insert the current page number
% in the footer of a document.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','pdf');
open(d);

% Create page footer
footer = PDFPageFooter('default');
d.CurrentPageLayout.PageFooters = footer;

% Define page number string and add to footer.
d.CurrentPageLayout.FirstPageNumber = 1;
t = Text('Page '); 
pageinfo = Paragraph(); 
pageinfo.WhiteSpace = 'preserve';
pageinfo.HAlign = 'center';
append(pageinfo,t);
append(pageinfo,Page());
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