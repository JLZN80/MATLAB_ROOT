%% Send Email from System Browser
% Send an email from your system browser's default mail application using 
% the |mailto:| URL scheme.

%%
% To run this example, replace the value for |email| with a valid email address.
email = 'myaddress@provider.ext';
url = ['mailto:',email];
web(url)

%% 
% Copyright 2012 The MathWorks, Inc.