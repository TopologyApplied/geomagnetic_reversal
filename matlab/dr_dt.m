%options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-5]);
%[T,Y] = ode45(@rigid,[0 12],[0 1 1],options);

function dy=dr_dt(t,y,par)
dy = zeros(3,1);    % a column vector, y3=a
%%for i = 1:length(t) % allow for a to be a vector.  Loop through it
dy(1) = -par.v.*y(1)+y(3).*y(2); 
dy(2) = -par.v.*y(2)+(y(3)-par.a).*y(1);
dy(3) = 1-y(1).*y(2);

%dx/dt=-vx+zy;
%dy/dt=-vy+(z-a)x;
%dz/dt=1-xy;
