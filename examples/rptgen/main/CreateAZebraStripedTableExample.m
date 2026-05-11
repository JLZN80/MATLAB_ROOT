%% Create a Zebra-Striped Table
% This example shows how to create a table with alternating color rows or 
% columns. These tables are called zebra-striped or banded tables. To 
% create a zebra-striped table in a report, you can define it in a program 
% or a template. The examples in this section have zebra-striped rows. Use 
% a similar technique for zebra-striped columns.
%
% The Report Generator APIs support creating zebra-striped tables 
% programmatically or using a Word or HTML template. You cannot create a 
% PDF report for a zebra-striped table using a PDF template.

% Copyright 2018 The MathWorks, Inc.

%%
% <<../task_lib_zebra_stripe.png>>
%
%% Zebra-Striped Table Using a Program
% This program creates an 8-by-8 magic square table. It has row background 
% colors that alternate between blue and white, which can be helpful 
% for reading and summing the rows. The program also includes formatting 
% for the row height, table width, borders, and alignment of the cell entries. 
%%
import mlreportgen.report.*
import mlreportgen.dom.*

rpt = Report('zebraTable','pdf');

maglen = 8;
mag = magic(maglen);

tb = Table(mag);

% Set the colors for alternating rows
for i = 1:maglen
    r = tb.row(i);
    if mod(i,2)==0
      r.Style = {BackgroundColor('lightsteelblue')};
    else
      r.Style = {BackgroundColor('white')};
    end
end

tb.Style={RowHeight('0.3in'),RowSep('solid'),ColSep('solid')};
tb.Width= '3in';
tb.TableEntriesVAlign = 'middle';
tb.TableEntriesHAlign = 'center';
tb.Border = 'single';

add(rpt,tb)
close(rpt)
rptview(rpt)
%% Zebra-Striped Table Using a Word Template
% This example shows how to add a table style to a Word template that 
% defines a zebra-striped table. Using a template modularizes your 
% application. Instead of updating the program, which may introduce bugs, 
% you can update the template. 
%
% 1. Open a Word template. In this example, the template file is 
%    myrpt.dotx, which you can create using 
%    |mlreportgen.report.Report.createTemplate('myrpt','docx')|. To open a 
%    Word template file, right-click the file and then, click Open in the 
%    menu. (If you click the file directly, a .doc file that uses that 
%    template opens.)
%
% 2. Open the *Styles* pane as shown.
%%
% <<../task_lib_zebra_stripe_word1.png>>
%%
% 3. In the Styles pane, click the *New Style* button.
%%
% <<../task_lib_zebra_stripe_word2.png>>
%%
% 4. To define your table style, specify or select the field values. To 
%    match the programmatic zebra-striped table example, set these fields 
%    to apply the features to the table and table rows:
%
% * *Name* - Add |ZebraStripeTable| as the name for the style. Use this 
%    style name to specify the style to use for the table in your program.
% * *Style Type* - |Table|
% * *Apply formatting to* - |Even banded rows|
% * *Color field* |(No Color)| - Select a color for the odd banded rows 
%    from the dropdown.
%
% Then, set these fields to apply these additional features to the whole 
% table:
%
% * *Apply formatting to* - |Whole table|
% * Alignment - |Align Center|
% * Borders - |All Borders| 
%%
% <<../task_lib_zebra_stripe_word.png>>
%%
% 5. Click *OK* to save the new style.
%%
% 6. Save the template file
%%
% 7. In your program, specify the template file to use, and then, you can 
%    apply the new zebra-stripe style to a table in your program.
%%
rpt = mlreportgen.dom.Document('myreport','docx','myrpt.dotx');
tb = Table();
tb.StyleName = 'ZebraStripeTable';
%% 
% Not all formatting options that you can use in a program are available 
% in Word. For this example to match the programmatic example, in addition 
% to specifying styles in the Word template, you must specify the row 
% height and table width in your program.
%%
tb.Style = {RowHeight('0.3in')};
tb.Width = '3in';
%%
% This is the complete code for using the Word template, |myrpt.dotx|, to 
% format a magic square as a zebra-striped table.
%%
import mlreportgen.report.*
import mlreportgen.dom.*

rpt = mlreportgen.report.Report('myreport','docx','myrpt.dotx');
maglen = 8;
mag = magic(maglen);

tb = Table(mag);
tb.StyleName = 'ZebraStripeTable';
tb.Style={RowHeight('0.3in')};
tb.Width= '3in';

add(rpt,tb)
close(rpt);
rptview(rpt)

%% Zebra-Striped Table Using an HTML Template
% This example shows how to add a table style to an HTML template that 
% defines a zebra-striped table. Using a template modularizes your 
% application. Instead of updating the program, which may introduce bugs, 
% you can update the template. 
%
% 1. If you do not have an existing HTML template, create one using 
%    |mlreportgen.report.Report.createTemplate('myrpt','html')|. In this 
%    example, the template file is in a zipped template package, |myrpt.htmtx|. 
%
% 2. Use |unzipTemplate('myrpt.htmtx')| to unzip the template to create a 
%    folder named |myrpt|, which contains the style sheets and image 
%    template files.
%
% 3. Go to the stylesheets folder in the |myrpt| folder. Open the 
%    |root.css| file in a text editor.
%
% 4. Create a CSS rule that defines a style name ZebraStripeTable for an 
%    HTML table element. To define the CSS rule for the ZebraStripeTable 
%    style, add the following lines to the |root.css| file. The background 
%    colors, #B0C4DE and #FFFFFF, are light blue and white, respectively.
%
%      /* Settings for whole table */
%      table.ZebraStripeTable {
%         text-align: center;
%             border: 1px solid black;
%             border-collapse: collapse;
%             width: 5in;
%             height: 4in;
%      }
%      /* Settings for table body */
%      table.ZebraStripeTable td {
%             padding: 0pt 0pt 0pt 0pt;
%             vertical-align: middle;
%             text-align: center;
%             border: 1px solid black;
%             border-collapse: collapse;
%      }
%      /* Zebra rows and colors */
%      tr:nth-child(even) {
%          background-color: #B0C4DE
%      }
%      tr:nth-child(odd) {
%          background-color: #FFFFFF
%      }
%
% 5. Save the |root.css| file.
%
% 6. Use |zipTemplate('myrpt')| to zip the template files back to the 
%    |myrpt.htmtx| template package.
%
% 7. In your program, specify ZebraStripedTable as the style of your table.
%%
rpt = mlreportgen.report.Report('myreport','html','myrpt.htmtx');
tb = Table();
tb.StyleName = 'ZebraStripeTable';
%%
% This is the complete code for using the HTML template, |myrpt.htmtx|, to 
% format a magic square as a zebra-striped table.
%%
import mlreportgen.report.*
import mlreportgen.dom.*

rpt = mlreportgen.report.Report('myreport','html','myrpt.htmtx');

maglen = 8;
mag = magic(maglen);
tb = Table(mag);
tb.StyleName = 'ZebraStripeTable';

add(rpt,tb);
close(rpt);
rptview(rpt);