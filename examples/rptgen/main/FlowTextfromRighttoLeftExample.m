%% Flow Text from Right to Left  
% In this example, changing the text flow direction changes &#8220;stressed&#8221; into
% &#8220;desserts&#8221;.   

%%  
import mlreportgen.dom.*;
doctype = 'docx';
d = Document('test',doctype);

p = Paragraph('desserts');
p.Style = {FlowDirection('rtl')};
append(d,p);

q = clone(p);
q.Style = {FlowDirection('ltr')};
append(d,q);

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.