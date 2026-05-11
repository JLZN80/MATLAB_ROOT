%% Change Mouse Pointer Symbol
% Change the mouse pointer symbol that displays when you hover over a push
% button.
%%%
% This program file, called |setMousePointer.m|, shows you how to:
%
% * Create a UI figure which executes custom code when the mouse is moved
% over a button. To do this, use the |@| operator to assign the |mouseMoved| 
% function handle to the |WindowButtonMotionFcn| property of the figure.
% * Create a push button and specify its coordinates and label.
% * Create a callback function called |mouseMoved| with the custom code you
% want to execute when the mouse moves over the button. In the function, query the
% |CurrentPoint| property to determine the mouse pointer coordinates. Set
% the |Pointer| property to |'hand'| if the pointer coordinates are
% within the push button coordinates.
%%%
% Run |setMousePointer|. Then move the mouse over the push button to see
% the mouse pointer symbol change.

% Copyright 2019 The MathWorks, Inc.

%% 
function setMousePointer
    fig = uifigure('Position',[500 500 375 275]);
    fig.WindowButtonMotionFcn = @mouseMoved;
    
    btn = uibutton(fig);
    btnX = 50;
    btnY = 50;
    btnWidth = 100;
    btnHeight = 22;
    btn.Position = [btnX btnY btnWidth btnHeight];
    btn.Text = 'Submit Changes';
    
      function mouseMoved(src,event)
          mousePos = fig.CurrentPoint;
          
          if  (mousePos(1) >= btnX) && (mousePos(1) <= btnX + btnWidth) ...
                        && (mousePos(2) >= btnY) && (mousePos(2) <= btnY + btnHeight)
             
              fig.Pointer = 'hand';
          else
              
              fig.Pointer = 'arrow';
          end
          
      end
  
end
%%%
%
% <<../uifigure_mousepointer.png>>
%