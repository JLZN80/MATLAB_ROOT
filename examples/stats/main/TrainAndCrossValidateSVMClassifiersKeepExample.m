%% Train and Cross Validate SVM Classifiers
% This example classifies points from a Gaussian mixture model. In _The
% Elements of Statistical Learning_, Hastie, Tibshirani, and Friedman
% (2009), page 17 describe the model. It begins with generating 10 base
% points for a "green" class, distributed as 2-D independent normals with
% mean (1,0) and unit variance. It also generates 10 base points for a
% "red" class, distributed as 2-D independent normals with mean (0,1) and
% unit variance. For each class (green and red), generate 100 random points
% as follows:
%
% # Choose a base point _m_ of the appropriate color uniformly at random.
% # Generate an independent random point with 2-D normal distribution
% with mean _m_ and variance I/5, where I is the 2-by-2 identity matrix.
%
% After generating 100 green and 100 red points, classify them using
% |fitcsvm|, and tune the classification using cross validation.
%
% To generate the points and classifier:
%%
% Generate the 10 base points for each class. 
rng('default')
grnpop = mvnrnd([1,0],eye(2),10);
redpop = mvnrnd([0,1],eye(2),10);
%%
% View the base points:
plot(grnpop(:,1),grnpop(:,2),'go')
hold on
plot(redpop(:,1),redpop(:,2),'ro')
hold off
%%
% Since many red base points are close to green base points, it is
% difficult to classify the data points.
%%
% Generate the 100 data points of each class:
redpts = zeros(100,2);grnpts = redpts;
for i = 1:100
    grnpts(i,:) = mvnrnd(grnpop(randi(10),:),eye(2)*0.2);
    redpts(i,:) = mvnrnd(redpop(randi(10),:),eye(2)*0.2);
end
%%
% View the data points:
figure
plot(grnpts(:,1),grnpts(:,2),'go')
hold on
plot(redpts(:,1),redpts(:,2),'ro')
hold off
%%
% Put the data into one matrix, and make a vector |grp| that labels the
% class of each point:
cdata = [grnpts;redpts];
grp = ones(200,1);
% Green label 1, red label -1
grp(101:200) = -1;
%%
% Check the basic classification of all the data using the default
% parameters:

% Train the classifier
SVMModel = fitcsvm(cdata,grp,'KernelFunction','rbf','ClassNames',[-1 1]);

