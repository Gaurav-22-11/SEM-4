%Apply the Gram-Schmidt process to the vectors (1,0,1), (1,0,0) and (2,1,0) to produce a set of Orthonormal  vectors
% A=[1,1,2;0,0,1;1,0,0]
% Q=zeros(3)
% R=zeros(3)
% for j=1:3 
% v=A(: , j)
% for i=1:j-1
% R(i,j)=Q(:,i)'*A(:,j) 
% v=v-R(i,j)*Q(:,i) 
% end 
% R(j,j)=norm(v)
% Q(:,j)=v/R(j,j) 
% end 
%Apply the Gram-Schmidt process to the vectors a=(0,1,1,1), 
%b=(1,1,-1,0) and c=(1,0,2,-1).
% A=[0,1,1;1,1,0;1,-1,2;1,0,-1]
% Q=zeros(4,3)
% R=zeros(3)
% for j=1:3 
% v=A(: , j)
% for i=1:j-1
% R(i,j)=Q(:,i)'*A(:,j) 
% v=v-R(i,j)*Q(:,i) 
% end 
% R(j,j)=norm(v)
% Q(:,j)=v/R(j,j) 
% end


