%% Convert FIX Message from Table to Character Vector 
% Create two FIX messages using a table |fixtable|. The FIX protocol
% version is 4.4. The first row in the table represents a sell side
% transaction for 100 shares of symbol |ABC|. The order type is a
% previously quoted order. The order handling instruction is a private
% automated execution. The order transaction time is the current moment.
% The message type indicates a new order. The second row in the table has
% the same order field variables except that the order identifier is unique
% across orders.

fixtable = table({'FIX.4.4';'FIX.4.4'}, ...
    {'338';'339'},{'2';'2'}, ...
    {datestr(now);datestr(now)}, ...
    {'D';'D'},{'ABC';'ABC'}, ...
    {'1';'1'},{'D';'D'},{'100';'100'}, ...
    'VariableNames',{'BeginString' ...
    'CLOrdId' 'Side' 'TransactTime' ...
    'OrdType' 'Symbol' ...
    'HandlInst' 'MsgType' 'OrderQty'});

%%
% Convert the FIX messages in the table |fixtable| to a cell array of the
% raw FIX messages |fixstr|.

fixstr = table2fix(fixtable)

%%
% Each character vector is a raw FIX message that contains FIX tags and
% values. The space in between the tag and value pairs is a SOH character.
% This character is not printable and has a hexadecimal value of
% |0x01|.


%% 
% Copyright 2012 The MathWorks, Inc.