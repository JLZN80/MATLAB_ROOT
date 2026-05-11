%% Create Three Levels of Headings  
% This example shows how to add three levels of headings, each formatted
% according to its level. This example inserts three heading objects into
% a document: a |Heading1|, a |Heading2|, and a |Heading3|.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','docx');
open(d);

title = append(d, Paragraph('Document Title'));
title.Bold = true;
title.FontSize = '28pt';

h1 = append(d,Heading1('Chapter 1'));
h1.Style = {PageBreakBefore(true)};
p1 = append(d,Paragraph('Hello World'));

h2 = append(d,Heading2('Section 1.1'));
p2 = append(d,Paragraph('Text for this section.'));

h3 = append(d,Heading3('My Subsection 1.1.a'));
p3 = append(d,Paragraph('Text for this subsection'));

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.