%% Fetch All Available FRED(R) Data
%%
% Connect to the FRED(R) data server using the URL
% |'https://fred.stlouisfed.org/'|.
url = 'https://fred.stlouisfed.org/';
c = fred(url);
%%
% Fetch all available daily foreign exchange rates between the US dollar
% and the Euro using the series |'DEXUSEU'|.
series = 'DEXUSEU';
d = fetch(c,series)
%%
% |d.Data| is an N-by-2 double array that contains dates in the first
% column and the series values in the second column.
%%
% Close the FRED(R) connection.
close(c)

%% 
% Copyright 2012 The MathWorks, Inc.