% Predict scores over the grid
d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(cdata(:,1)):d:max(cdata(:,1)),...
    min(cdata(:,2)):d:max(cdata(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,scores] = predict(SVMModel,xGrid);

% Plot the data and the decision boundary
figure;
h(1:2) = gscatter(cdata(:,1),cdata(:,2),grp,'rg','+*');
hold on
h(3) = plot(cdata(SVMModel.IsSupportVector,1),...
    cdata(SVMModel.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
legend(h,{'-1','+1','Support Vectors'},'Location','Southeast');
axis equal
hold off
%%
% Set up a partition for cross validation. This step causes the cross
% validation to be fixed. Without this step, the cross validation is
% random, so a minimization procedure can find a spurious local minimum.
c = cvpartition(200,'KFold',10);
%%
% Set up a function that takes an input |z=[rbf_sigma,boxconstraint]|, and
% returns the cross-validation value of |exp(z)|. The reason to take
% |exp(z)| is twofold:
%
% * |rbf_sigma| and |boxconstraint| must be positive.
% * You should look at points spaced approximately exponentially apart.
%
% This function handle computes the cross validation at parameters
% |exp([rbf_sigma,boxconstraint])|:
minfn = @(z)kfoldLoss(fitcsvm(cdata,grp,'CVPartition',c,...
    'KernelFunction','rbf','BoxConstraint',exp(z(2)),...
    'KernelScale',exp(z(1))));
%%
% Search for the best parameters |[rbf_sigma,boxconstraint]| with
% |fminsearch|, setting looser tolerances than the defaults.
%%
% Note that if you have a Global Optimization Toolbox(TM) license, use
% |patternsearch| for faster, more reliable minimization. Give bounds on the
% components of |z| to keep the optimization in a sensible region, such as
% |[-5,5]|, and give a relatively loose |TolMesh| tolerance.
opts = optimset('TolX',5e-4,'TolFun',5e-4);
[searchmin,fval] = fminsearch(minfn,randn(2,1),opts)
%%
% The best parameters |[rbf_sigma;boxconstraint]| in this run are:
z = exp(searchmin)
%%
% Since the result of |fminsearch| can be a local minimum, not a global
% minimum, try again with a different starting point to check that your
% result is meaningful:
[searchmin,fval] = fminsearch(minfn,randn(2,1),opts)
%%
% The best parameters |[rbf_sigma;boxconstraint]| in this run are:
z = exp(searchmin)
%%
% Try another search:
[searchmin,fval] = fminsearch(minfn,randn(2,1),opts)
%%
% The best parameters |[rbf_sigma;boxconstraint]| in this run are:
z = exp(searchmin)
%%
% The surface seems to have many local minima.  Try a set of 20 
% random, initial values, and choose the set corresponding to the lowest
% |fval|.
m = 20;
fval = zeros(m,1);
z = zeros(m,2);
for j = 1:m;
    [searchmin,fval(j)] = fminsearch(minfn,randn(2,1),opts);
    z(j,:) = exp(searchmin);
end

z = z(fval == min(fval),:)
%%
% Use the |z| parameters to train a new SVM classifier:
SVMModel = fitcsvm(cdata,grp,'KernelFunction','rbf',...
    'KernelScale',z(1),'BoxConstraint',z(2));
[~,scores] = predict(SVMModel,xGrid);

h = nan(3,1); % Preallocation
figure;
h(1:2) = gscatter(cdata(:,1),cdata(:,2),grp,'rg','+*');
hold on
h(3) = plot(cdata(SVMModel.IsSupportVector,1),...
    cdata(SVMModel.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
legend(h,{'-1','+1','Support Vectors'},'Location','Southeast');
axis equal
hold off
%%
% Generate and classify some new data points:
grnobj = gmdistribution(grnpop,.2*eye(2));
redobj = gmdistribution(redpop,.2*eye(2));

newData = random(grnobj,10);
newData = [newData;random(redobj,10)];
grpData = ones(20,1);
grpData(11:20) = -1; % red = -1

v = predict(SVMModel,newData);

g = nan(7,1);
figure;
h(1:2) = gscatter(cdata(:,1),cdata(:,2),grp,'rg','+*');
hold on
h(3:4) = gscatter(newData(:,1),newData(:,2),v,'mc','**');
h(5) = plot(cdata(SVMModel.IsSupportVector,1),...
    cdata(SVMModel.IsSupportVector,2),'ko');
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'k');
legend(h(1:5),{'-1 (training)','+1 (training)','-1 (classified)',...
    '+1 (classified)','Support Vectors'},'Location','Southeast');
axis equal
hold off
%%
% See which new data points are correctly classified. Circle the correctly
% classified points in red, and the incorrectly classified points in black.
mydiff = (v == grpData); % Classified correctly
hold on
for ii = mydiff % Plot red circles around correct pts
    h(6) = plot(newData(ii,1),newData(ii,2),'ro','MarkerSize',12);
end

for ii = not(mydiff) % Plot black circles around incorrect pts
    h(7) = plot(newData(ii,1),newData(ii,2),'ko','MarkerSize',12);
end
legend(h,{'-1 (training)','+1 (training)','-1 (classified)',...
    '+1 (classified)','Support Vectors','Correctly Classified',...
    'Misclassified'},'Location','Southeast');
hold off

%% 
% Copyright 2012 The MathWorks, Inc.