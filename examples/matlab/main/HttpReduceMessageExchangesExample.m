%% Reduce Message Exchanges
% Eliminate message redirection by reusing cookies. 
%% 
% Send a message to |mathworks.com|. Multiple messages are exchanged.
import matlab.net.http.*
import matlab.net.http.field.*
r = RequestMessage;
[resp,~,history] = r.send('http://www.mathworks.com');
disp(length(history))
%% 
% Extract the cookies from the message history.
cookieInfos = CookieInfo.collectFromLog(history);
if ~isempty(cookieInfos)
    cookies = [cookieInfos.Cookie];
end
%% 
% Apply the cookies to the next request. Only one message is exchanged.
r = RequestMessage([],CookieField(cookies));
[resp,~,history] = r.send('http://www.mathworks.com');
disp(length(history))

%% 
% Copyright 2012 The MathWorks, Inc.