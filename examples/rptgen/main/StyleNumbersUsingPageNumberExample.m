%% Style Numbers Using PageNumber  
% This example shows the syntax for using |PageNumber|, which you set using
% |PageNumber| as a style on the current page layout. For the numbering to 
% take effect, you need to insert a page number into a page footer or 
% header using |Page|,and you need to use a multilevel list style in the 
% Word template. For a complete example, see <docid:ml_rptgen_ug.bu7z02b-1 .>   

%%  
import mlreportgen.dom.*;
d = Document('mypages','docx');

open(d);
layout = d.CurrentPageLayout;

% Start on page 7 and use roman numerals
pagenumber = PageNumber(7,'I');

% Add page number object to page layout styles
layout.Style = [layout.Style {pagenumber}];

% Create the footer and add a page number to it
myfooter = DOCXPageFooter();
para = Paragraph();
para.HAlign = 'center';
append(para,Page());

% Add the page number to the footer
append(myfooter,para);
layout.PageFooters = myfooter;

% Add content
append(d,'Hello World')';

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.