%% Time Series Objects and Methods
%

%% Section 1
% Import the sample data from |count.dat| to the MATLAB workspace.
load count.dat

%%
% This adds the 24-by-3 matrix, |count|, to the workspace. Each column of
% |count| represents hourly vehicle counts at each of three town
% intersections.

%%
% View the |count| matrix.
count

%%
% Create three |timeseries| objects to store the data collected at each
% intersection.
count1 = timeseries(count(:,1), 1:24,'name', 'intersection1');
count2 = timeseries(count(:,2), 1:24,'name', 'intersection2');
count3 = timeseries(count(:,3), 1:24,'name', 'intersection3');

%% Section 2
% View the current properties of |count1|.
get(count1)

%%
% MATLAB displays the current property values of the |count1| |timeseries|
% object.

%%
% View the current |DataInfo| properties using dot notation.
count1.DataInfo

%%
% Change the data units for |count1| to |'cars'|.
count1.DataInfo.Units = 'cars';

%%
% Set the interpolation method for |count1| to zero-order hold.
count1.DataInfo.Interpolation = tsdata.interpolation('zoh');

%%
% Verify that the |DataInfo| properties have been modified.
count1.DataInfo

%%
% Modify the time units to be |'hours'| for the three time series.
count1.TimeInfo.Units = 'hours';
count2.TimeInfo.Units = 'hours';
count3.TimeInfo.Units = 'hours';

%% Section 3
% Add two events to the data that mark the times of the AM commute and PM
% commute.

%%
% Construct and add the first event to all time series. The first event
% occurs at 8 AM.
e1 = tsdata.event('AMCommute',8);
e1.Units = 'hours';            % Specify the units for time
count1 = addevent(count1,e1);  % Add the event to count1
count2 = addevent(count2,e1);  % Add the event to count2
count3 = addevent(count3,e1);  % Add the event to count3

%%
% Construct and add the second event to all time series. The second event
% occurs at 6 PM.
e2 = tsdata.event('PMCommute',18);
e2.Units = 'hours';            % Specify the  units for time
count1 = addevent(count1,e2);  % Add the event to count1
count2 = addevent(count2,e2);  % Add the event to count2
count3 = addevent(count3,e2);  % Add the event to count3

%%
% Plot the time series, |count1|.
figure
plot(count1)

%%
% When you plot any of the time series, the plot method defined for time
% series objects displays events as markers. By default markers are red
% filled circles.

%%
% The plot reflects that |count1| uses zero-order-hold interpolation.

%%
% Plot |count2|.
plot(count2)

%%
% If you plot time series |count2|, it replaces the |count1| display.
% You see its events and that it uses linear interpolation.

%%
% Overlay time series plots by setting |hold on|.
hold on
plot(count3)

%% Section 4
% Create a |tscollection| object named |count_coll| and use the
% constructor syntax to immediately add two of the three time series
% currently in the MATLAB workspace (you will add the third time series
% later).
tsc = tscollection({count1 count2},'name', 'count_coll')

%% Section 5
% Add the third |timeseries| object in the workspace to the |tscollection|.
tsc = addts(tsc, count3)

%%
% All three members in the collection are listed.

%% Section 6
% Resample the time series to include data values every 2 hours instead of
% every hour and save it as a new |tscollection| object.
tsc1 = resample(tsc,1:2:24)

%%
% In some cases you might need a finer sampling of information than you currently have and it is reasonable to obtain it by interpolating data values.

%%
% Interpolate values at each half-hour mark.
tsc1 = resample(tsc,1:0.5:24)

%% Section 7
% Plot the members of |tsc1| with markers to see the results of interpolating.
hold off                % Allow axes to clear before plotting
plot(tsc1.intersection1,'-xb','Displayname','Intersection 1')

%%
% You can see that data points have been interpolated at half-hour
% intervals, and that Intersection 1 uses zero-order-hold interpolation,
% while the other two members use linear interpolation.

