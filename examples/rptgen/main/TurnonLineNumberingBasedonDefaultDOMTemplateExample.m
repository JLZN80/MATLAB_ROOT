%% Turn on Line Numbering Based on Default DOM Template  
% In this example, the |RawFormats| property of the |CurrentPageLayout|
% object is initialized with the markup for properties specified by the
% default template. This code appends the line numbering property to the
% existing properties.   

%%  
import mlreportgen.dom.*;
d = Document('myreport','docx');
open(d); 

s = d.CurrentPageLayout;
s.RawFormats = [s.RawFormats ...
{'<w:lnNumType w:countBy="1" w:start="0" w:restart="newSection"/>'}];
p = Paragraph('This document has line numbers');
append(d,'This document has line numbers');
append(d,clone(p));

close(d);
rptview(d.OutputPath);     



%% 
% Copyright 2012 The MathWorks, Inc.