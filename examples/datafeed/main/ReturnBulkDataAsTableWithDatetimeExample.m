%% Return Bulk Data as Table with Datetime
% Create a Bloomberg(R) connection, and then request dividend
% history data. The |getbulkdata| function returns data for dates as a
% |datetime| array.
%%
% Create the Bloomberg connection. 

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.
%%
% Return data as a table by setting the |DataReturnFormat| property of the
% connection object. If you do not set this property, the |getbulkdata|
% function returns data as a structure.
%
% Return dates as a |datetime| array by setting the |DatetimeType| property
% of the connection object. In this case, the table contains dates in
% variables that are |datetime| arrays.

c.DataReturnFormat = 'table';
c.DatetimeType = 'datetime';

%%
% Return the dividend history for IBM(R).

s = 'IBM US Equity';
f = 'DVD_HIST'; % Dividend history field
			
d = getbulkdata(c,s,f);

%%
% Display the first three rows of the table.

d.DVD_HIST{1}(1:3,:)

%%
% Display three declared dates. The |DeclaredDate| variable is a |datetime|
% array.

d.DVD_HIST{1}.DeclaredDate(1:3)

%%
% Close the Bloomberg connection.

close(c)

%% 
% Copyright 2012 The MathWorks, Inc.