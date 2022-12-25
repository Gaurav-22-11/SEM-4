%LU Decomposition
Ab = [1 1 -1;3 5 6;7 8 9]

n= length(Ab)

L = eye(n)

% With A(1,1) as pivot Element

for i =2:3

alpha = Ab(i,1)/Ab(1,1)

L(i,1) = alpha

Ab(i,:) = Ab(i,:) -alpha*Ab(1,:)

end

% With A(2,2) as pivot Element

i=3

alpha = Ab(i,2)/Ab(2,2)

L(i,2)= alpha

Ab(i,:) = Ab(i,:)-alpha*Ab(2,:)

U = Ab(1:n,1:n)