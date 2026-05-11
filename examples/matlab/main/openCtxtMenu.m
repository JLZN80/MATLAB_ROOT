function openCtxtMenu
fig = uifigure;
ax = uiaxes(fig);
plot(ax,magic(5));

cm = uicontextmenu(fig);
m = uimenu(cm,'Text','Menu1');

fig.WindowButtonDownFcn = @onRightClick;

    function onRightClick(src,event)
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