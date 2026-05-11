%% Retrieve Account Information
%
% Create the IB Trader Workstation&#8480; connection |ib| on the local
% machine using port number |7496|.

ib = ibtws('',7496); 

%%
% Retrieve account information for account number |acctno|
% using |ib|.

acctno = 'AB123456';

d = accounts(ib,acctno);

%%
% |d| is a structure with fields containing the account information. 

%%
% Display the account code.

d.AccountCode

%%
% For details about this data and the other fields, see the 
% <https://www.interactivebrokers.com/en/software/api/api.htm _Interactive
% Brokers(R) API Reference Guide_>.

%%
% Close the IB Trader Workstation&#8480; connection.

close(ib)



%% 
% Copyright 2012 The MathWorks, Inc.