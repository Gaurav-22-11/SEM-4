%FIND THE POINT ON THE PLANE X+Y-Z=0 THAT IS CLOSEST TO (2,1,0)
% syms c
% P=[2,1,0]+c*[1,1,-1]
% s=1*(c+2)+1*(c+1)-1*(-c)==0
% s1=solve(s,c)
% p=[2,1,0]+s1*[1,1,-1]

%FIND THE POINT ON THE PLANE 3X+4Y+Z=1 THAT IS CLOSEST TO (1,0,1)
% syms c
% P=[1,0,1]+c*[3,4,1]
% s=3*(1+3*c)+4*(4*c)+(1+c)==1
% s1=solve(s,c)
% p=[1,0,1]+s1*[3,4,1]

%Let u=[1,7] onto v=[-4,2] and find P, the matrix that will project any matrix onto the vector v. Use the result to find projv u.
% u=[1;7]
% v=[-4;2]
% P=(v*transpose(v))/ (transpose (v)*v)
% P*u

% %PROJECTING A LOT OF VECTORS ON A SINGLE VECTOR
u=8*rand(2,100)-4
x=u(1,:)
y=u(2,: )
plot(x,y,'o')
P=[0.8,-0.4;-0.4,0.2]
Pu=P*u;
x=Pu(1,:)
y=Pu(2,:)
hold on
plot(x,y,'ro')
