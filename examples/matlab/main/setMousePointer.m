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