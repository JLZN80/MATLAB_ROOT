function cash = tradeOnQ(Data,Q,n,N)

% Reference: Machine Learning for Statistical Arbitrage
%            Part II: Feature Engineering and Model Development

% Data

t = Data.t;
MOBid = Data.MOBid;
MOAsk = Data.MOAsk;

% States

[rho,DS] = getStates(Data,n,N);

% Start of trading

cash = 0;
assets = 0;

% Active trading

T = length(t);

for tt = 2:T-N  % Trading ticks

    % Get Q row, column indices of current state
    
    row = rho(tt-1)+n*(DS(tt-1)+1);
    downColumn = rho(tt);
    upColumn = rho(tt) + 2*n;
    
    % If predicting downward price move
    
    if Q(row,downColumn) > 0.5

        cash = cash + MOBid(tt); % Sell
        assets = assets - 1;
            
	% If predicting upward price move

    elseif Q(row,upColumn) > 0.5

        cash = cash - MOAsk(tt); % Buy
        assets = assets + 1; 

    end

end

% End of trading (liquidate position)

if assets > 0

    cash = cash + assets*MOBid(T); % Sell off

elseif assets < 0

    cash = cash + assets*MOAsk(T); % Buy back

end