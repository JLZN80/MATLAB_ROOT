clc;

AssetPrice = 6132;
Strike = 6100;
Rates = 0.02127;
Sigma = 0.40824;
Settle = datetime(2022,6,29);
Maturity = datetime(2022,6,30);

RateSpec = intenvset('ValuationDate', Settle, 'StartDates', Settle, 'EndDates', Maturity, 'Rates', Rates, 'Compounding', 0, 'Basis', 3);

StockSpec = stockspec(Sigma, AssetPrice);

OptSpec = 'Call';
ExerciseDates = datetime(2022,6,30);
AvgDate = datetime(2022,6,29);
%NumFixings = 12;
AvgPrice = 5457.62;
OutSpec = {'Price','Delta','Gamma'};

[Price,Delta,Gamma] = asiansensbytw(RateSpec,StockSpec,OptSpec,Strike,Settle,ExerciseDates, 'AvgDate',AvgDate,'AvgPrice',AvgPrice,'OutSpec',OutSpec)
