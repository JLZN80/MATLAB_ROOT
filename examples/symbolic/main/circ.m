function C = circ(t)
    x = sym('x');
    C = fplot(cos(x)+t,sin(x)+1,[0 2*pi],'Color','red');
end