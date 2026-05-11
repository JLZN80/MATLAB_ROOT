%% Use FO Property to Break a Page on List  
% This example shows how to apply an FO property to a |List| object. Using
% the DOM API, you can set a page break property on a paragraph using |PageBreakBefore|.
% However, you cannot use the |PageBreakBefore| property on a list. Instead,
% for PDF output, you can use the FO property |'break-before'| with the
% value |'page'|.   

%%  
import mlreportgen.dom.*

d = Document('Break Before List','pdf');

listbreak = FOProperty('break-before','page');
p = Paragraph('First Page');
p.Style = {PageBreakBefore};
append(d,p);

p = Paragraph('Second Page');
p.Style = {PageBreakBefore};
append(d,p);

list = UnorderedList({'Earl Grey','Jasmine','Honeybush'});
list.Style = {FOProperties(listbreak)};
append(d,list);

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.