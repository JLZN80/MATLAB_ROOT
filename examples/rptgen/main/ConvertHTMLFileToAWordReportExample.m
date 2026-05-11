%% Convert HTML File to a Word Report  
% This example shows how to convert an existing HTML file to a Word report.
%%
% Create a text file named |myHTMLReport.html| and save it in the current 
% folder. Add this text into the file.
%
%  <html>
%  <head>
%  <style>p {font-size:14pt;}</style>
%  </head>
%  <body>
%  <p style="white-space:pre"><b>Hello</b><i style="color:green">World</i></p>
%  <p>This is <u>me</u> speaking</p>
%  </body>
%  </html>

%%
% Run these commands to convert the |myHTMLReport.html| file to a Word 
% report.
%
%  import mlreportgen.dom.*;
%  rpt = Document('MyReport','docx');
%  htmlFile = HTMLFile('myHTMLReport.html');
%  append(rpt,htmlFile);
%  close(rpt);
%  rptview(rpt.OutputPath);

%% 
% The resulting Word report contains the text you specified in the HTML file.
%
% <<../dom_html_class_example.png>>

%% 
% Copyright 2012 The MathWorks, Inc.