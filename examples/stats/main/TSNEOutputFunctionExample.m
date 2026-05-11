%% t-SNE Custom Output Function
% This example shows how to use an output function in |tsne|.
%
%% Custom Output Function
% The following code is an output function that performs these tasks:
%
% * Keep a history of the Kullback-Leibler divergence and the norm of its
% gradient in a workspace variable.
% * Plot the solution and the history as the iterations proceed.
% * Display a |Stop| button on the plot to stop the iterations early
% without losing any information.
%
% The output function has an extra input variable, |species|, that enables
% its plots to show the correct classification of the data. For information
% on including extra parameters such as |species| in a function, see
% <docid:matlab_math.bsgprpq-5 Parameterizing Functions>.
%
% <include>KLLogging.m</include>
%
%% Use the Custom Output Function
% Plot the Fisher iris data, a 4-D data set, in two dimensions using
% |tsne|. There is a drop in the Divergence value at iteration 100 because
% the divergence is scaled by the exaggeration value for earlier
% iterations. The embedding remains largely unchanged for the last several
% hundred iterations, so you can save time by clicking the |Stop| button
% during the iterations.
load fisheriris
rng default % for reproducibility
opts = statset('OutputFcn',@(optimValues,state) KLLogging(optimValues,state,species));
Y = tsne(meas,'Options',opts,'Algorithm','exact');

%% 
% Copyright 2012 The MathWorks, Inc.