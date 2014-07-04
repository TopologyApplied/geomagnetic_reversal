%Final Project @ Chaos
%Author:Renjun Xu
%Date: 03/18/2009

clc; close all; clear all;
%Rikitake model for geomagnetic reversals
%dx/dt=-vx+zy;
%dy/dt=-vy+(z-a)x;
%dz/dt=1-xy;
dt=.001;

t1=1; %1e-18;
t2=300; 
t=linspace(t1,t2);
par.t0 = t1;
delta_x0 = 1e-3;
delta_y0 = 1e-3;
delta_z0 = 1e-3;

for v0=[0.1,0.3,0.9,1,1.2,2,10,20,50,100,160,200,400]
    for a0=[0.1,0.5,1,2,10,100,1000]
        for z0=[0,0.1,-0.1,1,-1,2,-2,10,-10,50,-50]
            for y0=[0,0.1,-0.1,1,-1,2,-2,10,-10,50,-50]
                for x0=[0,0.1,1,2,10,50]
    par.v=v0;
    par.a=a0;
    
    par.x0 = x0;
    par.y0 = y0;
    par.z0 = z0;

%par.x0 = 50*randn;
%par.y0 = 50*randn;
%par.z0 = 50*randn;

options = odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5 1e-5],'Refine',4);
%[T,Y] = ode45(@(t,y)dr_dt(t,y,par),[t1 t2],[par.x0 par.y0 par.z0]);
[T,Y] = ode45(@(t,y)dr_dt(t,y,par),[t1 t2],[par.x0 par.y0 par.z0],options);
length_T1=floor(0.1*length(T));
length_T=floor(0.8*length(T));
figure(1);
plot3(Y(1:1,1),Y(1:1,2),Y(1:1,3),'*g',mean(Y(length_T:end,1)),mean(Y(length_T:end,2)),mean(Y(length_T:end,3)),'pb',Y(1:length_T1,1),Y(1:length_T1,2),Y(1:length_T1,3),':k',Y(length_T1:end,1),Y(length_T1:end,2),Y(length_T1:end,3),'--r',Y(length_T1:length_T1,1),Y(length_T1:length_T1,2),Y(length_T1:length_T1,3),'>k','LineWidth',1)
legend('Initial Condition','Attractor','Initial Trajectory','Long-term Trajectory')
xlabel('x');
ylabel('y');
zlabel('z');
%annotation('arrow',Y(length_T1:3:length_T1+3,1),Y(length_T1:3:length_T1+3,2),Y(length_T1:3:length_T1+3,3));
%plot(T(10:end),Y(10:end,3),'-b','LineWidth',3)
%xlim([t1,t2])
%xlabel('t');
%ylabel('$$ \delta_H $$','Interpreter','latex');
%title({'\bf Final Project:  Rikitake model for geomagnetic reversals';'(by Renjun Xu)'})
%title({'\bf Final Project: Rikitake model for geomagnetic reversals',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],'(by Renjun Xu)'})

%title(['x_0=',num2str(par.x0)])
%legend('log(a(t))')

%[T3,Res]=lyapunov(3,@riktake,@ode45,0,0.5,200,[0 1 0],10);
%plot(T3,Res);
%title('Dynamics of Lyapunov exponents');
%xlabel('Time'); 
%ylabel('Lyapunov exponents');


[T2,Y2] = ode45(@(t,y)dr_dt(t,y,par),[t1 t2],[par.x0+delta_x0 par.y0+delta_y0 par.z0+delta_z0]);
%length_T2=floor(0.8*length(T));
delta_0=sqrt(delta_x0^2+delta_y0^2+delta_z0^2);
delta_t2=sqrt((Y2(end,1)-Y(end,1)).^2+(Y2(end,2)-Y(end,2)).^2+(Y2(end,3)-Y(end,3)).^2);
%delta_t=sqrt((Y2(:,1)-Y(:,1)).^2+(Y2(:,2)-Y(:,2)).^2+(Y2(:,3)-Y(:,3)).^2);
%lambda_Liapunov=log(delta_t/delta_0)/T;
lambda_Liapunov=log(delta_t2/delta_0)/t2;
fprintf('The largest Lyapunov Exponent=%10.6f\n',lambda_Liapunov); 
title({'\bf Final Project: Rikitake model for geomagnetic reversals -- 3D dynamics',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],['(the largest Liapunov exponent: ',num2str(lambda_Liapunov), ', by Renjun Xu)']})
grid on

filename=[num2str(v0),'_a=',num2str(a0),'_Lyap=',num2str(lambda_Liapunov),'_(',num2str(x0),',',num2str(y0),',',num2str(z0)];
%fid = fopen(['Riktake_',filename,'.txt'], 'w');
%fprintf(fid, '%10.6f\n', lambda_Liapunov);
%fclose(fid)

