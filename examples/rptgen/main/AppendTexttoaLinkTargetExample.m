%% Append Text to a Link Target  
% This example creates a two-page document with a link to a target at the
% top of the document.   

%% 
% Create a link target |'home'| and append text to it. After a page break,
% create a link to the target, using |InternalLink|. The text for the link
% is |Go to top|. 
import mlreportgen.dom.*
d = Document('mydoc','pdf');

target = LinkTarget('home');
append(target,' - top of page');
append(d,target);

p = Paragraph('This is another paragraph');
p.Style = {PageBreakBefore(true)};
append(d,p);

append(d,InternalLink('home','Go to top'));

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.