%% Create Handle to MATLAB Web Browser   
% Open the MathWorks(R) Web site home page, and then close the browser using
% its handle.   
  
url = 'https://www.mathworks.com';
[stat,h] = web(url);  

%% 
% Close the browser window. 
close(h)   



%% 
% Copyright 2012 The MathWorks, Inc.