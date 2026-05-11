%% Retrieve Three Points of Data from a Channel
% Retrieve the last five minutes of data from fields 1 and 4 of a public channel, and return the data in a timetable.
 
% Copyright 2018 The MathWorks, Inc.
 
%%
data = thingSpeakRead(12397,'Fields',[1,4],'NumPoints',3,'OutputFormat','TimeTable')
