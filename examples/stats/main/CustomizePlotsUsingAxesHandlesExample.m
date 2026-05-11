%% Customize Plots Using Axes Handles  

% Copyright 2015 The MathWorks, Inc.


%% 
% Load the sample data. Create data vector |x| from the first column of
% the data matrix, which contains sepal length measurements from three species
% of iris flowers. Create data vector |y| from the second column of the
% data matrix, which contains sepal width measurements from the same flowers.  
load fisheriris.mat;
x = meas(:,1);
y = meas(:,2);  

%% 
% Use axis handles to replace the marginal histograms with box plots. 
h = scatterhist(x,y,'Group',species);
hold on;
clr = get(h(1),'colororder');
boxplot(h(2),x,species,'orientation','horizontal',...
     'label',{'','',''},'color',clr);
boxplot(h(3),y,species,'orientation','horizontal',...
     'label', {'','',''},'color',clr);
set(h(2:3),'XTickLabel','');
view(h(3),[270,90]);  % Rotate the Y plot
axis(h(1),'auto');  % Sync axes
hold off;      
