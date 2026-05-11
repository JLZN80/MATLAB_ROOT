%% Insert a Table of Contents into a Document  
% This example adds a table of contents to a document using a |TOC| object.
% This document contains three levels of heads&#8212;|Heading1|, |Heading2|, and
% |Heading3|. Because the |TOC| object specifies only two heading levels,
% |Heading3| is not included in the TOC. The leader is a space.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','pdf');
open(d);

title = append(d, Paragraph('My TOC Document'));
title.Bold = true;
title.FontSize = '28pt';

toc = append(d,TOC(2,' '));
toc.Style = {PageBreakBefore(true)};

h1 = append(d,Heading1('Chapter 1'));
h1.Style = {PageBreakBefore(true)};
p1 = append(d,Paragraph('Hello World'));

h2 = append(d,Heading2('Section 1.1'));
h2.Style = {PageBreakBefore(true)};
p2 = append(d,Paragraph('Another page'));

h3 = append(d,Heading3('My Subsection 1.1.a'));
p3 = append(d, Paragraph('My Level 3 Heading Text'));

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.