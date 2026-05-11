%% Show Contents of HTTP Request Message Containing Image Data
% When a message body contains image/jpeg data, MATLAB displays 
% the number of bytes in the image.
%% 
% Send a message to the heritage.stsci.edu website requesting an image of
% Jupiter. Display the response message.
request = matlab.net.http.RequestMessage;
uri = matlab.net.URI('http://heritage.stsci.edu/2007/14/images/p0714aa.jpg');
r = send(request,uri);
show(r)

%% 
% Copyright 2012 The MathWorks, Inc.