%%
% Maintain the graph in the figure while you add the other two members to
% the plot. Because the |plot| method suppresses the axis labels while
% |hold| is |on|, also add a legend to describe the three series.
hold on
plot(tsc1.intersection2,'-.xm','Displayname','Intersection 2')
plot(tsc1.intersection3,':xr','Displayname','Intersection 3')
legend('show','Location','NorthWest')

%% Section 8
% Add a data sample to the |intersection1| collection member at 3.25 hours
% (i.e., 15 minutes after the hour).
tsc1 = addsampletocollection(tsc1,'time',3.25,...
       'intersection1',5);

%% Section 9
% Find and remove the data samples containing NaN values in the |tsc1|
% collection.
tsc1 = delsamplefromcollection(tsc1,'index',... 
       find(isnan(tsc1.intersection2.Data)));
   
%% Section 10
% For the sake of this example, reintroduce |NaN| values in |intersection2|
% and |intersection3|.
tsc1 = addsampletocollection(tsc1,'time',3.25,...
       'intersection1',5);
   
%%
% Interpolate the missing values in |tsc1| using the current time vector
% (|tsc1.Time|).
tsc1 = resample(tsc1,tsc1.Time);


%% Section 11
% Remove the |intersection3| time series from the |tscollection| object
% |tsc1|.
tsc1 = removets(tsc1,'intersection3')

%%
% Two time series as members in the collection are now listed.

%% Section 12
% Suppose the reference date occurs on December 25, 2009.
tsc1.TimeInfo.Units = 'hours';
tsc1.TimeInfo.StartDate = '25-DEC-2009 00:00:00';

%%
% Similarly to what you did with the |count1|, |count2|,
% and |count3| time series objects, set the data units
% to of the |tsc1| members to the string |'car count'|.
tsc1.intersection1.DataInfo.Units = 'car count'; 
tsc1.intersection2.DataInfo.Units = 'car count'; 

%% Section 13
% To plot data in a time series collection, you plot its members one at a
% time.

%%
% First graph |tsc1| member |intersection1|.
hold off
plot(tsc1.intersection1); 

%%
% When you plot a member of a time series collection, its time units display on the |x|-axis
% and its data units display on the |y|-axis. The plot title is displayed as |'Time Series Plot:<member name>'|.
%%
% If you use the same figure to plot a different member of the collection,
% no annotations display. The time series |plot| method
% does not attempt to update labels and titles when |hold| is |on| because
% the descriptors for the series can be different.

%%
% Plot |intersection1| and |intersection2| in the same figure. Prevent
% overwriting the plot, but remove axis labels and title. Add a legend and
% set the |DisplayName| property of the line series to label each member.
plot(tsc1.intersection1,'-xb','Displayname','Intersection 1')
hold on  
plot(tsc1.intersection2,'-.xm','Displayname','Intersection 2')
legend('show','Location','NorthWest')

%%
% The plot now includes the two time series in the collection: |intersection1| and |intesection2|.
% Plotting the second graph erased the labels on the first graph.

%%
% Finally, change the date strings on the |x|-axis to |hours| and plot the two time series collection members again with a legend.

%%
% Specify time units to be 'hours' for the collection.
tsc1.TimeInfo.Units = 'hours';

%%
% Specify the format for displaying time.
tsc1.TimeInfo.Format = 'HH:MM';

%%
% Recreate the last plot with new time units.
hold off
plot(tsc1.intersection1,'-xb','Displayname','Intersection 1')

% Prevent overwriting plot, but remove axis labels and title.
hold on 
plot(tsc1.intersection2,'-.xm','Displayname','Intersection 2')
legend('show','Location','NorthWest')

% Restore the labels with the |xlabel| and |ylabel| commands and overlay a
% data grid.
xlabel('Time (hours)')
ylabel('car count')
grid on

%% 
% Copyright 2012 The MathWorks, Inc.