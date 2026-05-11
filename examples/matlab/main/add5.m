function res = add5(x)
% ADD5 Increment input by 5.
if ~isa(x,'numeric')
    error('add5:InputMustBeNumeric','Input must be numeric.')
end
res = x + 5;
end