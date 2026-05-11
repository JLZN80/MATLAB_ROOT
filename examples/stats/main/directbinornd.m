function X = directbinornd(N,p,m,n)
    X = zeros(m,n); % Preallocate memory
    for i = 1:m*n
        u = rand(N,1);
        X(i) = sum(u < p);
    end
end