classdef GrantResult < mlreportgen.finder.Result
    %GrantResult Result of an NEH grant search
    %   This class is used by GrantFinder objects to return the results
    %   of searching an NEH grant database.
    %
    %   GrantResult properties
    %       Title         - Title of grant
    %       Institution   - Institution receiving the grant
    %       Location      - Location of institution
    %       AmountAwarded - Amount of grant
    %       YearAwarded   - Year in which grant was awarded
    %       ToSupport     - Purpose of the grant
    %       Participant   - Manager of the grant
    %       Object        - Java grant object of type org.w3c.dom.Element
    %       Tag           - User-defined grant identifier
    %
    %   This result's properties contain the values of a selected set of
    %   the grant's properties. You can use the result's Object property
    %   to access other grant properties.
    %
    %   GrantResult methods:
    %       getReporter - Get grant reporter
    %
    %   See also GrantFinder
    
    %   Copyright 2018 The MathWorks, Inc.
    
    properties
        
        %Title Title of this grant
        %   Value is the content of the Java grant's ProjectTitle element
        Title char = ''
        
        %Institution Institution awarded this grant
        %   Value is the content of the Java grant's Institution element
        Institution char = ''
        
        %Location Location of institution awared grant
        %   Value is a character array formed from the Java element's
        %   InstCity, InstState, InstPostalCode, and InstCountry elements,
        %   for example, 'West Barnstable, MA 02668-1599 USA'.
        Location char = ''
        
        %AwardAmount Amount of grant
        %   Value is the content of the Java grant's AwardAmount element
        AwardAmount char = ''
        
        %YearAwarded Year grant was awarded
        %   Value is the content of the Java grant's YearAwarded element
        YearAwarded char = ''
        
        %ToSupport Purpose of grant
        %   Value is the content of the Java grant's ToSupport element 
        ToSupport char = ''
        
        %Paricipant Name and title of grant manager
        %   Value is a string array formed from the content of the Java
        %   grant's Grant/Participant/Firstname, Lastname, and
        %   ParticipantTypeID elements, for example,
        %
        %       'John Doe, Project Director'        
        Participant char = ''
        
        %Tag User-defined result property
        Tag
    end
    
    properties (SetAccess = protected)
        
        %Object Java grant object
        %   The value of this object is the Java object that represents
        %   the grant this result object reports. You can use the Java
        %   object to get grant data not available through this result
        %   object's other properties.
        Object
    end
    
    methods
        function this = GrantResult(grant)
            %GrantResult Construct a grant object
            %   result = GrantResult(grantObj) creates a result object from
            %   grant, a Java DOM object containing a grant's properties.
            %   The grant argument must be of type org.w3c.dom.Element.
            this@mlreportgen.finder.Result(grant);
            
            this.Title = getGrantProperty(this, 'ProjectTitle');
            this.Institution = getGrantProperty(this, 'Institution');
            this.Location = sprintf('%s, %s %s %s', ...
                getGrantProperty(this, 'InstCity'), ...
                getGrantProperty(this, 'InstState'), ...
                getGrantProperty(this, 'InstPostalCode'), ...
                getGrantProperty(this, 'InstCountry') ...
                );
            this.AwardAmount = getGrantProperty(this, 'AwardOutright');
            this.YearAwarded = getGrantProperty(this, 'YearAwarded');
            this.ToSupport = getGrantProperty(this, 'ToSupport');
            this.Participant = sprintf('%s %s, %s', ...
                getParticipantProperty(this, 'Firstname'), ...
                getParticipantProperty(this, 'Lastname'), ....
                getParticipantProperty(this, 'ParticipantTypeID') ...
                );
            
        end
        
        function reporter = getReporter(this)
            %getReporter Get a reporter for this grant
            %   reporter = getReporter(thisGrantResult) returns a 
            %   reporter of type mlreportgen.report.BaseTable that reports
            %   on selected properties of the grant that this result
            %   contains.
            %
            %   Note: the Report API's add method invokes the getReporter
            %   method of result objects and adds the resulting reporter
            %   to a report or a chapter. This allows you to add this
            %   include a grant in a report by adding grant results to 
            %   chapter or report objects.
            %
            %   If you want to customize the appearance of a grant in the
            %   report, you can call this method to get the reporter,
            %   customize the reporter, and then add the reporter to a
            %   chapter or report.
            
            % Import the Report API and DOM API classes. We import the
            % DOM API classes because we want to customize the title of
            % the table used to report a grant result.
            import mlreportgen.report.*
            import mlreportgen.dom.*
            
            % Create an instance of a BaseTable reporter.
            reporter = BaseTable;
            
            % Get the reporter used to create the table's title.
            titleReporter = reporter.getTitleReporter;
            
            % The title of a base table consists of a prefix, followed
            % by a sequence number, followed by title text. By default,
            % the prefix is 'Table'. Let's change the prefix to 'Grant'.
            titleReporter.NumberPrefix = 'Grant ';
            
            % Set the table title text to the title of this grant.
            titleReporter.Content = this.Title;
            
            % Set the base table title to the title reporter. This causes
            % the table reporter to use the title reporter to generate our
            %  customized table title.
            reporter.Title = titleReporter;
            
            % Create a cell array containing the grant data we want to
            % report. We will use this cell array to create a DOM table
            % containing the grant data.
            info = {
                'Institution', this.Institution; ...
                'Location', this.Location; ...
                'Year Awarded', this.YearAwarded; ...
                'Award Amount', this.AwardAmount; ...
                'To Support', this.ToSupport; ...
                };
            
            if hasParticipant(this)
                info = [info; {'Participant', this.Participant}];
            end
            
            % Create a DOM table containing the grant data.
            table = Table(info);
            
            % The first column of our table contains the names of the
            % grant properties being reported. Let's make this column
            % wide enough to accommodate the longest property name. Let's
            % also use a bold font to render the property names, thereby
            % visually distinguishing them from the property values in the
            % adjacent column.
            
            % Use the DOM API's column spec group and column spec objects
            % to specify the format of the property name columm. Create 
            % a group object to contain the specs for the individual 
            % columns. 
            grps(1) = TableColSpecGroup;
            
            % Create a column spec object to specify the format of the
            % first, i.e., property name, column of the table.
            spec = TableColSpec;
            
            % Specify the width and font formats of the first column.
            spec.Style = {Width('1.3in'), Bold};
            
            % Create a col specs array and add the first column spec to 
            % the spec array.
            specs(1) = spec;
            
            % Create an object to specify the width of the second, i.e.,
            % property value, column of the table.
            spec = TableColSpec;
            
            % Specify the width of the column.
            spec.Style = {Width('4.5in')};
            
            % Add the col spec to the col spec array.
            specs(2) = spec;
            
            % Create a col spec group array and add the col specs array to
            % the groups array.
            grps(1).ColSpecs = specs;
            
            % Add the groups array to the table.
            table.ColSpecGroups = grps;
            
            % Set the grant properties table to be the content of the
            % table reporter. This causes the reporter to include the
            % group properties table along with our customized table title
            % in a report when the reporter is added to the report.
            reporter.Content = table;
        end
    end
    
    methods (Hidden)
        % This method is declared as abstract in mlreportgen.finder.Result. 
        % It must therefore be implemented. However, the GrantFinder does
        % not support it. Therefore hide it from user view.
        function presenter = getPresenter(~)
            presenter = [];
        end     
    end
    
    methods (Access=private, Hidden)
        
        function propValue = getGrantProperty(this, propName)
            %getGrantProperty Get the value of a grant property
            %   propValue = getGrantProperty(thisResult, propName)
            %   returns the value of the grant property specified by
            %   propName as a string. 
            
            % Use the Java DOM getElementsByTagName method to get the
            % element propName from this.Object, whose value is a Java
            % DOM element containing the grant data.
            nl = this.Object.getElementsByTagName(propName);
            
            % Assume that the grant element contains only one element named
            % propName.
            elem = nl.item(0);
            
            % Use the Java DOM getTextContent method to get the value 
            % of the propName element, which is the value of the grant's
            % propName property. The getTextContent method returns a 
            % Java String object. Convert and return the text content as
            % a MATLAB character array.
            propValue = char(elem.getTextContent);
            
        end
        
        function tf = hasParticipant(this)
            %hasParticipant Returns true if grant has a participant
            
            % Get the grant's participant element. Assume that the grant
            % has at most one participant.
            nl = this.Object.getElementsByTagName('Participant');
            participant = nl.item(0);
            tf = ~isempty(participant);
        end
        
        function propValue = getParticipantProperty(this, propName)
            %getParticipantProperty Get a grant participant property
            %   propValue = getParticipantProperty(this, propName) gets
            %   a property of a grant participant, if the grant specifies
            %   a participant. If the grant does not specify a participant,
            %   this method returns an empty string.
            
            % Get the grant's participant element. Assume that the grant
            % has at most one participant.
            nl = this.Object.getElementsByTagName('Participant');
            participant = nl.item(0);
            
            if ~isempty(participant)
                % Get the participant property element. Assume there is
                % only one element for this property.
                nl = participant.getElementsByTagName(propName);
                elem = nl.item(0);
                
                % Return the element's text content as the value of the
                % specified property.
                propValue = char(elem.getTextContent);
            else
                propValue = '';
            end
        end
        
    end
    
end

