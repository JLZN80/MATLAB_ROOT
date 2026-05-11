%% Create Float-Float, Fixed-Fixed, and Float-Fixed Swaps and Price with |intenvprice|

%% 
% Use |instswap| to create swaps and price the swaps with |intenvprice|. 
RateSpec = intenvset('Rates',.05,'StartDate',today,'EndDate',datemnth(today,60));
IS = instswap([.03 .02],today,datemnth(today,60),[], [], [], [1 1]);
IS = instswap(IS,[200 300],today,datemnth(today,60),[], [], [], [0 0]);
IS = instswap(IS,[300 .07],today,datemnth(today,60),[], [], [], [0 1]);
intenvprice(RateSpec,IS)   

%% 
% Copyright 2012 The MathWorks, Inc.