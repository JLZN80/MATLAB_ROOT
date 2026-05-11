%% Adjust Skewed Cost Matrix 
% NOTE: This is a draft example that is not in doc. To use this example in 
% doc, replace instances of |fitensemble| with |fitcensemble|.
% Highly skewed cost matrices can lead to variable generalization error
% estimates.  Such generalization error estimates can be hard to interpret.
% One way to decrease the generalization error variance is to set a more
% balanced cost matrix.
%%
% Load the |ionosphere| data.
load ionosphere
tabulate(Y)
rng('default') % For reproducibility
%%
% The |'g'| class contains almost twice the amount of observations as the
% |'b'| class.
%%
% Train an ensemble of classification trees using the data and a highly skewed cost
% matrix.  The cost matrix should attribute a relatively low penalty for
% misclassifying observations into the |'b'| class.
ClassNames = {'g' 'b'}; % Sets 'b' as the positive class
Cost = [0 1;100 0];
N = 50;
OOBError = zeros(N,1);
%for k = 1:N
    ClassTreeEns = fitensemble(X,Y,'Bag',50,'Tree',...
        'Type','Classification','Cost',Cost,'ClassNames',ClassNames);
    OOBError(k) = oobLoss(ClassTreeEns,'Mode','Ensemble');
%end

Cost2 = [0 1;5 0];
OOBError2 = zeros(N,1);
%for k = 1:N
    ClassTreeEns = fitensemble(X,Y,'Bag',50,'Tree',...
        'Type','Classification','Cost',Cost2,'ClassNames',ClassNames);
    OOBError2(k) = oobLoss(ClassTreeEns,'Mode','Ensemble');
%end

plot(OOBError)
hold on
plot(OOBError2,'r')

std(OOBError)
std(OOBError2)

Prior = [0.01 0.99];
N = 25;
OOBError21 = zeros(N,1);
%for k = 1:N
    ClassTreeEns21 = fitensemble(X,Y,'Bag',50,'Tree',...
        'Type','Classification','Prior',Prior,'ClassNames',ClassNames);
    OOBError21(k) = oobLoss(ClassTreeEns21,'Mode','Ensemble');
%end

Prior2 = [0.2, 0.8];
OOBError22 = zeros(N,1);
%for k = 1:N
    ClassTreeEns22 = fitensemble(X,Y,'Bag',30,'Tree',...
        'Type','Classification','Prior',Prior2,'ClassNames',ClassNames);
    OOBError22(k) = oobLoss(ClassTreeEns22,'Mode','Ensemble');
%end

Prior3 = [0.6, 0.3];
OOBError23 = zeros(N,1);
%for k = 1:N
    ClassTreeEns23 = fitensemble(X,Y,'Bag',30,'Tree',...
        'Type','Classification','Prior',Prior3,'ClassNames',ClassNames);
    OOBError23(k) = oobLoss(ClassTreeEns23,'Mode','Ensemble');
%end

plot(OOBError21)
hold on
plot(OOBError22,'r')
plot(OOBError23,'g')
hold off

std(OOBError21)
std(OOBError22)
std(OOBError23)

Prior1 = [0.05 0.95];
Prior2 = [0.2, 0.8];
Prior3 = [0.6, 0.3];
Prior4 = [0.95, 0.5];

N = 50;
T = 50;
OOBErrorTB21 = zeros(N,1);
OOBErrorTB22 = zeros(N,1);
OOBErrorTB23 = zeros(N,1);
OOBErrorTB24 = zeros(N,1);

%for k = 1:N
    TB21 = TreeBagger(T,X,Y,'OOBPred','On','Prior',Prior1,...
        'ClassNames',ClassNames);
    OOBErrorTB21(k) = oobError(TB21,'Mode','Ensemble');
    TB22 = TreeBagger(T,X,Y,'OOBPred','On','Prior',Prior2,...
        'ClassNames',ClassNames);
    OOBErrorTB22(k) = oobError(TB22,'Mode','Ensemble');
    TB23 = TreeBagger(T,X,Y,'OOBPred','On','Prior',Prior3,...
        'ClassNames',ClassNames);
    OOBErrorTB23(k) = oobError(TB23,'Mode','Ensemble');
    TB24 = TreeBagger(T,X,Y,'OOBPred','On','Prior',Prior4,...
        'ClassNames',ClassNames);
    OOBErrorTB24(k) = oobError(TB24,'Mode','Ensemble');
%end


plot(OOBErrorTB21)
hold on
plot(OOBErrorTB22,'r')
plot(OOBErrorTB23,'g')
plot(OOBErrorTB24,'c')
plot(OOBErrorI,'k')
legend('Prior1','Prior2','Prior3','Prior4')
hold off

std(OOBErrorTB21)
std(OOBErrorTB22)
std(OOBErrorTB23)
std(OOBErrorTB24)

%%
% DO something like the above.  Not of ref page.  Use a better proportion
% than [0.2 0.8, perhaps [0.5 0.5] mention default ('empirical') etc
% Copyright 2014 The MathWorks, Inc.

