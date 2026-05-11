%% Obtain Next Valid Order Identification Number 
%
% Create an IB Trader Workstation&#8480; connection on the local machine
% using port number |7496|.

ib = ibtws('',7496);
%%
% Obtain the next valid order identification number using |ib|.

id = orderid(ib)

%%
% |id| contains the next valid order identification number. To create an
% order, use this number in <docid:trading_ug.bty9y6_-1 createOrder>.

%%
% Close the IB Trader Workstation&#8480; connection.

close(ib)


%% 
% Copyright 2012 The MathWorks, Inc.