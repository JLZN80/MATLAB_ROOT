%% Append a Word Document to a Report  

%%  
import mlreportgen.dom.*

info = Document('CompanyInfo','docx');
append(info,'XYZ, Inc., makes widgets.');
close(info);

infoPath = info.OutputPath;

rpt = Document('Report','docx');
open(rpt);

append(rpt,Paragraph('About XYZ, Inc.'));

append(rpt,DOCXSubDoc(infoPath));

close(rpt);
rptview(rpt.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.