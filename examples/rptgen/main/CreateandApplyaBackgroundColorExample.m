%% Create and Apply a Background Color  
% Create a deep sky blue background color object and apply it to a paragraph.
% Instead of specifying the CSS color name |DeepSkyBlue|, you can use the
% hexadecimal value |#00bfff|.   

%%  
import mlreportgen.dom.*;
     doctype = 'html';
     d = Document('test',doctype);
     blue = 'DeepSkyBlue';
     % blue = '#00BFFF';
     colorfulStyle = {Bold,Color(blue),BackgroundColor('Yellow')};
     p = Paragraph('deep sky blue paragraph with yellow background');
     p.Style = colorfulStyle;
     append(d,p);
     close(d);
     rptview('test',doctype);   



%% 
% Copyright 2012 The MathWorks, Inc.