%% Create a Float-Float Swap and Price with |hwprice|

%% 
% Use |instswap| to create a float-float swap and price the swap with |hwprice|. 
RateSpec = intenvset('Rates',.05,'StartDate',today,'EndDate',datemnth(today,60));
IS = instswap([.02 .03],today,datemnth(today,60),[], [], [], [1 1]);
VolSpec = hwvolspec(today,datemnth(today,60),.01,datemnth(today,60),.1);
TimeSpec = hwtimespec(today,cfdates(today,datemnth(today,60),1));
HWTree = hwtree(VolSpec,RateSpec,TimeSpec);
hwprice(HWTree,IS)   

%% 
% Copyright 2012 The MathWorks, Inc.