%% Add Reference to Heading1 Content in a Footer  
% This example uses an outline level to specify the content of a running
% footer.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','pdf');
open(d);

% Create page footer
footer = PDFPageFooter('default');
d.CurrentPageLayout.PageFooters = footer;

% Define and the StyleRef object using default (first level heading)
% Append it to the footer
ref = StyleRef();
append(footer,ref);

% Create several pages
% The footer content changes based on the last Heading1 object
h = Heading1('My First Head');
p = Paragraph('The above heading appears in the footer because it is a level 1 head.');
append(d,h);
append(d,p);

h2 = Heading1('My Next Head');
h2.Style = {PageBreakBefore(true)};
p2 = Paragraph('Now the above heading appears in the footer.');

append(d,h2);
append(d,p2);

h3 = Heading1('My Third Head');
h3.Style = {PageBreakBefore(true)};
append(d,h3);
append(d,clone(p2));

p3 = Paragraph(['Because I have not added another Heading1 object '...
    'since the last one, the heading from the previous page appears in the footer.']);
p3.Style = {PageBreakBefore(true)};
append(d,p3);

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.