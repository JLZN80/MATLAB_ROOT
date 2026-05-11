sol = ode45(@myODE,[0 20],[0 4]);
x = linspace(0,20,200);
y = deval(sol,x,1);
plot(x,y)
xlabel('Time t')
ylabel('Displacement y')