%% Compare Fields in HTTP Request and Response Messages
% Create a Content-Type field in a request message to |mathworks.com|.  
uri = matlab.net.URI('https://www.mathworks.com');
req = matlab.net.http.RequestMessage;
req = addFields(req,matlab.net.http.HeaderField('Content-Type','text/html;charset=utf-8'));
resp = send(req,uri);
%% 
% Search for a Content-Type field in each message and compare the fields. 
% The messages contain the same header fields.
f1 = getFields(req,'Content-Type');
f2 = getFields(resp,'Content-Type');
isequal(f1,f2)

%% 
% Copyright 2012 The MathWorks, Inc.