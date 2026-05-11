%% Create a Word Document  
% Create a Word document, add content, and view the report in Word.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','docx');

append(d,'Hello World');

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.