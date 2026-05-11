%% Create a Page Break Before a Heading  
% This example shows how to apply the |PageBreakBefore| property to a heading
% paragraph. The example uses two approaches for applying properties. The
% first creates a |PageBreakBefore| object whose value is explicitly true.
% You can then assign that format object to the heading&#8217;s |Style| property.
% The second approach sets the property on the heading object without explicitly
% creating a |PageBreakBefore| object.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','docx');
open(d);

% Create first page text
t = Heading(1,'Document Title','Title');
h = Heading(2,'My Head','Heading1');
p = Paragraph('Hello World');

append(d,t);
append(d,h);
append(d,p);

% Create a heading paragraph h1
% Create a PageBreakBefore object and set it as a Style property on h1
h1 = Heading(2,'My Second Head','Heading1');
br = {PageBreakBefore(true)};
h1.Style = br;
p1 = Paragraph('Another page');

% Create a heading paragraph h2
% Set the h2 Style property to use PageBreakBefore set to true
h2 = Heading(2,'My Third Head','Heading1');
h2.Style = {PageBreakBefore()};
p2 = Paragraph('My third page');

append(d,h1);
append(d,p1);
append(d,h2);
append(d,p2);

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.