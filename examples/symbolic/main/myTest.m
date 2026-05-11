q = linspace(-2,2,256);
Omega = linspace(0,2,128);
delta = 1;
[qGrid,OmegaGrid] = meshgrid(q,Omega);

[E1,E2] = myEigenvalues(qGrid,OmegaGrid,delta);

surf(q,Omega,E1)
hold on;
surf(q,Omega,E2)
shading interp