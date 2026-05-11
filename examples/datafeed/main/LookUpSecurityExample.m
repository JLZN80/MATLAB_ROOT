%% Look Up Security
% Create a Bloomberg(R) connection, and then use the Security Lookup
% to retrieve information about the IBM(R) corporate bond. For details
% about Bloomberg and the parameter values you can set, see the _Bloomberg
% API Developer's Guide_ using the *WAPI<GO>* option from the Bloomberg
% terminal.
%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.
%%
% Return data as a table by setting the |DataReturnFormat| property of the
% connection object. If you do not set this property, the |lookup| function
% returns data as a structure.

c.DataReturnFormat = 'table';

%%
% Retrieve the instrument data for an IBM corporate bond with a maximum of
% 20 rows of data. The Security Lookup returns the security names and
% descriptions.

insts = lookup(c,'IBM','instrumentListRequest','maxResults',20, ...
    'yellowKeyFilter','YK_FILTER_CORP', ...
    'languageOverride','LANG_OVERRIDE_NONE');

%%
% Display the first three rows in the table. The first column contains the
% IBM corporate bond names, and the second column contains the bond
% descriptions.

insts(1:3,:)

%%
% Close the Bloomberg connection.

close(c)


%% 
% Copyright 2012 The MathWorks, Inc.