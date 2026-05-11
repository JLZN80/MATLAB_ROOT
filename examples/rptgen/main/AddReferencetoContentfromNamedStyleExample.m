%% Add Reference to Content from Named Style  
% This example shows how to specify a style name for the contents of the
% reference. This example creates two |StyleRef| objects: one that uses
% the default value (|Heading1| objects) and one that uses the content of
% a paragraph formatted with the |Subtitle| style name. You insert both
% objects in the footer so that the footer contains text in the form |[Most
% Recent Heading1 Name]: [Most Recent Subtitle Name]|.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','docx');
open(d);

% Create page footer
footer = DOCXPageFooter('default');
d.CurrentPageLayout.PageFooters = footer;

% Create two StyleRef objects. ref uses content of Heading1 objects;
% ref2 uses content of paragraphs that use Subtitle style name.
ref = StyleRef();
ref2 = StyleRef('Subtitle');

% Assemble the footer text
footpara = Paragraph();
footpara.WhiteSpace = 'preserve';
append(footpara,ref);
append(footpara,': ');
append(footpara,ref2);
append(footer,footpara);

% Create Heading1 and Subtitle paragraphs
% Footers update based on most recent values
h = Heading1('My Document Title');
sub = Paragraph('Subtitle Text');
sub.StyleName = 'Subtitle';
p = Paragraph('Here''s some text.');
append(d,h);
append(d,sub);
append(d,p);

sub2 = Paragraph('Another Subtitle');
sub2.StyleName = 'Subtitle';
sub2.Style = {PageBreakBefore(true)};
append(d,sub2);
append(d,clone(p));

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.