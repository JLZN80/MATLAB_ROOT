%% Insert Leaders in a PDF Report  
% This example uses a dot leader and a space leader in a PDF report.   

%%  
import mlreportgen.dom.*;
d = Document('mydoc','pdf');
open(d);

h = Heading1('Cast');
h.HAlign = 'center';

% Create a leader object l using a space as the leader type
% Append the leader object to a Heading2 paragraph
l = Leader(' ');
h2 = Heading2('Role');
append(h2,l);
append(h2,'Actor');
append(d,h);
append(d,h2);

% Create a leader object dotl using the default leader type of a dot
% Define variables for the content
dotl = Leader();
role = 'Romeo';
actor = 'Leonardo DiCaprio';

% Append the variable text and leader object to a paragraph
p = Paragraph();
append(p,role);
append(p,dotl);
append(p,actor);
append(d,p);

% Repeat, updating variables for each new paragraph
% Insert a clone of the dotl object
role = 'Juliet';
actor = 'Claire Danes';
p = Paragraph();
append(p,role);
append(p,clone(dotl));
append(p,actor);
append(d,p);

role = 'Tybalt';
actor = 'John Leguizamo';
p = Paragraph();
append(p,role);
append(p,clone(dotl));
append(p,actor);
append(d,p);

close(d);
rptview(d.OutputPath);   



%% 
% Copyright 2012 The MathWorks, Inc.