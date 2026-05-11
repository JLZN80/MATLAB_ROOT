%% Create Container for Word Report Formatting  

%% 
% Create a container object. Word output ignores the HTML container element
% tag (in this example, the |div| tag). 
import mlreportgen.dom.*;
rpt = Document('MyReport','docx');
 
c = Container();  

%% 
% Color all of the container text red. 
c.Style = {Color('red')};  

%% 
% Append content to the container and append the container to the report. 
append(c,Paragraph('Hello'));
append(c,Table(magic(5)));
append(rpt,c);  

%% 
% Close and generate the report. 
close(rpt);      
rptview(rpt.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.