%% Convert FIX Message from Structure Array to Character Vector 
% Create two FIX messages using a structure array |fixstruct|. The FIX
% protocol version is 4.4. Each FIX message represents a sell side
% transaction for 100 shares of symbol |ABC|. The order transaction time is
% the current moment. The order type is a previously quoted order. The
% order handling instruction is a private automated execution. The message
% type indicates a new order. The second structure in the structure array
% has the same order field values except that the order identifier is
% unique across orders.
%%
fixstruct.BeginString{1,1} = 'FIX.4.4';
fixstruct.CLOrdId{1,1}  = '338';
fixstruct.Side{1,1}  = '2';
fixstruct.TransactTime{1,1}  = datestr(now);
fixstruct.OrdType{1,1}  = 'D';
fixstruct.Symbol{1,1}  = 'ABC';
fixstruct.HandlInst{1,1}  = '1';
fixstruct.OrderQty{1,1} = '100';
fixstruct.MsgType{1,1} = 'D';

fixstruct.BeginString{2,1} = 'FIX.4.4';
fixstruct.CLOrdId{2,1}  = '339';
fixstruct.Side{2,1}  = '2';
fixstruct.TransactTime{2,1}  = datestr(now);
fixstruct.OrdType{2,1}  = 'D';
fixstruct.Symbol{2,1}  = 'ABC';
fixstruct.HandlInst{2,1}  = '1';
fixstruct.OrderQty{2,1} = '100';
fixstruct.MsgType{2,1} = 'D';
%% 
% Convert FIX messages in the structure array |fixstruct| to a cell array
% of raw FIX messages |fixstr|.
%%
fixstr = struct2fix(fixstruct)
%%
% Each character vector is a raw FIX message that contains FIX tags and
% values. The space in between the tag and value pairs is a SOH character.
% This character is not printable and has a hexadecimal value of
% |0x01|.


%% 
% Copyright 2012 The MathWorks, Inc.