%Final Project @ Chaos
%Author:Renjun Xu
%Date: 03/18/2009

function f=riktake(t,X)
%
% Values of parameters
v = 28;
a = 8/3;

x=X(1); y=X(2); z=X(3);

Y= [X(4), X(7), X(10);
    X(5), X(8), X(11);
    X(6), X(9), X(12)];

f=zeros(9,1);

%Lorenz equation
f(1)=-v*x+z*y;
f(2)=-v*y+(z-a)*x;
f(3)=1-x*y;

%Linearized system

 Jac=[-v,   z,  y;
      z-a, -v,  x;
       -y, -x,  0];
  
%Variational equation   
f(4:12)=Jac*Y;

%Output data must be a column vector


