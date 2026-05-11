%% Fetch FRED(R) Data for Date
% Connect to the FRED(R) data server using the URL
% |'https://fred.stlouisfed.org/'|.
url = 'https://fred.stlouisfed.org/';
c = fred(url);
%% 
% Adjust the display data format for currency.
format bank
%% 
% Fetch data for a day three months ago using the series |'DTB6'|.
series = 'DTB6';
date = floor(now)-90;
d = fetch(c,series,date)
%%
% |d.Data| is an N-by-2 double array that contains the date in the
% first column and the series value in the second column.
%%
% Close the FRED(R) connection.
close(c)

%% 
% Copyright 2012 The MathWorks, Inc.