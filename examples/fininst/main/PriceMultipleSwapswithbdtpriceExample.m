%% Price Multiple Swaps with |bdtprice|

%% 
% Use |instswap| to create multiple swaps and price the swaps with |bdtprice|. 
RateSpec = intenvset('Rates',.05,'StartDate',today,'EndDate',datemnth(today,60));
IS = instswap([.03 .02],today,datemnth(today,60),[], [], [], [1 1]);
IS = instswap(IS,[200 300],today,datemnth(today,60),[], [], [], [0 0]);
IS = instswap(IS,[.08 300],today,datemnth(today,60),[], [], [], [1 0]);
VolSpec = bdtvolspec(today,datemnth(today,[10 60]),[.01 .02]);
TimeSpec = bdttimespec(today,cfdates(today,datemnth(today,60),1));
BDTTree = bdttree(VolSpec,RateSpec,TimeSpec);
bdtprice(BDTTree,IS)   

%% 
% Copyright 2012 The MathWorks, Inc.