%% Verify FRED(R) Connection
% 
%%
% Establish a connection |c| to a FRED(R) data server.
c = fred('https://fred.stlouisfed.org/');
%%
% Verify that |c| is a valid connection.
x = isconnection(c)
%% 
% Adjust the display data format for currency.
format bank
%% 
% Retrieve all historical data for the US / Euro Foreign Exchange Rate
% series.
series = 'DEXUSEU'; 

d = fetch(c,series);
%% 
% |d| contains the series description.
%%
% Close the FRED(R) connection.
close(c)


%% 
% Copyright 2012 The MathWorks, Inc.