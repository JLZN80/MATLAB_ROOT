classdef MagicSquareReport < mlreportgen.dom.Document
    %REPORT Main class for the magic square report. An instance of this
    %  class reproduces the MATLAB Report Generator's magic-square.rpt
    %  report example. It produces a report on a user-specifiable set of
    %  magic squares, i.e., square arrays whose rows and columns and 
    %  diagonals add up to the same value. This report consists of an
    %  introduction to magic squares and a chapter for each square
    %  specifiedby the user. Each chapter displays a 
    %  magic square as a table or a color-coded image, depending on the
    %  size of the square.
    %
    %  This class relies on a template to generate a report. The 
    %  template contains the following sections
    %
    %      * Title page with a hole for today's date
    %      * A table of contents page that automatically generates a
    %        TOC for the report
    %      * An introduction to magic squares followed by a hole for
    %        magic square chapters
    %      
    %  This class specifies methods for filling in the holes in the
    %  template. It inherits a fill method from Document class that 
    %  invokes the hole-filling methods to generate a report. 
    %
    %  The method that fills the chapters hole in the master template
    %  relies on another class, mlreportgen.examples.magic.MagicSquare,
    %  to create the chapters that it appends to the chapters hole.
    %
    %  To create a report with this class, create an instance of it and
    %  invoke its fill method.
    %
    %  Example:
    %
    %  rpt = mlreportgen.examples.magic.Report('MyReport', ...
    %        'docx', [10, 20, 90]);
    %  fill(rpt);
    %  close(rpt);
    %  rptview(rpt.OutputPath, 'docx');
    
    properties
        
        % Ranks of the magic squares to be included in report
        Ranks
    end

    properties (Access = {?MagicSquareChapter})
         
        % Used to save originals of magic square images
       Images
    end
    
    
    methods
        
        function rpt = MagicSquareReport(path, type, ranks)
            %MAGICSQUAREREPORT(PATH, TYPE, RANKS) constructs a report object that
            % generates a report at the specified path in the specified
            % document type ('docx' or 'html') on the 
            % magic squares specified by RANKS, a 1xN array of 
            % square ranks.
            %
            % Note: to generate PDF, first generate docx output and then
            % use rptview or docview to convert the docx to PDF.
            

            template =  sprintf('magic_squares_%s', type);            
            
            % Construct report object.
            rpt@mlreportgen.dom.Document(path, type, template);
            
            % Set ranks property
            rpt.Ranks = ranks;
            
            % Initialize image paths
            rpt.Images = {};
        end
        
        function fillReportDate(rpt)
            % This report's fill method (inherited from Document class)
            % invokes this method when it encounters the template's 
            % 'ReportDate' hole. It appends today's date to the hole.
            % 
            % Note that the method naming convention fillHOLE_ID
            % causes a method to be invoked when the specified HOLE_ID
            % is encountered.
            append(rpt, date);
        end
        
        function fillSquareChapters(rpt)
            % Fill the chapters hole in the master template, creating
            % one chapter for each magic square specified by rpt.Ranks.
            for i = 1:length(rpt.Ranks)
                % Construct a chapter object for the current magic square.
                chapter = MagicSquareChapter(rpt, rpt.Ranks(i));
                
                % Fill the holes in the chapter.
                fill(chapter);
                
                % Append the chapter to the report.
                append(rpt, chapter);
            end
        end
        
        function saveImage(rpt, image)
            rpt.Images = [rpt.Images {image}];
        end
        
        
        function close(rpt)
            close@mlreportgen.dom.Document(rpt);
            n = numel(rpt.Images);
            for i =1:n
                delete(rpt.Images{i});
            end
        end
        
    end
    
end