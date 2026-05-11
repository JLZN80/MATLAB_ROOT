%% Fetch FRED(R) Data for Date Range
%% 
% Connect to the FRED(R) data server using the URL
% |'https://fred.stlouisfed.org/'|.
url = 'https://fred.stlouisfed.org/';
c = fred(url);
%% 
% Adjust the display data format for currency.
format bank
%% 
% Retrieve historical data for the US / Euro Foreign Exchange Rate
% series.
series = 'DEXUSEU'; 

%% 
% Fetch five months of data from January 1, 2007 through June 1, 2007.
startdate = '01/01/2007';
enddate = '06/01/2007';
d = fetch(c,series,startdate,enddate)
%%
% |d.Data| is an N-by-2 double array that contains dates in the first
% column and the series values in the second column.
%%
% Close the FRED(R) connection.
close(c)

%% 
% Copyright 2012 The MathWorks, Inc.