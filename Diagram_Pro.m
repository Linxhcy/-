clc;clear;close all
c=3*10^5;
Mpc=10^6*3.26;%单位取光年
H0_r=70/Mpc;
H0_t=70/(Mpc*3*10^5);
syms z;
r = @(z) c./(H0_r.*(0.3.*(1+z).^3+0.00001.*(1+z).^4+0.7).^0.5);
t = @(z) 1./((1+z).*H0_t.*(0.3.*(1+z).^3+0.00001.*(1+z).^4+0.7).^0.5);

% 画图x-z
z0=[0:0.1:1,1.2:0.2:3,4:15,25:25:100,200:100:400,500:300:1100];
X=[];T=[];
for i=1:length(z0)
    X=[X,integral(r,0,z0(i))];
end
for i=1:length(z0)
    T=[T,integral(t,0,z0(i))];
end
X=X/1e08;T=T/1e08;
Lx=length(T); Sc_x=[T(1):T(Lx)/10:T(Lx)]; LS=length(Sc_x);
for i=1:LS
    y_makima(i)=interp1(T,X,Sc_x(i),'makima');
end

figure(1);
subplot(2,2,1)
plot(z0,X)
title('X-z')
xlabel('红移(z)/hz')
ylabel('距离(X)/亿光年')

subplot(2,2,2)
plot(z0,T)
title('T-z')
xlabel('红移(z)/hz')
ylabel('年龄(T)/亿年')

subplot(2,2,3)
plot(X,T)
title('X-T')
xlabel('距离(X)/亿光年')
ylabel('年龄(T)/亿年')

figure(2);
plot(Sc_x,y_makima,'*r');
hold on;
plot(T,X,'*b')
xlabel('距离(X)/亿光年')
ylabel('年龄(T)/亿年')


%等值线
figure(3)
theta = 0:0.01:2*pi;
for i=1:11
    a = size(theta); 
    rho = y_makima(i) * ones(a);
    polarplot(theta,rho);
    hold on;
end

pax = gca;
pax.RLim = [0 470];
pax.ThetaGrid = 'on';
pax.ThetaTick=[0];
pax.ThetaTickLabel = {'距离/亿光年'};
rticklabels({'','100亿光年','200亿光年','300亿光年','400亿光年'});
pax.ThetaAxisUnits = 'degrees';
pax.GridAlpha = 0.1;
pax.GridLineStyle = '--';
