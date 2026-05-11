%% Price Multiple Swaps with |hwprice|

%% 
% Use |instswap| to create multiple swaps and price the swaps with |hwprice|. 
RateSpec = intenvset('Rates',.05,'StartDate',today,'EndDate',datemnth(today,60));
IS = instswap([.03 .02],today,datemnth(today,60),[], [], [], [1 1]);
IS = instswap(IS,[200 300],today,datemnth(today,60),[], [], [], [0 0]);
IS = instswap(IS,[.08 300],today,datemnth(today,60),[], [], [], [1 0]);
VolSpec = hwvolspec(today,datemnth(today,60),.01,datemnth(today,60),.1);
TimeSpec = hwtimespec(today,cfdates(today,datemnth(today,60),1));
HWTree = hwtree(VolSpec,RateSpec,TimeSpec);
hwprice(HWTree,IS)   

%% 
% Copyright 2012 The MathWorks, Inc.