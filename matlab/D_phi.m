%options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-5]);
%[T,Y] = ode45(@rigid,[0 12],[0 1 1],options);

function dy=D_phi(t,y,par)
%function dYY=D_phi(t,YY,par)
dy = zeros(3,1);    % a column vector, y3=a
%dYY = zeros(3,1);
%%for i = 1:length(t) % allow for a to be a vector.  Loop through it
dy(1) = y(2); % y1'=y2
dy(2) = -3*Hubble(y(1),y(2),y(3), par)*y(2) - dV_dphi(y(1),par);
dy(3) = y(3)*Hubble(y(1),y(2),y(3), par); % y(3)=a, a'=aH
%dy(2) = -3*Hubble(YY(1),YY(2),YY(3), par)*YY(2) - dV_dphi(YY(1),par);
%YY(2)=log(10)*10.^t.*y(2);
%dYY(1)=YY(2);
%dYY(2)=10.^t(i)*log(10)*dy(2) + log(10)*YY(2);
%dYY(3) = YY(3)*Hubble(YY(1),YY(2),YY(3), par); % a

%[T,Y] = ode45(@(t,y)D_phi,[0 300],[par.phi0 sqrt(2*Vphi(par.phi0,par)) 1]);
%%end