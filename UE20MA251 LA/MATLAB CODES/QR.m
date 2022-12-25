%A=[1,1,0;1,0,1;0,1,1]
%[Q,R]=qr (A)

% A=sym(pascal(3))
% [Q,R]=qr(A)
% isAlways(A == Q*R)

% A = sym(invhilb (5))
% b = sym([1:5]')
% [C,R] =qr (A,b)
% X = R\C
% 
% isAlways(A*X ==b)