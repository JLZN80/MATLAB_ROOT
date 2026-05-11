%% IP Address Input
% Define a class called |IPAddressComponent| that creates a custom component for
% inputting four values to form an IP address.
%
% To define the class, create a file called |IPAddressComponent.m| that contains 
% the following class definition with these features:
%
% * A |Value| public property that stores the IP address.
% * |NumericField| and |GridLayout| private properties
%   that place four numeric edit fields in a horizontal row.
% * A |setup| method that initializes |NumericField| and |GridLayout|.
% * An |update| method that updates the |NumericField| values when the IP 
%   address changes. 
% * A |handleNewValue| method that sets the |Value| property based on the
%   values of the 4 numeric edit fields.
%
% <include>IPAddressComponent.m</include>
%
%%
% Next, create the component by calling the |IPAddressComponent| constructor
% method, which is provided by the |ComponentContainer| class, and return the object as |h|. 
% Specify a function that displays the new IP address in the Command Window when the 
% component value changes.

 h = IPAddressComponent;
 h.ValueChangedFcn = @(o,e) disp(['Value changed to: ', num2str(h.Value)]);

%%
% Enter the IP Address |192.168.1.10| into the edit fields. MATLAB
% displays the updated IP address in the Command Window.
% 
% <<../updatedIPAddress.png>>
% 
% 
% <<../valueChangedMessage.png>>
% 


% Copyright 2020 The MathWorks, Inc.
