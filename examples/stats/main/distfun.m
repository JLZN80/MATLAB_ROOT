function D2 = distfun(ZI,ZJ)
ageDifference = abs(ZI(1)-ZJ(:,1));
weightDifference = abs(ZI(2)-ZJ(:,2));
D2 = ageDifference + 0.2*weightDifference;
end