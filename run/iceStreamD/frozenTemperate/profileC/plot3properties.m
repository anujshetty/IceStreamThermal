clear all
clc
load ../../profileVelData.mat
load data

subplot(3,3,2)
plot(y(1:m)/1000,3.1557e7*u(m*n-m+1:m*n),'k','LineWidth',2)
hold on
plot(-profileC(:,1)+20,profileC(:,2),'r.','Markers',10)
ylabel('Surface Velocity [m/yr]')
axis([0 40 0 600])

subplot(3,3,5)
hold on
h = plot(y(1:m)/1000,-(tau_base(1:m)./(Z*rho*g*sin(alpha))),'--',...
         y(1:m)/1000,ones(m,1),'--','LineWidth',2);
set(h(1),'color',[0.7,0.7,0.7])
set(h(2),'color',[0.7,0.7,0.7])
plot(y(1:m)/1000,-(mu(1:m)./(Z*rho*g*sin(alpha))).*(u(1:m)-u(m+1:2*m))/dz,'k','LineWidth',2)
axis([0 40 0 20])
ylabel('Normalized Basal Stress')
box on

subplot(3,3,8)
plotTemperatureField(m,nT,y,zT,T,T_m)
colorbar off
set(findall(gcf,'-property','FontSize'),'FontSize',16);
set(gcf,'color','w');