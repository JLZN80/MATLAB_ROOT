%% Create a Float-Float Swap and Price with |intenvprice|

%% 
% Use |instswap| to create a float-float swap and price the swap with |intenvprice|. 
RateSpec = intenvset('Rates',.05,'StartDate',today,'EndDate',datemnth(today,60));
IS = instswap([40 20],today,datemnth(today,60),[], [], [], [0 0]);
intenvprice(RateSpec,IS)   

%% 
% Copyright 2012 The MathWorks, Inc.