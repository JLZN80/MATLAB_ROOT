DataUlt20Yr = DataEstresAll(DataEstresAll.Ao >=2004,:);
%DataUlt15Yr = DataEstresAll(DataEstresAll.Ao >=2009,:);
%DataUlt10Yr = DataEstresAll(DataEstresAll.Ao >=2014,:);
%DataUlt5Yr = DataEstresAll(DataEstresAll.Ao >=2019,:);
%DataUlt3Yr = DataEstresAll(DataEstresAll.Ao >=2021,:);

clc;

V = DataUlt3Yr;
PriceEvol = V(:,3:end);
PriceEvol = table2timetable(PriceEvol);

RetEvol = tick2ret(PriceEvol, 'Continuous');

% Plotenado la Evolucion
figure(1)
stackedplot(PriceEvol);
title('[Evolución Histórica] Precios de las Series')
figure(2)
stackedplot(RetEvol);
title('[Evolución Histórica] Retornos Logaritmicos de las Series')


% Ploteando los quantiles
figure(3)
subplot(3,1,1) % 2 rows, 1 column, 1 position
V = RetEvol;
q5 = prctile(V.Wc1, 5);
q95 = prctile(V.Wc1, 95);
plot (V.Wc1, 'b')
hold on
yline ([q5 q95], '--r', {'Percentil 5%','Percentil 95%'})
title('[Evolución Historica] Retorno Trigo de Chicago')

subplot(3,1,2) % 3 rows, 1 column, 2 position
histogram (V.Wc1 .* 100 .* sqrt(5))
xtickformat('%g%%')
hold on
q5 = prctile(V.Wc1 .* 100 .* sqrt(5), 5);
q95 = prctile(V.Wc1 .* 100 .* sqrt(5), 95);
xline ([q5 q95], '--r', {'Percentil 5%','Percentil 95%'})

subplot(3,1,3) % 3 rows, 1 column, 3 position
% Ploteando los quantiles
V = PriceEvol;
q25 = quantile(V.Wc1, .25);
q75 = quantile(V.Wc1, .75);
plot (V.Wc1, 'b')
hold on
yline ([q25 q75], '--r', {'1er Cuartil','3er Cuartil'})
title('[Evolución Historica] Precio Trigo de Chicago')

figure(4)
subplot(3,1,1) % 3 rows, 1 column, 1 position
V = RetEvol;
q5 = prctile(V.BOc1, 5);
q95 = prctile(V.BOc1, 95);
plot (V.BOc1, 'b')
hold on
yline ([q5 q95], '--r', {'Percentil 5%','Percentil 95%'})
title('[Evolución Historica] Retorno Aceite de Soya')

subplot(3,1,2) % 3 rows, 1 column, 2 position
histogram (V.BOc1 .* 100 .* sqrt(5))
xtickformat('%g%%')
hold on
q5 = prctile(V.BOc1 .* 100 .* sqrt(5), 5);
q95 = prctile(V.BOc1 .* 100 .* sqrt(5), 95);
xline ([q5 q95], '--r', {'Percentil 5%','Percentil 95%'})

subplot(3,1,3) % 2 rows, 1 column, first position
% Ploteando los quantiles
V = PriceEvol;
q25 = quantile(V.BOc1, .25);
q75 = quantile(V.BOc1, .75);
plot (V.BOc1, 'b')
hold on
yline ([q25 q75], '--r', {'1er Cuartil','3er Cuartil'})
title('[Evolución Historica] Precio Aceite de Soya')

figure(5)
subplot(3,1,1) % 2 rows, 1 column, 1 position
V = RetEvol;
q5 = prctile(V.SMc1, 5);
q95 = prctile(V.SMc1, 95);
plot (V.SMc1, 'b')
hold on
yline ([q5 q95], '--r', {'Percentil 5%','Percentil 95%'})
title('[Evolución Historica] Retorno Harina de Soya')

subplot(3,1,2) % 3 rows, 1 column, 2 position
histogram (V.SMc1 .* 100 .* sqrt(5))
xtickformat('%g%%')
hold on
q5 = prctile(V.SMc1 .* 100 .* sqrt(5), 5);
q95 = prctile(V.SMc1 .* 100 .* sqrt(5), 95);
xline ([q5 q95], '--r', {'Percentil 5%','Percentil 95%'})

subplot(3,1,3) % 2 rows, 1 column, 3 position
% Ploteando los quantiles
V = PriceEvol;
q25 = quantile(V.SMc1, .25);
q75 = quantile(V.SMc1, .75);
plot (V.SMc1, 'b')
hold on
yline ([q25 q75], '--r', {'1er Cuartil','3er Cuartil'})
title('[Evolución Historica] Precio Harina de Soya')
hold off