figure(2)
plot(T(1),Y(1,1),'*g',mean(T(length_T:end)),mean(Y(length_T:end,1)),'pb',T(1:length_T1),Y(1:length_T1,1),'-.k',T(length_T1:end),Y(length_T1:end,1),'-b',T(length_T1:length_T1),Y(length_T1:length_T1,1),'>k','LineWidth',1)
xlabel('t');
ylabel('x');
title({'\bf Final Project: Rikitake model for geomagnetic reversals --x(t)',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],['(the largest Liapunov exponent: ',num2str(lambda_Liapunov), ', by Renjun Xu)']})
grid on

figure(3)
plot(T(1),Y(1,2),'*g',mean(T(length_T:end)),mean(Y(length_T:end,2)),'pb',T(1:length_T1),Y(1:length_T1,2),'-.k',T(length_T1:end),Y(length_T1:end,2),'-b',T(length_T1:length_T1),Y(length_T1:length_T1,2),'>k','LineWidth',1)
xlabel('t');
ylabel('y');
title({'\bf Final Project: Rikitake model for geomagnetic reversals --y(t)',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],['(the largest Liapunov exponent: ',num2str(lambda_Liapunov), ', by Renjun Xu)']})
grid on

figure(4)
plot(T(1),Y(1,3),'*g',mean(T(length_T:end)),mean(Y(length_T:end,3)),'pb',T(1:length_T1),Y(1:length_T1,3),'-.k',T(length_T1:end),Y(length_T1:end,3),'-b',T(length_T1:length_T1),Y(length_T1:length_T1,3),'>k','LineWidth',1)
xlabel('t');
ylabel('z');
title({'\bf Final Project: Rikitake model for geomagnetic reversals --z(t)',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],['(the largest Liapunov exponent: ',num2str(lambda_Liapunov), ', by Renjun Xu)']})
grid on

figure(5)
plot(Y(1,1),Y(1,3),'*g',mean(Y(length_T:end,1)),mean(Y(length_T:end,3)),'pb',Y(1:length_T1,1),Y(1:length_T1,3),'-.k',Y(length_T1:end,1),Y(length_T1:end,3),'-b',Y(length_T1:length_T1,1),Y(length_T1:length_T1,3),'>k','LineWidth',1)
xlabel('x');
ylabel('z');
title({'\bf Final Project: Rikitake model for geomagnetic reversals --z(x)',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],['(the largest Liapunov exponent: ',num2str(lambda_Liapunov), ', by Renjun Xu)']})
grid on

figure(6)
plot(Y(1,2),Y(1,3),'*g',mean(Y(length_T:end,2)),mean(Y(length_T:end,3)),'pb',Y(1:length_T1,2),Y(1:length_T1,3),'-.k',Y(length_T1:end,2),Y(length_T1:end,3),'-b',Y(length_T1:length_T1,2),Y(length_T1:length_T1,3),'>k','LineWidth',1)
xlabel('y');
ylabel('z');
title({'\bf Final Project: Rikitake model for geomagnetic reversals --z(y)',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],['(the largest Liapunov exponent: ',num2str(lambda_Liapunov), ', by Renjun Xu)']})
grid on

figure(7)
plot(Y(1,1),Y(1,2),'*g',mean(Y(length_T:end,1)),mean(Y(length_T:end,2)),'pb',Y(1:length_T1,1),Y(1:length_T1,2),'-.k',Y(length_T1:end,1),Y(length_T1:end,2),'-b',Y(length_T1:length_T1,1),Y(length_T1:length_T1,2),'>k','LineWidth',1)
xlabel('x');
ylabel('y');
title({'\bf Final Project: Rikitake model for geomagnetic reversals --y(x)',['evolution begin->(',num2str(par.x0),',',num2str(par.y0),',',num2str(par.z0),'),v=',num2str(par.v),',a=',num2str(par.a)],['(the largest Liapunov exponent: ',num2str(lambda_Liapunov), ', by Renjun Xu)']})
grid on


filename_3d = ['Riktake_3d_v=',filename];
filename_x = ['Riktake_x(t)_v=',filename];
filename_y = ['Riktake_y(t)_v=',filename];
filename_z = ['Riktake_z(t)_v=',filename];
filename_zx = ['Riktake_z(x)_v=',filename];
filename_zy = ['Riktake_z(y)_v=',filename];
filename_yx = ['Riktake_y(x)_v=',filename];

print('-f1','-depsc2',[filename_3d,'.eps']);
print('-f2','-depsc2',[filename_x,'.eps']);
print('-f3','-depsc2',[filename_y,'.eps']);
print('-f4','-depsc2',[filename_z,'.eps']);
print('-f5','-depsc2',[filename_zx,'.eps']);
print('-f6','-depsc2',[filename_zy,'.eps']);
print('-f7','-depsc2',[filename_yx,'.eps']);

                end
            end
        end
    end
end
