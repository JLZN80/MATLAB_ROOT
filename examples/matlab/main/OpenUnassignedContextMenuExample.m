%% Open Unassigned Context Menu
% Open an unassigned context menu when you right-click on a blank area of
% the UI figure it is parented to or on a graphics object that supports the 
% |ButtonDownFcn| property.

% Copyright 2019 The MathWorks, Inc.

%%
% First, create a program file called |openCtxtMenu.m|. Within the program
% file:
% 
% * Create UI axes in a UI figure and plot data in the axes.
% * Create a context menu with one submenu in the UI figure.
% * Set the |WindowButtonDownFcn| property to a callback function called
% |onButtonDown|.
% * Create a callback function called |onButtonDown|. In it, determine if 
% the selection is a right-click by querying the |SelectionType| property of the UI
% figure. When a right-click occurs, get the _x_- and _y_-coordinates of the
% mouse pointer from the |CurrentPoint| property. The _x_- and _y_-coordinates
% are the first and second elements of the vector it returns. Then, open 
% the context menu at that location. When other selection types occur, 
% display a message in the Command Window.
% 
% When you run the program file, right-click on the UI axes or on a blank 
% spot within the UI figure to open the context menu.
%%
function openCtxtMenu
fig = uifigure;
ax = uiaxes(fig);
plot(ax,magic(5));

cm = uicontextmenu(fig);
m = uimenu(cm,'Text','Menu1');
 
fig.WindowButtonDownFcn = @onButtonDown;
 
    function onButtonDown(src,event)
        clickType = src.SelectionType;
        
        switch clickType
            case 'alt'
            x = src.CurrentPoint(1);
            y = src.CurrentPoint(2);
            open(cm,x,y)
            
            otherwise
            disp('Right-click to view context menu')
        end
   
    end
 
end
%%
% 
% <<../openunassignedCtxtMenu.png>>
% 