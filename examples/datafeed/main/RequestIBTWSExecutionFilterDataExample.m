%% Request Execution Filter Data
%
% Create the IB Trader Workstation&#8480; connection |ib| on the local
% machine using port number |7496|.

ib = ibtws('',7496);

%%
% Create the IB Trader Workstation&#8480; execution filter
% |IExecutionFilter| object |filter|. This object specifies these property
% values:
%
% * Buy side
% * Stock security type
% * Aggregate exchange
% * Google(R) symbol

filter = ib.Handle.createExecutionFilter;
filter.side = 'BUY';
filter.secType = 'STK';
filter.exchange = 'SMART';
filter.symbol = 'GOOG';

%%
% For details about the |IExecutionFilter| object, see the 
% <https://www.interactivebrokers.com/en/software/api/api.htm _Interactive
% Brokers(R) API Reference Guide_>.

%%
% Request IB Trader Workstation&#8480; execution filter data using |ib| and
% |filter|.

d = executions(ib,filter)

%%
% |d| is a structure containing the execution filter data in the structure
% |enddetails|.

%%
% Display the execution filter data.

d.enddetails

%%
% The structure |enddetails| contains these fields:
%
% * Type -- Data request type
% * Source -- Interactive Brokers(R) ActiveX(R) object
% * EventID -- Event identifier
% * reqId -- Execution filter data request identifier

%%
% Close the IB Trader Workstation&#8480; connection.

close(ib)


%% 
% Copyright 2012 The MathWorks, Inc.