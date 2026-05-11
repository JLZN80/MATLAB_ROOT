%% Add a Table of Contents  
% Add an automatically generated table of contents and set the outline level
% of the &#8220;Glossary&#8221; paragraph so that the paragraph appears at the top level
% of the table of contents. This example uses the default DOM Word template.   

%% 
% Create a document and document part for the table of contents. The document
% part uses the |ReportTOC| building block from the default DOM Word template. 
import mlreportgen.dom.*
d = Document('tocDoc','docx');
open(d);

dp = DocumentPart(d,'ReportTOC');
append(d,dp);  

%% 
% Set the |OutlineLevel| property internally, so that there are four levels
% in the table of contents. 
for i = 1:4
    % set internally the OutlineLevel property
    append(d,Heading(i,'My Chapter'));
    append(d,Paragraph('chapter content....'));
end  

%% 
% Use |OutlineLevel| to set the level of the |Glossary| paragraph to |1|,
% so that the paragraph appears at the top level of the table of contents.
% Display the report. 
para = append(d,Paragraph('Glossary'));
para.Style = {OutlineLevel(1)};

close(d);
rptview(d.OutputPath,d.Type);   



%% 
% Copyright 2012 The MathWorks, Inc.