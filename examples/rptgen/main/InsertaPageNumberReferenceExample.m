%% Insert a Page Number Reference  
% This example inserts a page number reference to a target on another page.
% Add a target |mytarget| using |LinkTarget|. Use |PageRef| to refer to
% the page that contains the target |mytarget|.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','pdf');
open(d);

% Create page footer and add page number to it
footer = PDFPageFooter('default');
d.CurrentPageLayout.PageFooters = footer;
d.CurrentPageLayout.FirstPageNumber = 1;
pageno = Paragraph();
pageno.HAlign = 'center';
append(pageno,Page());
append(footer,pageno);

% Add target to heading object and append heading and para text to document
h = Heading1(LinkTarget('mytarget'));
append(h,'Head Whose Page to Reference');
p = Paragraph('Here is some paragraph text.');
append(d,h);
append(d,p);

% Add another page and insert page reference to target
p1 = Paragraph('The following paragraph contains the page reference.');
p1.Style = {PageBreakBefore(true)};
p2 = Paragraph('See Page ');
p2.WhiteSpace = 'preserve';
ref = PageRef('mytarget');
append(p2,ref);
append(p2,'.');
append(d,p1);
append(d,p2);

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.