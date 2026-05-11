%% This example generates the plot in Classification Loss definition.
%% The plot is now inserted as a graphic (matlab/doc/src/toolbox/stats/ug/graphics/comparison_of_losses.png)
%% in definition_classsificationknn.lossfunction.xml

%% Plot Classification Loss Functions
%% Create handles and plot
bd = @(x)(log(1+exp(-2*x)))/(log(2));
%bd2 = @(x)(log(1+exp(-2*x)));
ce = @(x)-x > 0;
e = @(x)exp(-x);
h = @(x)max(0,1-x);
lt = @(x)(log(1+exp(-x)))/log(2);
q = @(x)(1-x).^2;

figure;
ezplot(bd,[-2,2]);
hold on
%ezplot(bd2,[-2,2]);
ezplot(ce,[-2,2]);
ezplot(e,[-2,2]);
ezplot(h,[-2,2]);
ezplot(lt,[-2,2]);
ezplot(q,[-2,2]);
legend({'Binomial Deviance','Classification Error','Exponential','Hinge','Logit','Quadratic'})
title('Comparison of Losses')
xlabel('\it{m}')
ylabel('\it{L}')
hold off

%% 
% Copyright 2012 The MathWorks, Inc.