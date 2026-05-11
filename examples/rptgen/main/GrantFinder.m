classdef GrantFinder < mlreportgen.finder.Finder
    %GrantFinder Find grants from the National Endowment for the Humanities
    %   This finder searches for grants awarded by the National
    %   Endowment for the Humanities (NEH). It assumes that the grants are
    %   listed in an XDML file available on the NEH data web site:
    %
    %   https://catalog.data.gov/dataset/neh-grant-data-2010-2019
    %
    %   GrantFinder properties:
    %       Container  - Grant database
    %       Properties - Grant properties to constrain a search
    %
    %   GrantFinder methods:
    %       find    - Find grants that match specified grant properties
    %       next    - Get next item in the search result queue
    %       hasNext - Return true if search queue is not empty
    %
    %   This finder supports two grant search modes: for mode and while
    %   mode. The for mode uses a find method to find all grants that
    %   match properties specified by the finder's Properties property. The
    %   find method returns an array of search result object types that
    %   you can add directly to a report. For example, the following code
    %   reports on all the grants in the NEH database.
    %
    %       import mlreportgen.report.*
    %       r = Report('myreport', 'pdf');
    %       f = GrantFinder;
    %       for grant = find(f)
    %           add(r, grant);
    %       end
    %       close(r);
    % 
    %   The while mode uses a hasNext and next method to conduct a search.
    %   The first time it is invoked, the hasNext method creates a queue of
    %   search results and returns true if the queue is not empty.
    %   Subsequent invocations return true as long as the queue is not
    %   empty. The next method removes a result from the front of the
    %   queue and returns it as long as the queue is not empty. The
    %   following example reports on all grants in the database.
    %
    %       import mlreportgen.report.*
    %       r = Report('myreport', 'pdf');
    %       f = GrantFinder;
    %       while hasNext(f)
    %           add(r, next(f));
    %       end
    %       close(r);
    %       rptview(r);
    % 
    %   To constrain a search, set the Properties method to an array of
    %   grant property-value pairs that grants must satisfy to be included
    %   in the search reports. The values must be strings and amy be
    %   regular exapressions. For example, the following code reports on
    %   grants awarded to Californin institutions from 2010 to 2012.
    %
    %       import mlreportgen.report.*
    %       r = Report('myreport', 'pdf');
    %       f = GrantFinder;
    %       f.Properties = [{'InstState', CA}, {'YearAwarded',...
    %       '201[0-2]'}];
    %       for grant = find(f)
    %           add(r, grant);
    %       end
    %       close(r);
    %       rptview(r);    
    
    %   Copyright 2018 The MathWorks, Inc.
    
    properties (Constant, Hidden)
        
        % InvalidPropertyNames
        %   Every finder must implement this property. It lists properties
        %   of search objects that cannot be used to constain a search.
        %   You can use any grant finder to constrain a grant search. This
        %   property is therefore empty.
        InvalidPropertyNames = {}
    end
    
    methods
        function this = GrantFinder()
            %GrantFinder Create an instance of a grant finder
            
            % Assume that the grant XML file is in the current directory.
            this@mlreportgen.finder.Finder(xmlread('NEH_Grants2010s.xml'))
            
            % Initialize the finder
            reset(this)
            
        end
        
        function results = find(this) 
            %find Search the grant database and return the results
            %   results = find(grantFinder) searches the NEH grant 
            %   database that resides in grantFinder, using the optional
            %   constraints specified by grantFinder's Properties
            %   property. This method returns the results as an array of
            %   result objects of type GrantResult.
            %
            %   See also GrantFinder.Properties, GrantResult
            results = [];
            
            % Get a list of the XML objects that represent the grants
            % that meet this finder's search criteria.
            getNodeList(this);
            
            % Convert the XML objects to an array of GrantResult nodes.
            % Return the results.
            for i = 1:this.NodeCount
                node = this.NodeList.item(i-1);
                results = [results GrantResult(node)]; %#ok<AGROW>
            end
        end
    end
    
    methods
        
        function tf = hasNext(this)
            %hasNext Return true if the grant queue is not empty
            %   tf = hasNext(grantFinder) creates a search result queue
            %   the first time it is called. The queue contains grants that
            %   reside in grantFinder and that match the search criteria
            %   specified by grantFinder's Properties property. This method
            %   returns true if the grant queue is not empty.
            %
            %   See also GrantFinder, GrantFinder.next, GrantResult
            
            if this.IsIterating
                if this.NextNodeIndex <= this.NodeCount
                    tf = true;
                else
                    tf = false;
                end
            else
                getNodeList(this);
                if this.NodeCount > 0
                    this.NextNodeIndex = 1;
                    this.IsIterating = true;
                    tf = true;
                else
                    tf = false;
                end
            end
        end
        
        function result = next(this)
            %next Returns the next item in the grant queue
            %   result = next(grantFinder) returns the first item in the
            %   grant queue the first time it is invoked. It returns the
            %   next item in the queue on subsequent invocations. The
            %   next result is an object of GrantResult type.
            %
            %   Note: invoke hasNext to create the grant queue.
            %
            %   See GrantFinder, GrantFinder.hasNext, GrantResult
            
            % this.IsIterating is set by hasNext to indicate that 
            % it has created a search queue.
            if this.IsIterating
                % this.NextNodeIndex and this.NodeCount are initialized
                % by hasNext.
                if this.NextNodeIndex <= this.NodeCount
                    
                    % Convert the next grant XML element to a GrantResult
                    % object
                    result = GrantResult(...
                        this.NodeList.item(this.NextNodeIndex-1));
                    
                    % Update the next node index
                    this.NextNodeIndex = this.NextNodeIndex+1;
                    
                else
                    % This condition can occur if the client invokes
                    % next without first invoking hasNext to determine
                    % whether any more grants exist.
                    error('No more grants exist')
                end
            else
                % This condition can occur if a client invokes this method
                % without first invoking hasNext to create the search
                % result queue.
                
                % Reset the queue variables.
                reset(this);
                
                % Initialize the queue.
                if hasNext(this)
                    % Returns the first item in the queue.
                    result = next(this);
                else
                    % This condition can occur if no grants meet the
                    % client's search criteria.
                    error('No grants exist')
                end
            end
        end
        
    end
    
    methods (Access = protected)
        
        function tf = isIterating(this)
            %isIterating Return true if search queue exists
            %   tf = isIterating(grantFinder) returns true if a valid
            %   search result queue exists in grantFinder.
            %
            %   Note. This method is declared in mlreportgen.finder.Finder. 
            %   Subclasses must define it.
            tf = this.IsIterating;
        end
        
        function reset(this)
            %reset Resets the finder's search queue
            %   reset(grantFinder) initializes the grantFinder's search
            %   queue variables.
            %
            %   Note: this method is declared in mlreportgen.find.Finder.
            %   Subclasses must define it.
            
            this.NodeList = [];
            this.IsIterating = false;
            this.NodeCount = 0;
            this.NextNodeIndex = 0;
        end
        
    end
    
    properties(Access = private)
        
        %NodeList List of XMLDOM grant elements
        %   The value of this property is a Java DOM object of type
        %   org.w3c.dom.NodeList. It contains a list org.w3c.dom.Element
        %   objects representing grants that meet this finder's search
        %   criteria. For information on the Java DOM API, see
        %   http://xerces.apache.org/xerces2-j/javadocs/api/org/w3c/dom/package-summary.html
        NodeList = []
        
        %NodeCount Number of grant elements in NodeList
        NodeCount double = 0
        
        %NextNodeIndex Index of next node in search results queue
        NextNodeIndex double = 0
        
        %IsIterating Whether finder is operating in next/getNext mode
        IsIterating logical = false
        
    end
    
    methods(Access=private, Hidden)
        
        function getNodeList(this)
            %getNodeList Get grant elements that match search criteria
            %   This is an internal method used to find grant elements. It
            %   sets this finder's NodeList property to the results of the
            %   search.
            
            if isempty(this.Properties)
                % No search criteria. Set this.NodeList to all grants in
                % the data base.
                this.NodeList = this.Container.getElementsByTagName('Grant');
            else
                % Use Java DOM's XPath API to find grants that
                % match the search criteria specified by this finder's 
                % Properties property. For information on this API, see
                % https://www.ibm.com/developerworks/xml/tutorials/x-xpath/x-xpath.html
                % Create an XPath expression of the form
                %
                %   '/Grants/Grant[matches(p1,v1) and matches(p2,v2) ...]'
                %
                % where p1,v1,p2,v2... are the property-value pairs 
                % specified by this finder's Properties property.
                %
                % The XPath expression finds all Grant elements that 
                % match the specified properties. Use of the XPath matches 
                % function allows the property values to be regular
                % expressions, permitting complex searches, e.g., searching
                % for grants that satisfy a range of values for a property.
                
                % Import the XPath API classes.
                import javax.xml.xpath.*
                
                %Create the XPath expression
                factory = GrantFinder.getXPathFactory;
                xPath = factory.newXPath;
                expr = xPath.compile(sprintf('/Grants/Grant[%s]', ...
                    makePredicate(this)));
                
                
                this.NodeList = expr.evaluate(this.Container, ...
                    XPathConstants.NODESET);
            end
            this.NodeCount = this.NodeList.getLength();
        end
        
        function pred = makePredicate(this)
            %makePredicate Make an XPath predicate out of search properties
            %   This is an internal method that converts this finder's
            %   Properties property to an equivalent XPath expression of
            %   the form 
            %
            %   'matches(p1,v1) and matches(p2,v2) ...]'
            
            prop = this.Properties{1};
            val = this.Properties{2};
            pred = sprintf('matches(%s, "%s")', prop, val);
            nProps = numel(this.Properties);
            if nProps > 2
                for i = 3:2:nProps
                    prop = this.Properties{i};
                    val = this.Properties{i+1};
                    pred = [pred, sprintf(' and matches(%s, "%s")', prop, val)]; %#ok<AGROW>
                end
            end
        end
        
    end
    
    
    methods (Static, Access = private, Hidden)
        
        function factory = getXPathFactory()
            %getXPathFactory Gets a factory for making XPath expressions
            %   This is an internal method that creates and returns an
            %   XPath factory the first time it is invoked. Subsequent
            %   invocations return the same factory. This avoids 
            %   unnecessarily creating multiple factories. One factory is
            %   sufficient for our purposes.
            persistent Factory;
            if isempty(Factory)
                Factory = javaMethod( 'newInstance', ...
                    'javax.xml.xpath.XPathFactory' );
            end
            factory = Factory;          
        end
    end
    
end

