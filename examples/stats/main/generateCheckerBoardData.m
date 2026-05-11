function [X,y] = generateCheckerBoardData(pps)
% Generate data on a 4-by-4 checker board. Here's what the data will look
% like:
%
% R B R B
% B R B R
% R B R B
% B R B R
%
% Each letter above represents a square on a 4-by-4 checkerboard. B stands
% for blue (y = -1) and R stands for red (y = 1). In each square, pps
% points are generated from a distribution that is the product of uniform
% distributions for the 2 X variables. The output X is N-by-2 and y is
% N-by-1 where N is such that: N = 16*pps.

    % 1. First row.
    
        % 1.1 First square
        % x1 in (-2,-1) and x2 in (1,2)
        X11 = [unifrnd(-2,-1,pps,1),unifrnd(1,2,pps,1)];
        y11 = ones(pps,1);
                
        % 1.2 Second square
        % x1 in (-1,0) and x2 in (1,2)
        X12 = [unifrnd(-1,0,pps,1),unifrnd(1,2,pps,1)];
        y12 = -ones(pps,1);
        
        % 1.3 Third square
        % x1 in (0,1) and x2 in (1,2)
        X13 = [unifrnd(0,1,pps,1),unifrnd(1,2,pps,1)];
        y13 = ones(pps,1);
        
        % 1.4 Fourth square
        % x1 in (1,2) and x2 in (1,2)
        X14 = [unifrnd(1,2,pps,1),unifrnd(1,2,pps,1)];
        y14 = -ones(pps,1);
    
    % 2. Second row.
    
        % 2.1 First square
        % x1 in (-2,-1) and x2 in (0,1)
        X21 = [unifrnd(-2,-1,pps,1),unifrnd(0,1,pps,1)];
        y21 = -ones(pps,1);
        
        % 2.2 Second square
        % x1 in (-1,0) and x2 in (0,1)
        X22 = [unifrnd(-1,0,pps,1),unifrnd(0,1,pps,1)];
        y22 = ones(pps,1);
        
        % 2.3 Third square
        % x1 in (0,1) and x2 in (0,1)
        X23 = [unifrnd(0,1,pps,1),unifrnd(0,1,pps,1)];
        y23 = -ones(pps,1);
        
        % 2.4 Fourth square
        % x1 in (1,2) and x2 in (0,1)
        X24 = [unifrnd(1,2,pps,1),unifrnd(0,1,pps,1)];
        y24 = ones(pps,1);
    
    % 3. Third row.
    
        % 3.1 First square
        % x1 in (-2,-1) and x2 in (-1,0)
        X31 = [unifrnd(-2,-1,pps,1),unifrnd(-1,0,pps,1)];
        y31 = ones(pps,1);
        
        % 3.2 Second square
        % x1 in (-1,0) and x2 in (-1,0)
        X32 = [unifrnd(-1,0,pps,1),unifrnd(-1,0,pps,1)];
        y32 = -ones(pps,1);
        
        % 3.3 Third square
        % x1 in (0,1) and x2 in (-1,0)
        X33 = [unifrnd(0,1,pps,1),unifrnd(-1,0,pps,1)];
        y33 = ones(pps,1);
        
        % 3.4 Fourth square
        % x1 in (1,2) and x2 in (-1,0)
        X34 = [unifrnd(1,2,pps,1),unifrnd(-1,0,pps,1)];
        y34 = -ones(pps,1);

    % 4. Fourth row.

        % 4.1 First square
        % x1 in (-2,-1) and x2 in (-2,-1)
        X41 = [unifrnd(-2,-1,pps,1),unifrnd(-2,-1,pps,1)];
        y41 = -ones(pps,1);
        
        % 4.2 Second square
        % x1 in (-1,0) and x2 in (-2,-1)
        X42 = [unifrnd(-1,0,pps,1),unifrnd(-2,-1,pps,1)];
        y42 = ones(pps,1);
        
        % 4.3 Third square
        % x1 in (0,1) and x2 in (-2,-1)
        X43 = [unifrnd(0,1,pps,1),unifrnd(-2,-1,pps,1)];
        y43 = -ones(pps,1);
                
        % 4.4 Fourth square
        % x1 in (1,2) and x2 in (-2,-1)
        X44 = [unifrnd(1,2,pps,1),unifrnd(-2,-1,pps,1)];
        y44 = ones(pps,1);
        
        
    % 5. X and y.
    X = [X11;X12;X13;X14;X21;X22;X23;X24;X31;X32;X33;X34;X41;X42;X43;X44];
    y = [y11;y12;y13;y14;y21;y22;y23;y24;y31;y32;y33;y34;y41;y42;y43;y44];
        
end

