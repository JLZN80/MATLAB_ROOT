%% Hide Text in a Paragraph  
% In Word, make sure the *File*  > *Options* > *Display*  > *Hidden text*
% option is cleared. This is the default setting.   

%%  
% 
%  import mlreportgen.dom.*;
%  rpt = Document('MyDispRep','docx');
%  
%  t1 = Text('Hello');
%  t1.Style = {Display('none')};
%  
%  p1 = Paragraph();
%  append(p1,t1);
%  t2 = Text('World');
%  append(p1,t2);
%  append(rpt,p1);
%  
%  close(rpt);
%  rptview('MyDispRep','docx');   



%% 
% Copyright 2012 The MathWorks, Inc.