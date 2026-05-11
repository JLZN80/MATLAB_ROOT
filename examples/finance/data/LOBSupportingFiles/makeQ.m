function Q = makeQ(Data,n,N)

% Reference: Machine Learning for Statistical Arbitrage
%            Part II: Feature Engineering and Model Development

numBins = n;
numStates = 3*n;
dI = N;
dS = N;

% Markov states

[rho,DS] = getStates(Data,n,N);

phi = NaN(size(rho));
for i = 1:length(rho)
    switch DS(i)
        case -1
            phi(i) = rho(i);
        case 0
            phi(i) = rho(i) + numBins;
        case 1
            phi(i) = rho(i) + 2*numBins;
    end
end

% Transition counts

C = zeros(numStates);
for i = 1:length(phi)-dS-1  
    C(phi(i),phi(i+1)) = C(phi(i),phi(i+1))+1;
end

% Holding times, generator matrix

H = diag(C);
G = C./H;
v = sum(G,2);
G = G + diag(-v);

% Transition matrix

P = expm(G*dI);

% Bayes condition

PCond = zeros(size(P));
phiNums = 1:numStates;
modNums = mod(phiNums,numBins);
for i = phiNums
    for j = phiNums
        idx = (modNums == modNums(j));
        PCond(i,j) = sum(P(i,idx));        
    end    
end

% Trading matrix

Q = P./PCond;